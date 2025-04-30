// öğrenci bilgileri ile ilgili işlemleri yöneten controller
const db = require("../config/db"); // Veritabanı bağlantısı


exports.getInfoStudent = (req, res) => {
    const user_id = req.user.user_id;
    
    
    const query = `
        WITH agno_calc AS (
    SELECT 
        s.student_id,
        sp.prog_id,
        ROUND(SUM(
            CASE e.letter_grade
                WHEN 'AA' THEN 4.0
                WHEN 'BA' THEN 3.5
                WHEN 'BB' THEN 3.0
                WHEN 'CB' THEN 2.5
                WHEN 'CC' THEN 2.0
                WHEN 'DC' THEN 1.5
                WHEN 'DD' THEN 1.0
                ELSE 0.0
            END * c.class_credit
        ) / SUM(c.class_credit), 2) AS agno
    FROM student s
    JOIN student_program sp ON s.student_id = sp.student_id
    JOIN enrollments e ON s.student_id = e.student_id
    JOIN classgroup cg ON e.group_id = cg.group_id
    JOIN classes c ON cg.class_id = c.class_id
    WHERE e.enro_status IN ('Aktif', 'Mezun')
    GROUP BY s.student_id, sp.prog_id
),
ranked AS (
    SELECT 
        student_id,
        prog_id,
        agno,
        RANK() OVER (PARTITION BY prog_id ORDER BY agno DESC) AS sira,
        COUNT(*) OVER (PARTITION BY prog_id) AS toplam
    FROM agno_calc
)
SELECT 
    u.email,
    u.registered,
    s.tc,
    s.name,
    s.surname,
    u.username,
    f.fac_name,
    p.prog_name,
    ts.level,
    r.reg_type,
    ss.sship_type,
    CONCAT(ad.adv_name, ' ', ad.adv_surname) AS advisor_name,
    CONCAT(b.building_name, ' ', o.office_code) AS office,
    ad.adv_tel,
    ad.adv_email,
    CONCAT(rk.sira, '/', rk.toplam) AS siralama,
    rk.agno AS agno
FROM student s
JOIN user u ON s.user_id = u.user_id
JOIN registration r ON s.reg_id = r.reg_id
JOIN scholarship ss ON r.sship_id = ss.sship_id
JOIN term_stud ts ON s.student_id = ts.student_id
JOIN advisor ad ON s.adv_id = ad.adv_id
JOIN offices o ON ad.office_id = o.office_id
JOIN buildings b ON o.building_id = b.building_id
JOIN student_program sp ON s.student_id = sp.student_id
JOIN program p ON sp.prog_id = p.prog_id
JOIN faculty f ON p.fac_id = f.fac_id
JOIN ranked rk ON rk.student_id = s.student_id AND rk.prog_id = sp.prog_id
WHERE u.user_id = ?
ORDER BY rk.sira;

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