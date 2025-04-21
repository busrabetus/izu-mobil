const express = require("express");
const router = express.Router();
const attendanceDetailController = require("../controllers/attendanceDetail");
const auth = require("../middleware/auth");

// Dersin devamsızlık detayları
router.get("/", auth, attendanceDetailController.getAttendanceDetail);


module.exports = router; 