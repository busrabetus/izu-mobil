var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.send('Mobil KBS API\'sine hoşgeldiniz!');
});

module.exports = router;
