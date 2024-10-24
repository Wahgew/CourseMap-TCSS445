-- SQL Script CourseMap
-- Phase II







CREATE TABLE STUDENT
      (Fname        VARCHAR(15)          NOT NULL,
       LName        VARCHAR(15)          NOT NULL,
       Email        VARCHAR(15)          NOT NULL,
      PRIMARY KEY (email)
      );

CREATE TABLE TIME_RECORD
      (RecordID     INT()                NOT NULL,
       StudentEmail VARCHAR(15)          NOT NULL,
       AssignID     INT                  NOT NULL,
       TimeInput    Double(16)           NOT NULL,
      PRIMARY KEY (RecordID),
      FOREIGN KEY (StudentEmail) REFERENCES STUDENT(email)


  
      );
