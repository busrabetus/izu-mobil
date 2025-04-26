// Ana sayfa ile ilgili işlemleri yöneten controller
const db = require("../config/db"); // Veritabanı bağlantısı


exports.getHomePage = (req, res) => {
    const user_id = req.user.user_id;
    
    
    const query = `
        SELECT 
            s.student_id,
            CONCAT(s.name, ' ', s.surname) AS student_name,
            f.fac_name,
            p.prog_name,
            ROUND(SUM(
                CASE
                    WHEN g.score >= 90 THEN 4.0
                    WHEN g.score >= 85 THEN 3.5
                    WHEN g.score >= 80 THEN 3.0
                    WHEN g.score >= 75 THEN 2.5
                    WHEN g.score >= 70 THEN 2.0
                    WHEN g.score >= 65 THEN 1.5
                    WHEN g.score >= 60 THEN 1.0
                    ELSE 0.0
                END * c.class_credit
            ) / SUM(c.class_credit), 2) AS agno
        FROM student s
        JOIN user u ON u.user_id = s.user_id
        JOIN enrollments e ON e.student_id = s.student_id
        JOIN classgroup cg ON cg.group_id = e.group_id
        JOIN classes c ON c.class_id = cg.class_id
        JOIN grade_class gc ON gc.enro_id = e.enro_id
        JOIN grades g ON g.grade_id = gc.grade_id
        JOIN student_program sp ON s.student_id = sp.student_id
        JOIN program p ON p.prog_id = sp.prog_id
        JOIN faculty f ON f.fac_id = p.fac_id
        WHERE s.user_id = ?
        GROUP BY s.student_id, s.name, f.fac_name, p.prog_name
    `;
    
    db.query(query, [user_id], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        
        if (results.length === 0) {
            return res.status(404).json({ message: "Öğrenci bilgileri bulunamadı" });
        }
        
        res.status(200).json(results[0]);
    });
};