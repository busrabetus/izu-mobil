const db = require("../config/db");

exports.getClassesMaterial = (req, res) => {
  const user_id = req.user?.user_id;
  const term_id = Number(req.query.term_id);


  if (!user_id || !term_id) {
    return res.status(400).json({ message: "Kullanıcı ID veya Term ID eksik" });
  }

const query = `
  SELECT DISTINCT
    t.term_id        AS term_id,
    t.term_name      AS donem_adi,
    c.class_code     AS ders_kodu,
    c.class_name     AS ders_adi,
    CONCAT(a.ac_name, ' ', a.ac_surname) AS hoca
  FROM user u
  JOIN student s     ON u.user_id = s.user_id
  JOIN enrollments e ON s.student_id = e.student_id
  JOIN classgroup cg ON e.group_id = cg.group_id
  JOIN term t        ON cg.term_id = t.term_id
  JOIN classes c     ON cg.class_id = c.class_id
  JOIN academician a ON cg.ac_id = a.ac_id
  WHERE u.user_id = ?
    AND cg.term_id = ?
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
    res.status(200).json(results);
  });
};