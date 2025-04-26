const db = require("../config/db"); // Veritabanı bağlantısı

// Ders materyallerini yöneten controller
exports.getClassesMaterial = (req, res) => {
    const user_id = req.user.user_id;
    const term_id = req.query.term_id;

    const query = `
    SELECT 
    c.class_code AS ders_kodu,
    c.class_name AS ders_adi,
    CONCAT(a.ac_name, ' ', a.ac_surname) AS hoca
FROM user u
JOIN student s ON u.user_id = s.user_id
JOIN term_stud ts ON s.student_id = ts.student_id
JOIN term t ON ts.term_id = t.term_id
JOIN enrollments e ON s.student_id = e.student_id
JOIN classgroup cg ON e.group_id = cg.group_id
JOIN classes c ON cg.class_id = c.class_id
JOIN academician a ON cg.ac_id = a.ac_id
WHERE u.user_id = ? 
  AND t.term_id = ?
ORDER BY c.class_name;
    `;
    
    db.query(query, [user_id, term_id], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }

        if (results.length === 0) {
            return res.status(404).json({ message: "Ders Materiali bulunamadi" });
        }

        res.status(200).json(results);
    });
};
