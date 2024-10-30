-- SQL Script CourseMap
-- Phase II

-- NOTES
-- CREATED ON 10/24/24
-- Consider Changing the name of




CREATE TABLE STUDENT
      (FName              VARCHAR(15)          NOT NULL,
       LName              VARCHAR(15)          NOT NULL,
       StuEmail           VARCHAR(15)          NOT NULL,
       Major              VARCHAR(15)          DEFAULT 'COMP SCI',   
      PRIMARY KEY (StuEmail));

CREATE TABLE TIME_RECORD
      (RecordID           INT                  NOT NULL,
       StudentEmail       VARCHAR(15)          NOT NULL,
       AssignID           INT                  NOT NULL,
       TimeInput          Double(16)           DEFAULT 1,
      PRIMARY KEY (RecordID),
      FOREIGN KEY (StudentEmail) REFERENCES STUDENT(StuEmail),
      FOREIGN KEY (AssignID) REFERENCES ASSIGNMENTS(AssignID)); 

CREATE TABLE COURSE 
      (CourseID           INT                  NOT NULL,
       CourseName         VARCHAR(15),         NOT NULL,
       ProfEmail          VARCHAR(15)          NOT NULL,
      PRIMARY KEY (CourseID),
      FOREIGN KEY (ProfEmail) REFERENCES PROFESSOR(ProfEmail) );

CREATE TABLE ASSIGNMENTS
      (AssignID           INT                  NOT NULL, 
       CourseID           INT                  NOT NULL, 
       AssignmentType     VARCHAR(15)          NOT NULL,
       StuAvgTime         DOUBLE(16)           NOT NULL,
      PRIMARY KEY (AssignID),
      FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID) );

CREATE TABLE PROFESSOR
      (FName              VARCHAR(15)          NOT NULL,
       LName              VARCHAR(15)          NOT NULL,
       ProfEmail          VARCHAR(15)          NOT NULL,
      PRIMARY KEY (ProfEmail) );
