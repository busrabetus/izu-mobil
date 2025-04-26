const express = require("express");
const router = express.Router();
const auth = require("../controllers/auth.js");
const authMiddleware = require("../middleware/auth");

router.post("/reg", auth.register);
router.post("/login", auth.login);
router.post("/logout", authMiddleware, auth.logout);


module.exports = router;