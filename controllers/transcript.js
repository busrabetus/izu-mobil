const db = require("../config/db");

exports.getTranscript = (req, res) => {
  const user_id = req.user?.user_id;
  const term_id = Number(req.query.term_id);

  console.log("🔍 [TRANSCRIPT API] Kullanıcı ID:", user_id);
  console.log("🔍 [TRANSCRIPT API] Term ID:", term_id);
  console.log("🔍 [TRANSCRIPT API] Token Header:", req.headers.authorization);

  if (!user_id || !term_id) {
    return res.status(400).json({ message: "Kullanıcı ID veya Term ID eksik" });
  }

const query = `
  SELECT DISTINCT
    t.term_id        AS term_id,
    t.term_name      AS donem_adi,
    c.class_name     AS ders_adi,
    c.class_credit   AS akts,
    e.letter_grade   AS harf_notu
  FROM user u
  JOIN student s ON u.user_id = s.user_id
  JOIN term_stud ts ON s.student_id = ts.student_id
  JOIN term t       ON ts.term_id = t.term_id
  JOIN enrollments e ON s.student_id = e.student_id
  JOIN classgroup cg ON e.group_id = cg.group_id
  JOIN classes c     ON cg.class_id = c.class_id
  WHERE s.user_id = ?
    AND cg.term_id = ?
    AND e.group_id = cg.group_id
  GROUP BY c.class_name
  ORDER BY c.class_name;
`;


  db.query(query, [user_id, term_id], (err, results) => {
    if (err) {
      console.error("❌ MySQL Hatası:", err.message);
      return res.status(500).json({ error: "Sunucu hatası: " + err.message });
    }

    if (results.length === 0) {
      console.warn("⚠️ Transkript verisi bulunamadı.");
      return res.status(404).json({ message: "Veri bulunamadı" });
    }

    console.log("✅ Transkript verisi başarıyla döndürüldü:", results);
    res.status(200).json(results);
  });
};