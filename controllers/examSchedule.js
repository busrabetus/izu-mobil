const db = require("../config/db"); // Veritabanı bağlantısı

// sınav tarihlerini yöneten controller
exports.getExamSchedule = (req, res) => {
    const user_id = req.user.user_id;
    const term_id = req.query.term_id;

    const query = `
    SELECT DISTINCT
    cls.class_name AS ders_adi,
    ex.exam_type AS sinav_turu,
    ex.date AS sinav_tarihi,
    ex.start_time AS baslangic_saati,
    ex.end_time AS bitis_saati,
    CONCAT(b.building_name, ' ', cr.room_name) AS sinav_konumu
FROM user u
JOIN student s ON u.user_id = s.user_id
JOIN term_stud ts ON s.student_id = ts.student_id
JOIN term t ON ts.term_id = t.term_id
JOIN enrollments e ON s.student_id = e.student_id
JOIN classgroup cg ON e.group_id = cg.group_id
JOIN exam ex ON cg.group_id = ex.group_id  -- BURADA DÜZELTTİM!
JOIN classes cls ON cg.class_id = cls.class_id
JOIN classroom cr ON ex.room_id = cr.room_id
JOIN buildings b ON cr.building_id = b.building_id
WHERE u.user_id = ? 
  AND cg.term_id = ?
ORDER BY ex.date, ex.start_time;

    `;
    
    db.query(query, [user_id, term_id], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }

        if (results.length === 0) {
            return res.status(404).json({ message: "Sinav tarihleri bulunamadi" });
        }

        res.status(200).json(results);
    });
};
