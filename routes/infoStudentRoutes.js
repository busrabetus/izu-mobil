const express = require("express");
const router = express.Router();
const infoStudent = require("../controllers/info_Student");
const auth = require("../middleware/auth");

router.get("/",auth,infoStudent.getInfoStudent);

module.exports = router;