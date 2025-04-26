const db = require("../config/db"); // Veritabanı bağlantısı

// sınav sonuçlarını yöneten controller
exports.getExamResults = (req, res) => {
    const user_id = req.user.user_id;
    const term_id = req.query.term_id;

    const query = `
    SELECT 
    cls.class_name     AS ders_adi,
    ex.exam_type       AS sinav_turu,
    g.score            AS puan,
    g.percentage       AS yuzdelik
FROM user u
JOIN student s         ON u.user_id = s.user_id
JOIN term_stud ts      ON s.student_id = ts.student_id
JOIN enrollments e     ON s.student_id = e.student_id
JOIN classgroup cg     ON e.group_id = cg.group_id
JOIN classes cls       ON cg.class_id = cls.class_id
JOIN grade_class gc    ON e.enro_id = gc.enro_id
JOIN grades g          ON gc.grade_id = g.grade_id
JOIN exam ex           ON cg.exam_id = ex.exam_id
WHERE u.user_id = ? AND ts.term_id = ?
ORDER BY cls.class_name, ex.exam_type;

    `;
    
    db.query(query, [user_id, term_id], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }

        if (results.length === 0) {
            return res.status(404).json({ message: "Sinav sonucları bulunamadi" });
        }

        res.status(200).json(results);
    });
};
