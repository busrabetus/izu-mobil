const express = require("express");
const router = express.Router();
const homepage = require("../controllers/home_page.js");
const auth = require("../middleware/auth");

router.get("/",auth,homepage.getHomePage);




module.exports = router;