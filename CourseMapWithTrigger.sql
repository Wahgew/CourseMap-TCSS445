-- Drop database if it exists
DROP DATABASE IF EXISTS CourseMap;
CREATE DATABASE CourseMap;
USE CourseMap;

-- Create tables
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
    StuAvgTime     DOUBLE        DEFAULT 0, -- Updated to a default value
    PRIMARY KEY (AssignID),
    FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID) 
        ON DELETE CASCADE ON UPDATE CASCADE
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

-- Trigger to update StuAvgTime in ASSIGNMENTS table
CREATE TRIGGER update_stu_avg_time
AFTER INSERT OR UPDATE ON TIME_RECORD
FOR EACH ROW
BEGIN
    UPDATE ASSIGNMENTS
    SET StuAvgTime = (SELECT AVG(TimeInput)
                      FROM TIME_RECORD
                      WHERE AssignID = NEW.AssignID)
    WHERE AssignID = NEW.AssignID;
END;


