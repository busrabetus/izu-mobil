const express = require("express");
const router = express.Router();
const transcriptController = require("../controllers/transcript");
const auth = require("../middleware/auth");

// Dersin devamsızlık detayları
router.get("/", auth, transcriptController.getTranscript);


module.exports = router; 