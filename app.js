require("dotenv").config();
var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

const db = require("./config/db");

var indexRouter = require('./routes/index');

// Importing routes

const homePageRoutes = require("./routes/homePageRoutes");
const infoStudentRoutes = require("./routes/infoStudentRoutes");
const userRoutes = require("./routes/userRoutes");
const attendanceRoutes = require("./routes/attendanceRoutes");
const attendancedetailRoutes = require("./routes/attendanceDetailRoutes");
const courseScheduleRoutes = require("./routes/courseScheduleRoutes");
const classsesMaterialRoutes = require("./routes/classesMaterialRoutes");
const examResultsRoutes = require("./routes/examResultsRoutes");
const transcriptRoutes = require("./routes/transcriptRoutes");
const examScheduleRoutes = require("./routes/examScheduleRoutes");
var app = express();



app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);

// Using routes

app.use("/api/homepage", homePageRoutes);
app.use("/api/user", userRoutes);
app.use("/api/studentinfo", infoStudentRoutes);
app.use("/api/attendance", attendanceRoutes);
app.use("/api/attendance/detail", attendancedetailRoutes);
app.use("/api/courseSchedule", courseScheduleRoutes);
app.use("/api/classsesMaterial", classsesMaterialRoutes);
app.use("/api/examResults", examResultsRoutes);
app.use("/api/transcript", transcriptRoutes);
app.use("/api/examSchedule", examScheduleRoutes);


// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.send('error');
});


module.exports = app;
