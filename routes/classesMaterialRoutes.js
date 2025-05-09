const express = require("express");
const router = express.Router();
const classesMaterial = require("../controllers/classesMaterial");
const auth = require("../middleware/auth");

// Tüm dersler için devamsızlık özeti
router.get("/", auth, classesMaterial.getClassesMaterial);


module.exports = router; 