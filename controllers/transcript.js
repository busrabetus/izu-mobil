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
        ROW_NUMBER() OVER (
            PARTITION BY u.user_id 
            ORDER BY t.term_start
        ) AS yariyil_no
    FROM user u
    JOIN student s     ON u.user_id = s.user_id
    JOIN term_stud ts  ON s.student_id = ts.student_id
    JOIN term t        ON ts.term_id = t.term_id
    WHERE u.user_id = ?
      AND t.term_name NOT LIKE '%Yaz%'
),

agirlikli_notlar AS (
    SELECT 
        e.enro_id,
        e.student_id,
        SUM(g.score * g.percentage / 100) AS toplam_ortalama
    FROM enrollments e
    JOIN grade_class gc ON e.enro_id = gc.enro_id
    JOIN grades g       ON gc.grade_id = g.grade_id
    GROUP BY e.enro_id, e.student_id
)

SELECT 
    od.term_name           AS donem_adi,
    od.yariyil_no          AS yariyil,
    c.class_name           AS ders_adi,
    c.class_credit         AS akts,
    an.toplam_ortalama     AS ortalama,
    
    CASE
        WHEN an.toplam_ortalama >= 90 THEN 'AA'
        WHEN an.toplam_ortalama >= 85 THEN 'BA'
        WHEN an.toplam_ortalama >= 80 THEN 'BB'
        WHEN an.toplam_ortalama >= 75 THEN 'CB'
        WHEN an.toplam_ortalama >= 70 THEN 'CC'
        WHEN an.toplam_ortalama >= 65 THEN 'DC'
        WHEN an.toplam_ortalama >= 60 THEN 'DD'
        WHEN an.toplam_ortalama >= 50 THEN 'FD'
        ELSE 'FF'
    END AS harf_notu

FROM ogrenci_donemleri od
JOIN term_stud ts     ON ts.term_id = od.term_id
JOIN student s        ON ts.student_id = s.student_id
JOIN enrollments e    ON s.student_id = e.student_id
JOIN classgroup cg    ON e.group_id = cg.group_id
JOIN classes c        ON cg.class_id = c.class_id
JOIN agirlikli_notlar an ON an.enro_id = e.enro_id AND an.student_id = s.student_id
WHERE od.user_id = ? 
  AND e.enro_date BETWEEN od.term_start AND DATE_ADD(od.term_start, INTERVAL 6 MONTH);

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
