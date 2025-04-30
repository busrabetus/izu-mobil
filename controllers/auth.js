// 📌 Kullanıcı Kayıt (Register)
const bcrypt = require("bcrypt");
require("dotenv").config({ path: "./.env" });
const jwt = require("jsonwebtoken");
const db = require("../config/db");



exports.register = async (req, res) => {
    const { username, password } = req.body;



    const hashedPassword = await bcrypt.hash(password, 10);


    const registeredDate = new Date().toISOString().split("T")[0];

    if (!username || !password) {
        return res.status(400).json({ error: "Kullanıcı adı ve şifre gereklidir." });
    }

    const sql = `
        INSERT INTO user (username, passwordhash, verified, active, registered)
        VALUES (?, ?, ?, ?, ?);
    `;

    db.query(sql, [username, hashedPassword, false, true, registeredDate], (err, result) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }


        const token = jwt.sign({ user_id: result.insertId, username }, process.env.JWT_SECRET, {
            expiresIn: "1h",
        });

        res.status(201).json({
            message: "Kullanıcı başarıyla kaydedildi",
            user_id: result.insertId,
            username,
            registered: registeredDate,
            token,
        });
    });
};



// 📌 Kullanıcı Girişi (Login)


exports.login = (req, res) => {
    const { email, password } = req.body;

    const sql = "SELECT * FROM user WHERE email = ?";
    db.query(sql, [email], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });

        if (results.length === 0) {
            return res.status(401).json({ message: "Kullanıcı bulunamadı." });
        }

        const user = results[0];

        // Düz şifreyi bcrypt ile hash'leyip karşılaştırma
        bcrypt.compare(password, user.passwordhash, (err, isMatch) => {
            if (err) return res.status(500).json({ error: err.message });

            if (!isMatch) {
                return res.status(401).json({ message: "Geçersiz şifre!" });
            }

            const token = jwt.sign(
                { user_id: user.user_id, username: user.username },
                process.env.JWT_SECRET,
                { expiresIn: "1h" }
            );

            res.status(200).json({
                message: "Giriş başarılı!",
                token,
                user_id: user.user_id,
                username: user.username
            });
        });
    });
};


exports.logout = (req, res) => {
    
    res.status(200).json({ message: "Başarıyla çıkış yapıldı" });
};

