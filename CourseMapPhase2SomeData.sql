-- SQL Script CourseMap
-- Phase II

-- NOTES
-- CREATED ON 11/04/24
-- Using Notepad++

DROP DATABASE IF EXISTS CourseMap;
CREATE DATABASE CourseMap;
USE CourseMap;


CREATE TABLE STUDENT (
    FName          VARCHAR(30)    NOT NULL,
    LName          VARCHAR(30)    NOT NULL,
    StuEmail       VARCHAR(30)    NOT NULL,
    Major          VARCHAR(30)    DEFAULT 'COMP SCI',   
    PRIMARY KEY (StuEmail),
    CHECK (StuEmail LIKE '%@uw.edu')
);

CREATE TABLE PROFESSOR (
    FName          VARCHAR(30)    NOT NULL,
    LName          VARCHAR(30)    NOT NULL,
    ProfEmail      VARCHAR(50)    NOT NULL,
    PRIMARY KEY (ProfEmail),
    CHECK (ProfEmail LIKE '%@uw.edu')
);

CREATE TABLE COURSE (
    CourseID       INT           NOT NULL,
    CourseName     VARCHAR(30)   DEFAULT 'COMP SCI COURSE',
    ProfEmail      VARCHAR(50)   NOT NULL,
    PRIMARY KEY (CourseID),
    FOREIGN KEY (ProfEmail) REFERENCES PROFESSOR(ProfEmail) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ASSIGNMENTS (
    AssignID       INT           NOT NULL, 
    CourseID       INT           NOT NULL, 
    AssignmentType VARCHAR(30)   DEFAULT 'Assignment',
    StuAvgTime     DOUBLE        NOT NULL,
    PRIMARY KEY (AssignID),
    FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK (StuAvgTime > 0)
);

CREATE TABLE TIME_RECORD (
    RecordID       INT           NOT NULL,
    StudentEmail   VARCHAR(50)   NOT NULL,
    AssignID       INT           NOT NULL,
    TimeInput      DOUBLE        DEFAULT 1,
    PRIMARY KEY (RecordID),
    FOREIGN KEY (StudentEmail) REFERENCES STUDENT(StuEmail) 
        ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (AssignID) REFERENCES ASSIGNMENTS(AssignID) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK (TimeInput > 0)
);

INSERT INTO STUDENT VALUES ('Alice', 'Smith', 'alicesmith@uw.edu', 'COMP SCI');
INSERT INTO STUDENT VALUES ('Bob', 'Johnson', 'bobjohnson@uw.edu', 'COMP SCI');

INSERT INTO PROFESSOR VALUES ('Eve', 'Brown', 'evebrown@uw.edu');
INSERT INTO PROFESSOR VALUES ('John', 'Doe', 'johndoe@uw.edu');

INSERT INTO COURSE VALUES (101, 'Intro to Algorithms', 'evebrown@uw.edu');
INSERT INTO COURSE VALUES (102, 'Data Structures', 'johndoe@uw.edu');

INSERT INTO ASSIGNMENTS VALUES (1, 101, 'Quiz', 2.5);
INSERT INTO ASSIGNMENTS VALUES (2, 102, 'Project', 10.0);
INSERT INTO ASSIGNMENTS VALUES (3, 101, 'Homework', 3.5);
INSERT INTO ASSIGNMENTS VALUES (4, 102, 'Assignment', 7.2);

INSERT INTO TIME_RECORD VALUES (1000, 'alicesmith@uw.edu', 1, 2.0);
INSERT INTO TIME_RECORD VALUES (1001, 'bobjohnson@uw.edu', 2, 8.5);
INSERT INTO TIME_RECORD VALUES (1002, 'alicesmith@uw.edu', 3, 3.0);
INSERT INTO TIME_RECORD VALUES (1003, 'bobjohnson@uw.edu', 4, 6.7);