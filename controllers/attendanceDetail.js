// Devamsızlık işlemlerini yöneten controller
const db = require("../config/db"); // Veritabanı bağlantısı

// Belirli bir ders ve dönem için devamsızlık detayları
exports.getAttendanceDetail = (req, res) => {
    const user_id = req.user.user_id;
    const term_id = req.query.term_id;
    const class_name = req.query.class_name;

    if (!term_id || !class_name) {
        return res.status(400).json({ error: "term_id ve class_name parametreleri gereklidir." });
    }

    const query = `
        SELECT 
            p.presence_date as devamsizlik_tarihi,
            c.class_name as ders_adi,
            p.presence_count as katilim_saati,
            p.presence_max as toplam_saati
        FROM user u
        JOIN student s ON u.user_id = s.user_id
        JOIN term_stud ts ON s.student_id = ts.student_id
        JOIN term t ON ts.term_id = t.term_id
        JOIN enrollments e ON s.student_id = e.student_id
        JOIN classgroup cg ON e.group_id = cg.group_id
        JOIN classes c ON cg.class_id = c.class_id
        JOIN presence_student ps ON e.enro_id = ps.enro_id
        JOIN presence p ON ps.presence_id = p.presence_id
        WHERE u.user_id = ? AND t.term_id = ? AND c.class_name = ?
        ORDER BY p.presence_date;
    `;
    
    db.query(query, [user_id, term_id, class_name], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }

        if (results.length === 0) {
            return res.status(404).json({ message: "Devamsızlık kaydı bulunamadı" });
        }

        res.status(200).json(results);
    });
};
