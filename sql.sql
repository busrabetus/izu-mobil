-- ************************************** `buildings`
CREATE TABLE IF NOT EXISTS `buildings` (
 `building_id`   INT NOT NULL AUTO_INCREMENT,
 `building_name` VARCHAR(45) NOT NULL,
 PRIMARY KEY (`building_id`)
);

-- ************************************** `offices`
CREATE TABLE IF NOT EXISTS `offices` (
 `office_id`   INT NOT NULL AUTO_INCREMENT,
 `office_code` VARCHAR(10) NOT NULL,
 `building_id` INT NOT NULL,
 PRIMARY KEY (`office_id`),
 CONSTRAINT `FK_offices_building` FOREIGN KEY (`building_id`) REFERENCES `buildings` (`building_id`)
);

-- ************************************** `faculty`
CREATE TABLE IF NOT EXISTS `faculty` (
 `fac_id`   INT NOT NULL AUTO_INCREMENT,
 `fac_name` VARCHAR(75) NOT NULL,
 PRIMARY KEY (`fac_id`)
);

-- ************************************** `program`
CREATE TABLE IF NOT EXISTS `program` (
 `prog_id`   INT NOT NULL AUTO_INCREMENT,
 `prog_name` VARCHAR(45) NOT NULL,
 `prog_lang` VARCHAR(45) NOT NULL,
 `fac_id`    INT NOT NULL,
 PRIMARY KEY (`prog_id`),
 CONSTRAINT `FK_program_faculty` FOREIGN KEY (`fac_id`) REFERENCES `faculty` (`fac_id`)
);

-- ************************************** `classes`
CREATE TABLE IF NOT EXISTS `classes` (
 `class_id`     INT NOT NULL AUTO_INCREMENT,
 `class_name`   VARCHAR(45) NOT NULL,
 `class_code`   VARCHAR(7) NOT NULL,
 `class_lang`   ENUM('TR','EN','AR') NOT NULL,
 `class_credit` NUMERIC(3,1) NOT NULL,
 `prog_id`      INT NOT NULL,
 `class_weekly` SMALLINT NOT NULL,
 PRIMARY KEY (`class_id`),
 CONSTRAINT `FK_classes_program` FOREIGN KEY (`prog_id`) REFERENCES `program` (`prog_id`)
);

-- ************************************** `classroom`
CREATE TABLE IF NOT EXISTS `classroom` (
 `room_id`     INT NOT NULL AUTO_INCREMENT,
 `room_name`   VARCHAR(45) NOT NULL,
 `room_code`   VARCHAR(45) NOT NULL,
 `building_id` INT NOT NULL,
 PRIMARY KEY (`room_id`),
 CONSTRAINT `FK_classroom_building` FOREIGN KEY (`building_id`) REFERENCES `buildings` (`building_id`)
);

-- ************************************** `academician`
CREATE TABLE IF NOT EXISTS `academician` (
 `ac_id`      INT NOT NULL AUTO_INCREMENT,
 `ac_name`    VARCHAR(45) NOT NULL,
 `ac_surname` VARCHAR(45) NOT NULL,
 `ac_title`   VARCHAR(45) NOT NULL,
 PRIMARY KEY (`ac_id`)
);

-- ************************************** `grades` 

CREATE TABLE IF NOT EXISTS `grades`
(
 `grade_id`   int NOT NULL AUTO_INCREMENT,
 `score`      decimal(5,2) NOT NULL ,
 `percentage` decimal(5,2) NOT NULL ,

PRIMARY KEY (`grade_id`)
);

-- ************************************** `term`
CREATE TABLE IF NOT EXISTS `term` (
 `term_id`    INT NOT NULL AUTO_INCREMENT,
 `term_name`  VARCHAR(45) NOT NULL,
 `term_start` DATE NOT NULL,
 `term_end`   DATE NOT NULL,
 PRIMARY KEY (`term_id`)
);


-- ************************************** `classgroup`
CREATE TABLE IF NOT EXISTS `classgroup` (
 `group_id` INT NOT NULL AUTO_INCREMENT,
 `class_id` INT NOT NULL,
 `room_id`  INT NOT NULL,
 `ac_id`    INT NOT NULL,
 `term_id`    INT NOT NULL,
 PRIMARY KEY (`group_id`),
 CONSTRAINT `FK_classgroup_class` FOREIGN KEY (`class_id`) REFERENCES `classes` (`class_id`),
 CONSTRAINT `FK_classgroup_room` FOREIGN KEY (`room_id`) REFERENCES `classroom` (`room_id`),
 CONSTRAINT `FK_classgroup_term` FOREIGN KEY (term_id) REFERENCES term (term_id),
 CONSTRAINT `FK_classgroup_academician` FOREIGN KEY (`ac_id`) REFERENCES `academician` (`ac_id`)
);

-- ************************************** `scholarship`
CREATE TABLE IF NOT EXISTS `scholarship` (
 `sship_id`   INT NOT NULL AUTO_INCREMENT,
 `sship_type` VARCHAR(45) NOT NULL,
 PRIMARY KEY (`sship_id`)
);

-- ************************************** `registration`
CREATE TABLE IF NOT EXISTS `registration` (
 `reg_id`   INT NOT NULL AUTO_INCREMENT,
 `reg_type` ENUM('YOS', 'OSS', 'YG') NOT NULL,
 `reg_date` DATETIME NOT NULL,
 `sship_id` INT NOT NULL,
 PRIMARY KEY (`reg_id`),
 CONSTRAINT `FK_registration_scholarship` FOREIGN KEY (`sship_id`) REFERENCES `scholarship` (`sship_id`)
);

-- ************************************** `advisor`
CREATE TABLE IF NOT EXISTS `advisor` (
 `adv_id`      INT NOT NULL AUTO_INCREMENT,
 `adv_name`    VARCHAR(45) NOT NULL,
 `adv_surname` VARCHAR(45) NOT NULL,
 `adv_hours`   VARCHAR(100) NOT NULL,
 `office_id`   INT NOT NULL,
 `adv_tel`     VARCHAR(14) NOT NULL,
 `adv_email`   varchar(60) NOT NULL,
 PRIMARY KEY (`adv_id`),
 CONSTRAINT `FK_advisor_office` FOREIGN KEY (`office_id`) REFERENCES `offices` (`office_id`)
);

-- ************************************** `user`
CREATE TABLE IF NOT EXISTS `user` (
 `user_id`      int NOT NULL ,
 `username`     varchar(255) NOT NULL ,
 `passwordhash` varchar(255) NOT NULL ,
 `verified`     boolean NOT NULL ,
 `active`       boolean NOT NULL ,
 `registered`   date NOT NULL ,
 `photo`        TEXT NOT NULL ,
 `email`        varchar(60) NOT NULL ,
 `phone`        varchar(11) NOT NULL ,

PRIMARY KEY (`user_id`)
);


-- ************************************** `student`
CREATE TABLE IF NOT EXISTS `student` (
 `student_id` INT NOT NULL AUTO_INCREMENT,
 `name`       VARCHAR(45) NOT NULL,
 `surname`    VARCHAR(45) NOT NULL,
 `tc`         VARCHAR(11) NOT NULL UNIQUE,
 `active`     BOOLEAN NOT NULL,
 `reg_id`     INT NOT NULL,
 `adv_id`     INT NOT NULL,
 `user_id`    INT NOT NULL,
 PRIMARY KEY (`student_id`),
 CONSTRAINT `FK_student_registration` FOREIGN KEY (`reg_id`) REFERENCES `registration` (`reg_id`),
 CONSTRAINT `FK_student_advisor` FOREIGN KEY (`adv_id`) REFERENCES `advisor` (`adv_id`),
 CONSTRAINT `FK_student_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
);

-- ************************************** `enrollments`

CREATE TABLE IF NOT EXISTS `enrollments`
(
 `enro_id`           int NOT NULL ,
 `student_id`        int NOT NULL ,
 `group_id`          int NOT NULL ,
 `enro_date`         datetime NOT NULL ,
 `enro_status`       ENUM('Aktif','Dondurulmus','Mezun','Birakti') NOT NULL,
 `letter_grade`      enum('AA','BA','BB','CB','CC','DC','DD','FD','FF') NOT NULL ,
 `letter_grade_date` date NOT NULL ,

PRIMARY KEY (`enro_id`),
UNIQUE KEY `unique_st` (`student_id`, `group_id`),
CONSTRAINT `FK_STD` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`),
CONSTRAINT `FK_GRP` FOREIGN KEY (`group_id`) REFERENCES `classgroup` (`group_id`)
);

-- ************************************** `exam`

CREATE TABLE IF NOT EXISTS `exam`
(
 `exam_id`    int NOT NULL ,
 `exam_type`  enum("vize","final","diger") NOT NULL ,
 `start_time` time NOT NULL ,
 `end_time`   time NOT NULL ,
 `date`       date NOT NULL ,
 `group_id`   int NOT NULL ,
 `room_id`    int NOT NULL ,
 `grade_id`   int NOT NULL ,
 `enro_id`    int NOT NULL ,
 `class_avg`  decimal(5,2) NOT NULL ,
 `announced`  date NOT NULL ,

PRIMARY KEY (`exam_id`),
CONSTRAINT `FK_ROOMEXAM` FOREIGN KEY (`room_id`) REFERENCES `classroom` (`room_id`),
CONSTRAINT `FK_GROUPEXAM` FOREIGN KEY (`group_id`) REFERENCES `classgroup` (`group_id`),
CONSTRAINT `FK_GRADEEXAM` FOREIGN KEY (`grade_id`) REFERENCES `grades` (`grade_id`),
CONSTRAINT `FK_ENROEXAM` FOREIGN KEY (`enro_id`) REFERENCES `enrollments` (`enro_id`)
);



-- ************************************** `classgroup_time`

CREATE TABLE IF NOT EXISTS `classgroup_time`
(
 `time_id`    int NOT NULL ,
 `day`        enum('Pazartesi', 'Salı', 'Çarşamba', 'Perşembe', 'Cuma', 'Cumartesi','Pazar') NOT NULL ,
 `start_time` time NOT NULL ,
 `end_time`   time NOT NULL ,
 `group_id`   int NOT NULL ,

PRIMARY KEY (`time_id`),
CONSTRAINT `FK_classgroup_time` FOREIGN KEY (`group_id`) REFERENCES `classgroup` (`group_id`)
);

-- ************************************** `student_program`
CREATE TABLE IF NOT EXISTS `student_program` (
 `sp_id`      INT NOT NULL AUTO_INCREMENT,
 `student_id` INT NOT NULL,
 `prog_id`    INT NOT NULL,
 PRIMARY KEY (`sp_id`),
 UNIQUE KEY `Index_1` (`student_id`, `prog_id`),
 CONSTRAINT `FK_studentprogram_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`),
 CONSTRAINT `FK_studentprogram_program` FOREIGN KEY (`prog_id`) REFERENCES `program` (`prog_id`)
);


-- ************************************** `term_stud`
CREATE TABLE IF NOT EXISTS `term_stud` (
 `term_stud`  INT NOT NULL AUTO_INCREMENT,
 `term_id`    INT NOT NULL,
 `student_id` INT NOT NULL,
 `gpa`        NUMERIC(3,2) NOT NULL,
 `level`      ENUM('Hazırlık','1', '2', '3','4','4+','Mezun') NOT NULL,
 PRIMARY KEY (`term_stud`),
 CONSTRAINT `FK_termstud_term` FOREIGN KEY (`term_id`) REFERENCES `term` (`term_id`),
 CONSTRAINT `FK_termstud_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`)
);



-- ************************************** `presence`
CREATE TABLE IF NOT EXISTS `presence` (
 `presence_id`    INT NOT NULL AUTO_INCREMENT,
 `presence_date`  DATE NOT NULL,
 `presence_count` SMALLINT NOT NULL,
 `presence_max` SMALLINT NOT NULL,
 PRIMARY KEY (`presence_id`)
);

-- ************************************** `presence_student`
CREATE TABLE IF NOT EXISTS `presence_student` (
 `pres_id`     INT NOT NULL AUTO_INCREMENT,
 `presence_id` INT NOT NULL,
 `enro_id`     INT NOT NULL,
 PRIMARY KEY (`pres_id`),
 CONSTRAINT `FK_presence_student_presence` FOREIGN KEY (`presence_id`) REFERENCES `presence` (`presence_id`),
 CONSTRAINT `FK_presence_student_enrollment` FOREIGN KEY (`enro_id`) REFERENCES `enrollments` (`enro_id`)
);








