const express = require("express");
const router = express.Router();
const examScheduleController = require("../controllers/examSchedule");
const auth = require("../middleware/auth");

// sınav programı
router.get("/", auth, examScheduleController.getExamSchedule);


module.exports = router; 