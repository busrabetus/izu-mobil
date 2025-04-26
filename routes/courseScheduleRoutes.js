const express = require("express");
const router = express.Router();
const courseScheduleController = require("../controllers/courseSchedule");
const auth = require("../middleware/auth");

// Ders programı 
router.get("/", auth, courseScheduleController.getSchedule);


module.exports = router; 