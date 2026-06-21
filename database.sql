-- ============================================================
-- Database: StudentProfilesDB
-- Table: Profile
-- For: Profile Management System (CSC584 Individual Assignment)
-- DBMS: Apache Derby
-- ============================================================

-- Connect to the database (Derby will create it automatically)
-- In NetBeans or ij tool, use:
--   CONNECT 'jdbc:derby://localhost:1527/StudentProfilesDB;create=true';

-- Create Profile table
CREATE TABLE PROFILE (
    STUDENTID   VARCHAR(20)   NOT NULL,
    NAME        VARCHAR(100)  NOT NULL,
    PROGRAMME   VARCHAR(100)  NOT NULL,
    EMAIL       VARCHAR(100)  NOT NULL,
    HOBBIES     VARCHAR(255)  NOT NULL,
    INTRODUCTION VARCHAR(500) NOT NULL,
    PRIMARY KEY (STUDENTID)
);

-- Sample insert (optional)
-- INSERT INTO PROFILE (STUDENTID, NAME, PROGRAMME, EMAIL, HOBBIES, INTRODUCTION)
-- VALUES ('2024123456', 'John Doe', 'Computer Science', 'john@example.com', 'Reading, Gaming', 'A passionate student.');
