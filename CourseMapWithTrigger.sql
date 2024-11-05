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
DELIMITER //

CREATE TRIGGER update_stu_avg_time_insert
AFTER INSERT ON TIME_RECORD
FOR EACH ROW
BEGIN
    UPDATE ASSIGNMENTS
    SET StuAvgTime = (SELECT AVG(TimeInput)
                      FROM TIME_RECORD
                      WHERE AssignID = NEW.AssignID)
    WHERE AssignID = NEW.AssignID;
END//

CREATE TRIGGER update_stu_avg_time_update
AFTER UPDATE ON TIME_RECORD
FOR EACH ROW
BEGIN
    UPDATE ASSIGNMENTS
    SET StuAvgTime = (SELECT AVG(TimeInput)
                      FROM TIME_RECORD
                      WHERE AssignID = NEW.AssignID)
    WHERE AssignID = NEW.AssignID;
END//

DELIMITER ;

--DATA
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Jane', 'Moore', 'jmoore1@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Alex', 'Williams', 'awilliams2@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Alice', 'Jones', 'ajones3@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Sophia', 'Brown', 'sbrown4@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('John', 'Jones', 'jjones5@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Alex', 'Wilson', 'awilson6@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Liam', 'Jones', 'ljones7@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Sophia', 'Johnson', 'sjohnson8@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Alex', 'Moore', 'amoore9@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Alice', 'Taylor', 'ataylor10@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Jane', 'Taylor', 'jtaylor11@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Alex', 'Johnson', 'ajohnson12@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('John', 'Williams', 'jwilliams13@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Jane', 'Smith', 'jsmith14@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Ethan', 'Brown', 'ebrown15@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Alice', 'Johnson', 'ajohnson16@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Noah', 'Moore', 'nmoore17@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Jane', 'Jones', 'jjones18@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Liam', 'Jones', 'ljones19@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Ethan', 'Smith', 'esmith20@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Jane', 'Brown', 'jbrown21@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Ethan', 'Miller', 'emiller22@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Sophia', 'Davis', 'sdavis23@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Jane', 'Taylor', 'jtaylor24@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Olivia', 'Miller', 'omiller25@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Jane', 'Moore', 'jmoore26@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('John', 'Moore', 'jmoore27@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Olivia', 'Johnson', 'ojohnson28@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Jane', 'Moore', 'jmoore29@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Sophia', 'Wilson', 'swilson30@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('John', 'Brown', 'jbrown31@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Liam', 'Williams', 'lwilliams32@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Sophia', 'Taylor', 'staylor33@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Liam', 'Brown', 'lbrown34@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Olivia', 'Davis', 'odavis35@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Alice', 'Jones', 'ajones36@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('John', 'Brown', 'jbrown37@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Mia', 'Miller', 'mmiller38@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Liam', 'Jones', 'ljones39@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Noah', 'Davis', 'ndavis40@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Jane', 'Brown', 'jbrown41@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Mia', 'Brown', 'mbrown42@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Alice', 'Brown', 'abrown43@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Liam', 'Jones', 'ljones44@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Sophia', 'Smith', 'ssmith45@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Jane', 'Williams', 'jwilliams46@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Liam', 'Brown', 'lbrown47@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Mia', 'Miller', 'mmiller48@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Alex', 'Williams', 'awilliams49@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Alice', 'Williams', 'awilliams50@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Liam', 'Moore', 'lmoore51@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Liam', 'Williams', 'lwilliams52@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Ethan', 'Taylor', 'etaylor53@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Jane', 'Brown', 'jbrown54@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Alex', 'Wilson', 'awilson55@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Noah', 'Miller', 'nmiller56@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Alice', 'Wilson', 'awilson57@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Olivia', 'Johnson', 'ojohnson58@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Alice', 'Smith', 'asmith59@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Liam', 'Williams', 'lwilliams60@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Sophia', 'Wilson', 'swilson61@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Mia', 'Jones', 'mjones62@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Sophia', 'Taylor', 'staylor63@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Sophia', 'Brown', 'sbrown64@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Alex', 'Williams', 'awilliams65@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Sophia', 'Smith', 'ssmith66@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('John', 'Smith', 'jsmith67@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Alex', 'Williams', 'awilliams68@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Liam', 'Jones', 'ljones69@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Liam', 'Davis', 'ldavis70@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Sophia', 'Wilson', 'swilson71@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Jane', 'Williams', 'jwilliams72@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Jane', 'Wilson', 'jwilson73@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Jane', 'Moore', 'jmoore74@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('John', 'Brown', 'jbrown75@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('John', 'Brown', 'jbrown76@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Sophia', 'Williams', 'swilliams77@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Alice', 'Moore', 'amoore78@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Liam', 'Miller', 'lmiller79@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Jane', 'Johnson', 'jjohnson80@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Noah', 'Smith', 'nsmith81@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Liam', 'Taylor', 'ltaylor82@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Jane', 'Miller', 'jmiller83@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Mia', 'Wilson', 'mwilson84@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Alice', 'Williams', 'awilliams85@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Alice', 'Miller', 'amiller86@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Sophia', 'Williams', 'swilliams87@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('John', 'Wilson', 'jwilson88@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Ethan', 'Brown', 'ebrown89@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('John', 'Johnson', 'jjohnson90@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('John', 'Johnson', 'jjohnson91@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Mia', 'Johnson', 'mjohnson92@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Alice', 'Jones', 'ajones93@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Ethan', 'Miller', 'emiller94@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('John', 'Smith', 'jsmith95@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Noah', 'Davis', 'ndavis96@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('John', 'Jones', 'jjones97@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('John', 'Taylor', 'jtaylor98@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Ethan', 'Brown', 'ebrown99@uw.edu', 'COMP SCI');
INSERT INTO STUDENT (FName, LName, StuEmail, Major) VALUES ('Jane', 'Moore', 'jmoore100@uw.edu', 'COMP SCI');

INSERT INTO PROFESSOR (FName, LName, ProfEmail) VALUES ('Jane', 'Miller', 'jmiller1@uw.edu');
INSERT INTO PROFESSOR (FName, LName, ProfEmail) VALUES ('Mary', 'Davis', 'mdavis2@uw.edu');
INSERT INTO PROFESSOR (FName, LName, ProfEmail) VALUES ('Eyhab', 'Johnson', 'ejohnson3@uw.edu');
INSERT INTO PROFESSOR (FName, LName, ProfEmail) VALUES ('Tom', 'Arriola', 'tarriola4@uw.edu');
INSERT INTO PROFESSOR (FName, LName, ProfEmail) VALUES ('Noah', 'Emanuel', 'nemanuel5@uw.edu');
INSERT INTO PROFESSOR (FName, LName, ProfEmail) VALUES ('Tom', 'Smith', 'tsmith6@uw.edu');
INSERT INTO PROFESSOR (FName, LName, ProfEmail) VALUES ('Tom', 'Brown', 'tbrown7@uw.edu');
INSERT INTO PROFESSOR (FName, LName, ProfEmail) VALUES ('Liam', 'Johnson', 'ljohnson8@uw.edu');
INSERT INTO PROFESSOR (FName, LName, ProfEmail) VALUES ('Monika', 'Johnson', 'mjohnson9@uw.edu');
INSERT INTO PROFESSOR (FName, LName, ProfEmail) VALUES ('Mia', 'Williams', 'mwilliams10@uw.edu');

INSERT INTO COURSE (CourseID, CourseName, ProfEmail) VALUES (1, 'CSS001', 'jmiller1@uw.edu');
INSERT INTO COURSE (CourseID, CourseName, ProfEmail) VALUES (2, 'CSS002', 'mdavis2@uw.edu');
INSERT INTO COURSE (CourseID, CourseName, ProfEmail) VALUES (3, 'CSS003', 'ejohnson3@uw.edu');
INSERT INTO COURSE (CourseID, CourseName, ProfEmail) VALUES (4, 'CSS004', 'tarriola4@uw.edu');
INSERT INTO COURSE (CourseID, CourseName, ProfEmail) VALUES (5, 'CSS005', 'nemanuel5@uw.edu');
INSERT INTO COURSE (CourseID, CourseName, ProfEmail) VALUES (6, 'CSS006', 'tsmith6@uw.edu');
INSERT INTO COURSE (CourseID, CourseName, ProfEmail) VALUES (7, 'CSS007', 'tbrown7@uw.edu');
INSERT INTO COURSE (CourseID, CourseName, ProfEmail) VALUES (8, 'CSS008', 'ljohnson8@uw.edu');
INSERT INTO COURSE (CourseID, CourseName, ProfEmail) VALUES (9, 'CSS009', 'mjohnson9@uw.edu');
INSERT INTO COURSE (CourseID, CourseName, ProfEmail) VALUES (10, 'CSS010', 'mwilliams10@uw.edu');

INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (1, 1, 'Project', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (2, 1, 'Assignment', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (3, 1, 'Quiz', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (4, 1, 'Project', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (5, 2, 'Quiz', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (6, 2, 'Discussion Post', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (7, 2, 'Project', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (8, 2, 'Project', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (9, 3, 'Discussion Post', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (10, 3, 'Assignment', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (11, 3, 'Discussion Post', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (12, 3, 'Project', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (13, 4, 'Assignment', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (14, 4, 'Quiz', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (15, 4, 'Project', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (16, 4, 'Quiz', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (17, 5, 'Quiz', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (18, 5, 'Assignment', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (19, 5, 'Discussion Post', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (20, 5, 'Quiz', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (21, 6, 'Project', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (22, 6, 'Quiz', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (23, 6, 'Project', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (24, 6, 'Project', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (25, 7, 'Assignment', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (26, 7, 'Assignment', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (27, 7, 'Discussion Post', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (28, 7, 'Project', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (29, 8, 'Discussion Post', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (30, 8, 'Project', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (31, 8, 'Discussion Post', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (32, 8, 'Discussion Post', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (33, 9, 'Quiz', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (34, 9, 'Discussion Post', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (35, 9, 'Assignment', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (36, 9, 'Project', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (37, 10, 'Assignment', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (38, 10, 'Assignment', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (39, 10, 'Discussion Post', 1);
INSERT INTO ASSIGNMENTS (AssignID, CourseID, AssignmentType, StuAvgTime) VALUES (40, 10, 'Discussion Post', 1);

INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (1, 'jmoore1@uw.edu', 17, 8.59);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (2, 'awilliams2@uw.edu', 15, 7.04);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (3, 'ajones3@uw.edu', 24, 3.18);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (4, 'sbrown4@uw.edu', 18, 8.55);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (5, 'jjones5@uw.edu', 7, 7.02);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (6, 'awilson6@uw.edu', 21, 1.36);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (7, 'ljones7@uw.edu', 33, 7.44);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (8, 'sjohnson8@uw.edu', 36, 1.34);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (9, 'amoore9@uw.edu', 29, 3.08);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (10, 'ataylor10@uw.edu', 12, 9.62);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (11, 'jtaylor11@uw.edu', 15, 6.85);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (12, 'ajohnson12@uw.edu', 1, 2.61);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (13, 'jwilliams13@uw.edu', 28, 8.91);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (14, 'jsmith14@uw.edu', 16, 5.21);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (15, 'ebrown15@uw.edu', 33, 9.32);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (16, 'ajohnson16@uw.edu', 8, 6.28);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (17, 'nmoore17@uw.edu', 6, 5.85);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (18, 'jjones18@uw.edu', 21, 6.35);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (19, 'ljones19@uw.edu', 3, 5.47);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (20, 'esmith20@uw.edu', 32, 10.65);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (21, 'jbrown21@uw.edu', 31, 7.78);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (22, 'emiller22@uw.edu', 26, 3.06);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (23, 'sdavis23@uw.edu', 33, 10.40);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (24, 'jtaylor24@uw.edu', 9, 5.59);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (25, 'omiller25@uw.edu', 3, 8.93);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (26, 'jmoore26@uw.edu', 11, 2.20);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (27, 'jmoore27@uw.edu', 40, 5.24);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (28, 'ojohnson28@uw.edu', 36, 7.23);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (29, 'jmoore29@uw.edu', 10, 8.71);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (30, 'swilson30@uw.edu', 5, 10.40);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (31, 'jbrown31@uw.edu', 34, 4.53);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (32, 'lwilliams32@uw.edu', 35, 5.02);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (33, 'staylor33@uw.edu', 2, 5.79);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (34, 'lbrown34@uw.edu', 1, 1.75);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (35, 'odavis35@uw.edu', 40, 6.05);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (36, 'ajones36@uw.edu', 26, 1.98);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (37, 'jbrown37@uw.edu', 29, 6.96);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (38, 'mmiller38@uw.edu', 27, 10.27);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (39, 'ljones39@uw.edu', 19, 5.95);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (40, 'ndavis40@uw.edu', 37, 4.85);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (41, 'jbrown41@uw.edu', 17, 10.52);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (42, 'mbrown42@uw.edu', 16, 9.28);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (43, 'abrown43@uw.edu', 23, 5.73);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (44, 'ljones44@uw.edu', 39, 6.38);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (45, 'ssmith45@uw.edu', 14, 10.83);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (46, 'jwilliams46@uw.edu', 20, 5.53);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (47, 'lbrown47@uw.edu', 7, 9.81);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (48, 'mmiller48@uw.edu', 30, 7.61);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (49, 'awilliams49@uw.edu', 9, 7.87);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (50, 'awilliams50@uw.edu', 6, 8.31);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (51, 'lmoore51@uw.edu', 32, 1.38);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (52, 'lwilliams52@uw.edu', 2, 9.97);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (53, 'etaylor53@uw.edu', 20, 8.22);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (54, 'jbrown54@uw.edu', 14, 8.92);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (55, 'awilson55@uw.edu', 13, 7.72);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (56, 'nmiller56@uw.edu', 30, 8.16);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (57, 'awilson57@uw.edu', 8, 9.63);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (58, 'ojohnson58@uw.edu', 10, 3.85);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (59, 'asmith59@uw.edu', 9, 8.54);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (60, 'lwilliams60@uw.edu', 13, 7.13);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (61, 'swilson61@uw.edu', 11, 2.60);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (62, 'mjones62@uw.edu', 18, 8.39);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (63, 'staylor63@uw.edu', 14, 9.31);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (64, 'sbrown64@uw.edu', 22, 5.60);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (65, 'awilliams65@uw.edu', 6, 2.43);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (66, 'ssmith66@uw.edu', 38, 8.37);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (67, 'jsmith67@uw.edu', 30, 4.49);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (68, 'awilliams68@uw.edu', 19, 10.39);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (69, 'ljones69@uw.edu', 37, 6.27);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (70, 'ldavis70@uw.edu', 4, 8.14);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (71, 'swilson71@uw.edu', 4, 4.07);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (72, 'jwilliams72@uw.edu', 33, 2.65);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (73, 'jwilson73@uw.edu', 16, 4.30);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (74, 'jmoore74@uw.edu', 29, 6.01);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (75, 'jbrown75@uw.edu', 24, 4.47);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (76, 'jbrown76@uw.edu', 33, 3.79);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (77, 'swilliams77@uw.edu', 31, 2.87);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (78, 'amoore78@uw.edu', 25, 4.83);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (79, 'lmiller79@uw.edu', 26, 4.79);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (80, 'jjohnson80@uw.edu', 16, 10.46);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (81, 'nsmith81@uw.edu', 22, 10.62);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (82, 'ltaylor82@uw.edu', 27, 2.12);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (83, 'jmiller83@uw.edu', 38, 10.73);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (84, 'mwilson84@uw.edu', 34, 7.44);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (85, 'awilliams85@uw.edu', 40, 3.09);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (86, 'amiller86@uw.edu', 4, 9.73);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (87, 'swilliams87@uw.edu', 27, 10.02);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (88, 'jwilson88@uw.edu', 28, 2.18);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (89, 'ebrown89@uw.edu', 35, 10.71);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (90, 'jjohnson90@uw.edu', 38, 10.58);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (91, 'jjohnson91@uw.edu', 5, 10.24);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (92, 'mjohnson92@uw.edu', 39, 1.17);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (93, 'ajones93@uw.edu', 13, 3.90);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (94, 'emiller94@uw.edu', 30, 8.71);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (95, 'jsmith95@uw.edu', 23, 5.24);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (96, 'ndavis96@uw.edu', 32, 5.46);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (97, 'jjones97@uw.edu', 2, 10.98);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (98, 'jtaylor98@uw.edu', 12, 3.69);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (99, 'ebrown99@uw.edu', 25, 5.00);
INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput) VALUES (100, 'jmoore100@uw.edu', 31, 3.09);
