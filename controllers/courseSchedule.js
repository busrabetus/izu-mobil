const db = require("../config/db"); // Veritabanı bağlantısı

// Ders programı bilgilerini getiren controller
exports.getSchedule = (req, res) => {
    const user_id = req.user.user_id;
    const term_id = req.query.term_id; // Dönem ID'si
    
    
    if (!term_id ) {
        return res.status(400).json({ error: "term_id  parametresi gereklidir." });
    }

    const query = `
        SELECT 
    c.class_name AS ders_adi,
    c.class_code AS ders_kodu,
    cg_time.day AS gun,
    cg_time.start_time AS baslangic_saati,
    cg_time.end_time AS bitis_saati,
    r.room_name AS konum,
    b.building_name AS bina
FROM user u
JOIN student s ON u.user_id = s.user_id
JOIN term_stud ts ON s.student_id = ts.student_id
JOIN term t ON ts.term_id = t.term_id
JOIN enrollments e ON s.student_id = e.student_id
JOIN classgroup cg ON e.group_id = cg.group_id
JOIN classes c ON cg.class_id = c.class_id
JOIN classgroup_time cg_time ON cg.group_id = cg_time.group_id
JOIN classroom r ON cg.room_id = r.room_id
JOIN buildings b ON r.building_id = b.building_id
WHERE u.user_id = ?
AND t.term_id = ?
ORDER BY cg_time.start_time;
    `;

    db.query(query, [user_id, term_id], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }

        if (results.length === 0) {
            return res.status(404).json({ message: "Ders programı bulunamadı" });
        }

        res.status(200).json(results);
    });
};
