-- SQL Script CourseMap
-- Phase II

-- NOTES
-- CREATED ON 10/24/24
-- Consider Changing the name of




CREATE TABLE STUDENT
      (Fname              VARCHAR(15)          NOT NULL,
       LName              VARCHAR(15)          NOT NULL,
       StuEmail           VARCHAR(15)          NOT NULL,
       Major              VARCHAR(15)             
      PRIMARY KEY (email) );

CREATE TABLE TIME_RECORD
      (RecordID           INT                  NOT NULL,
       StudentEmail       VARCHAR(15)          NOT NULL,
       AssignID           INT                  NOT NULL,
       TimeInput          Double(16)           NOT NULL,
      PRIMARY KEY (RecordID),
      FOREIGN KEY (StudentEmail) REFERENCES STUDENT(Stuemail),
      FOREIGN KEY (AssignID) REFERENCES ASSIGNMENTS(AssignID)); 

CREATE TABLE COURSE 
      (CourseID           INT                  NOT NULL,
       CourseName         VARCHAR(15),         NOT NULL,
       ProfEmail          VARCHAR(15)          NOT NULL,
      PRIMARY KEY (CourseID),
      FOREIGN KEY (ProffessorID) REFERENCES PROFESSOR(AssigID) );

CREATE TABLE ASSIGNMENTS
      (AssingID           INT                  NOT NULL, 
       CourseID           INT                  NOT NULL, 
       AssingmentType     VARCHAR(15)          NOT NULL,
       StuAvgTime         DOUBLE(16)           NOT NULL,
      PRIMARY KEY (AssingID),
      FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID) );

CREATE TABLE PROFEFESSOR
      (Fname              VARCHAR(15)          NOT NULL,
       Lname              VARCHAR(15)          NOT NULL,
       ProfEmail          VARCHAR(15)          NOT NULL,
      PRIMARY KEY (ProfEmail) );
