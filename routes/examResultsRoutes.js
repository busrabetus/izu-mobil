const express = require("express");
const router = express.Router();
const examResultsController = require("../controllers/examResults");
const auth = require("../middleware/auth");


router.get("/", auth, examResultsController.getExamResults);


module.exports = router; 