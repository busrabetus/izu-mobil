const express = require("express");
const router = express.Router();
const attendanceController = require("../controllers/attendance");
const auth = require("../middleware/auth");

// Tüm dersler için devamsızlık özeti
router.get("/", auth, attendanceController.getAttendanceSummary);

// Devamsızlık detayları için route
router.get("/details/:classId", auth, attendanceController.getAttendanceDetails);

module.exports = router; 