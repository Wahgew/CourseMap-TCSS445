-- SQL Script CourseMap
-- Phase II

-- NOTES
-- CREATED ON 10/31/24
-- Using MySQL (draft)

DROP DATABASE IF EXISTS CourseMap;
CREATE DATABASE CourseMap;
USE CourseMap;


CREATE TABLE STUDENT (
    FName          VARCHAR(15)    NOT NULL,
    LName          VARCHAR(15)    NOT NULL,
    StuEmail       VARCHAR(15)    NOT NULL,
    Major          VARCHAR(15)    DEFAULT 'COMP SCI',   
    PRIMARY KEY (StuEmail),
    CHECK (StuEmail LIKE '%@uw.edu')
);

CREATE TABLE PROFESSOR (
    FName          VARCHAR(15)    NOT NULL,
    LName          VARCHAR(15)    NOT NULL,
    ProfEmail      VARCHAR(15)    NOT NULL,
    PRIMARY KEY (ProfEmail),
    CHECK (ProfEmail LIKE '%@uw.edu')
);

CREATE TABLE COURSE (
    CourseID       INT           NOT NULL,
    CourseName     VARCHAR(15)   DEFAULT 'COMP SCI COURSE',
    ProfEmail      VARCHAR(15)   NOT NULL,
    PRIMARY KEY (CourseID),
    FOREIGN KEY (ProfEmail) REFERENCES PROFESSOR(ProfEmail) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ASSIGNMENTS (
    AssignID       INT           NOT NULL, 
    CourseID       INT           NOT NULL, 
    AssignmentType VARCHAR(15)   DEFAULT 'Assignment',
    StuAvgTime     DOUBLE        NOT NULL,
    PRIMARY KEY (AssignID),
    FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK (StuAvgTime > 0)
);

CREATE TABLE TIME_RECORD (
    RecordID       INT           NOT NULL,
    StudentEmail   VARCHAR(15)   NOT NULL,
    AssignID       INT           NOT NULL,
    TimeInput      DOUBLE        DEFAULT 1,
    PRIMARY KEY (RecordID),
    FOREIGN KEY (StudentEmail) REFERENCES STUDENT(StuEmail) 
        ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (AssignID) REFERENCES ASSIGNMENTS(AssignID) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK (TimeInput > 0)
);

