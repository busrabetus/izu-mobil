const db = require("../config/db"); // Veritabanı bağlantısı

// transcript işlemlerini yöneten controller
exports.getTranscript = (req, res) => {
    const user_id = req.user.user_id;
    

    const query = `
    WITH ogrenci_donemleri AS (
    SELECT 
        u.user_id,
        t.term_id,
        t.term_name,
        t.term_start,
        t.term_end,
        ROW_NUMBER() OVER (
            PARTITION BY u.user_id 
            ORDER BY t.term_start
        ) AS yariyil_no
    FROM user u
    JOIN student s    ON u.user_id = s.user_id
    JOIN term_stud ts ON s.student_id = ts.student_id
    JOIN term t       ON ts.term_id = t.term_id
    WHERE u.user_id = ?
      AND t.term_name NOT LIKE '%Yaz%'
)

SELECT 
    od.term_name      AS donem_adi,
    od.yariyil_no     AS yariyil,
    c.class_name      AS ders_adi,
    c.class_credit    AS akts,
    e.letter_grade    AS harf_notu
FROM ogrenci_donemleri od
JOIN term_stud ts    ON ts.term_id = od.term_id
JOIN student s       ON ts.student_id = s.student_id
JOIN enrollments e   ON s.student_id = e.student_id
JOIN classgroup cg   ON e.group_id = cg.group_id
JOIN classes c       ON cg.class_id = c.class_id
WHERE od.user_id = ?
  AND e.enro_date BETWEEN od.term_start AND od.term_end
ORDER BY od.yariyil_no, c.class_name;


    `;
    
    db.query(query, [user_id,user_id], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }

        if (results.length === 0) {
            return res.status(404).json({ message: "Transcript sonucları bulunamadi" });
        }

        res.status(200).json(results);
    });
};
