exports.getTranscript = (req, res) => {
    const user_id = req.user.user_id;
    const term_id = req.query.term_id;

    const query = `
      SELECT
        t.term_name      AS donem_adi,
        c.class_name     AS ders_adi,
        c.class_credit   AS akts,
        e.letter_grade   AS harf_notu
      FROM student s
      JOIN term_stud ts ON s.student_id = ts.student_id
      JOIN term t       ON ts.term_id = t.term_id
      JOIN enrollments e ON s.student_id = e.student_id
      JOIN classgroup cg ON e.group_id = cg.group_id
      JOIN classes c     ON cg.class_id = c.class_id
      WHERE s.user_id = ?
        AND cg.term_id = ?
      ORDER BY t.term_start, c.class_name;
    `;

    db.query(query, [user_id, term_id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        if (results.length === 0) return res.status(404).json({ message: "Veri bulunamadı" });

        res.status(200).json(results);
    });
};
