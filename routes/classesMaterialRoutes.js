const express = require("express");
const router = express.Router();
const classsesMaterial = require("../controllers/classesMaterial");
const auth = require("../middleware/auth");

// Tüm dersler için devamsızlık özeti
router.get("/", auth, classsesMaterial.getClassesMaterial);


module.exports = router; 