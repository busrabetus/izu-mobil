// Devamsızlık işlemlerini yöneten controller
const db = require("../config/db"); // Veritabanı bağlantısı

// Tüm dersler için devamsızlık özeti
exports.getAttendanceSummary = (req, res) => {
    const user_id = req.user.user_id;
    const term_id = req.query.term_id; 
    
    if (!term_id) {
        return res.status(400).json({ error: "term_id parametresi eksik" });
    }

    const query = `
        SELECT 
    c.class_name AS ders_adi,
    ROUND((SUM(p.presence_count) / SUM(p.presence_max)) * 100, 2) AS devamsizlik_orani
FROM user u
JOIN student s ON u.user_id = s.user_id
JOIN enrollments e ON s.student_id = e.student_id
JOIN classgroup cg ON e.group_id = cg.group_id
JOIN classes c ON cg.class_id = c.class_id
JOIN presence_student ps ON e.enro_id = ps.enro_id
JOIN presence p ON ps.presence_id = p.presence_id
WHERE u.user_id = ?
  AND cg.term_id = ? 
GROUP BY cg.term_id, s.student_id, c.class_id
ORDER BY c.class_name;
    `;

    db.query(query, [user_id, term_id], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }

        if (results.length === 0) {
            return res.status(404).json({ message: "Devamsızlık kaydı bulunamadı" });
        }

        res.status(200).json(results);
    });
};
