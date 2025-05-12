create database project;

use project;

CREATE TABLE student_details (
    roll_number INT primary key,
    first_name varchar(50),
    last_name varchar(50),
    address VARCHAR(100),
    contact_number VARCHAR(15),
    mail_id VARCHAR(100),
    class VARCHAR(10)
);

CREATE TABLE sem_1_major_marks (
    roll_number INT,
    maths INT,
    english INT,
    hindi INT,
    science INT,
    social_science INT,
    PRIMARY KEY (roll_number),
    CONSTRAINT fk_roll_number
        FOREIGN KEY (roll_number)
        REFERENCES student_details(roll_number)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

create table student_credential(
user_name varchar(50) unique,
user_pass varchar(50),
roll_number int,
PRIMARY KEY (roll_number),
CONSTRAINT fkk_roll_number
	FOREIGN KEY (roll_number)
	REFERENCES student_details(roll_number)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

show tables;

INSERT INTO student_details (roll_number,first_name,last_name, address, contact_number, mail_id, class)
VALUES
(1,'Alicia', 'Bright', '456 Oak St, Brooklyn, NY', '9876543211', 'alicia.bright@example.com', '10A'),
(2,'Leslie', 'Williams', '789 Elm Rd, Austin, TX', '9876543212', 'leslie.williams@example.com', '10A'),
(3,'Amy', 'Hawkins', '321 Maple Dr, Miami, FL', '9876543213', 'amy.hawkins@example.com', '10A'),
(4,'Morgan', 'Branch', '654 Pine Ln, Denver, CO', '9876543214', 'morgan.branch@example.com', '10A'),
(5,'Brittany', 'Bell', '12 Sunset Blvd, Phoenix, AZ', '9876543215', 'brittany.bell@example.com', '10A'),
(6, 'Mary', 'Miller','77 Hilltop Rd, Seattle, WA', '9876543216', 'mary.miller@example.com', '10A'),
(7,'Eric', 'Foster','90 Lakeview Ave, Chicago, IL', '9876543217', 'eric.foster@example.com', '10A'),
(8,'Anna', 'Harrison' ,'105 Forest Way, Orlando, FL', '9876543218', 'anna.harrison@example.com', '10A'),
(9,'Marcus', 'Richardson' ,'42 Mountain Rd, Boston, MA', '9876543219', 'marcus.richardson@example.com', '10A'),
(10,'John', 'Callahan' ,'123 Main St, Springfield, IL', '9876543210', 'john.callahan@example.com', '10A');


INSERT INTO sem_1_major_marks (roll_number, maths, english, hindi, science, social_science)
VALUES
(1, 75, 87, 63, 98, 70),
(2, 42, 86, 76, 88, 55),
(3, 95, 50, 87, 64, 82),
(4, 49, 98, 68, 57, 100),
(5, 79, 72, 58, 67, 62),
(6, 71, 55, 46, 60, 77),
(7, 95, 73, 99, 99, 65),
(8, 54, 44, 49, 66, 75),
(9, 87, 67, 98, 83, 85),
(10, 78, 40, 46, 61, 43);

INSERT INTO student_credential (user_name, user_pass, roll_number)
values
('user1','user_1',1),
('user2','user_2',2),
('user3','user_3',3),
('user4','user_4',4),
('user5','user_5',5),
('user6','user_6',6),
('user7','user_7',7),
('user8','user_8',8),
('user9','user_9',9),
('user10','user_10',10);


CREATE TABLE sem_1_unit_1_marks (
    roll_number INT PRIMARY KEY,
    maths INT,
    english INT,
    hindi INT,
    science INT,
    social_science INT
);

CREATE TABLE sem_1_unit_2_marks (
    roll_number INT PRIMARY KEY,
    maths INT,
    english INT,
    hindi INT,
    science INT,
    social_science INT
);

-- Example: Add foreign key if students table exists
ALTER TABLE sem_1_unit_1_marks
ADD CONSTRAINT fk_unit1_roll
FOREIGN KEY (roll_number) REFERENCES student_details(roll_number)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE sem_1_unit_2_marks
ADD CONSTRAINT fk_unit2_roll
FOREIGN KEY (roll_number) REFERENCES student_details(roll_number)
ON DELETE CASCADE
ON UPDATE CASCADE;

INSERT INTO sem_1_unit_1_marks (roll_number, maths, english, hindi, science, social_science) VALUES
(1, 45, 50, 40, 42, 38),
(2, 48, 46, 44, 41, 39),
(3, 35, 40, 36, 32, 30),
(4, 49, 47, 45, 44, 42),
(5, 30, 28, 25, 27, 26),
(6, 41, 43, 40, 39, 38),
(7, 46, 44, 48, 45, 43),
(8, 39, 35, 37, 36, 34),
(9, 50, 48, 49, 47, 46),
(10, 33, 31, 30, 29, 28);

INSERT INTO sem_1_unit_2_marks (roll_number, maths, english, hindi, science, social_science) VALUES
(1, 47, 49, 43, 45, 40),
(2, 50, 47, 46, 44, 41),
(3, 38, 42, 40, 36, 33),
(4, 50, 49, 48, 47, 45),
(5, 32, 30, 28, 29, 27),
(6, 44, 46, 43, 42, 40),
(7, 48, 45, 50, 46, 44),
(8, 41, 38, 39, 37, 35),
(9, 50, 50, 50, 49, 48),
(10, 35, 33, 32, 30, 29);

CREATE TABLE notification (
    roll_number INT,
    notification TEXT,
    FOREIGN KEY (roll_number) REFERENCES student_details(roll_number)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO notification (roll_number, notification) VALUES
(1, 'Please submit your recent passport-sized photo.'),
(2, 'Collect your termination certificate from the admin office.'),
(3, 'Your character certificate is ready for pickup.'),
(4, 'Submit your library clearance form.'),
(5, 'Participate in the upcoming sports meet registration.'),
(6, 'Your fee receipt is available for download.'),
(7, 'Attend the orientation session on Friday.'),
(8, 'Submit your major project synopsis by Monday.'),
(9, 'Vaccination certificate is mandatory for hostel admission.'),
(10, 'Collect your hall ticket for the upcoming exam.');

CREATE TABLE sem_2_major_marks (
    roll_number INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    maths INT,
    english INT,
    hindi INT,
    science INT,
    social_science INT,
    PRIMARY KEY (roll_number),
    CONSTRAINT fk_sem2_roll FOREIGN KEY (roll_number) REFERENCES student_details(roll_number)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE sem_2_unit_1_marks (
    roll_number INT PRIMARY KEY,
    maths INT,
    english INT,
    hindi INT,
    science INT,
    social_science INT,
    CONSTRAINT fk_sem2_unit1_roll FOREIGN KEY (roll_number) REFERENCES student_details(roll_number)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE sem_2_unit_2_marks (
    roll_number INT PRIMARY KEY,
    maths INT,
    english INT,
    hindi INT,
    science INT,
    social_science INT,
    CONSTRAINT fk_sem2_unit2_roll FOREIGN KEY (roll_number) REFERENCES student_details(roll_number)
    ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO sem_2_major_marks (roll_number, maths, english, hindi, science, social_science) VALUES
(1, 85, 78, 90, 88, 80),
(2,  76, 82, 70, 74, 80),
(3, 92, 88, 85, 91, 89),
(4, 65, 70, 60, 68, 72),
(5, 80, 75, 85, 79, 83),
(6, 78, 84, 80, 76, 77),
(7, 90, 88, 91, 92, 87),
(8, 72, 76, 70, 73, 75),
(9, 88, 84, 86, 89, 85),
(10, 81, 79, 83, 80, 78 );


-- sem_2_unit_1_marks
INSERT INTO sem_2_unit_1_marks (roll_number, maths, english, hindi, science, social_science) VALUES
(1, 42, 38, 45, 44, 40),
(2, 37, 40, 35, 36, 40),
(3, 46, 44, 43, 45, 44),
(4, 30, 34, 28, 33, 36),
(5, 40, 39, 42, 41, 41),
(6, 38, 42, 40, 39, 40),
(7, 45, 44, 46, 46, 43),
(8, 36, 38, 35, 36, 37),
(9, 44, 42, 43, 44, 43),
(10, 41, 39, 42, 40, 39);

-- sem_2_unit_2_marks
INSERT INTO sem_2_unit_2_marks (roll_number, maths, english, hindi, science, social_science) VALUES
(1, 43, 40, 45, 44, 41),
(2, 38, 41, 36, 37, 41),
(3, 47, 45, 44, 46, 45),
(4, 32, 35, 29, 34, 37),
(5, 41, 40, 43, 42, 42),
(6, 39, 43, 41, 40, 41),
(7, 46, 45, 47, 47, 44),
(8, 37, 39, 36, 37, 38),
(9, 45, 43, 44, 45, 44),
(10, 42, 40, 43, 41, 40);

CREATE TABLE sem_3_major_marks (
    roll_number INT,
    maths INT,
    english INT,
    hindi INT,
    science INT,
    social_science INT,
    PRIMARY KEY (roll_number),
    CONSTRAINT fk_sem3_roll FOREIGN KEY (roll_number) REFERENCES student_details(roll_number)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE sem_3_unit_1_marks (
    roll_number INT PRIMARY KEY,
    maths INT,
    english INT,
    hindi INT,
    science INT,
    social_science INT,
    CONSTRAINT fk_sem3_unit1_roll FOREIGN KEY (roll_number) REFERENCES student_details(roll_number)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE sem_3_unit_2_marks (
    roll_number INT PRIMARY KEY,
    maths INT,
    english INT,
    hindi INT,
    science INT,
    social_science INT,
    CONSTRAINT fk_sem3_unit2_roll FOREIGN KEY (roll_number) REFERENCES student_details(roll_number)
    ON UPDATE CASCADE ON DELETE CASCADE
); 

-- Insert data into sem_3_major_marks
INSERT INTO sem_3_major_marks (roll_number, maths, english, hindi, science, social_science)
VALUES
(1, 85, 78, 92, 88, 76),
(2, 90, 82, 85, 91, 79),
(3, 78, 85, 80, 84, 82),
(4, 92, 76, 78, 89, 85),
(5, 81, 89, 85, 77, 90),
(6, 87, 91, 76, 82, 84),
(7, 83, 84, 89, 85, 78),
(8, 79, 77, 92, 90, 83),
(9, 86, 83, 81, 79, 87),
(10, 88, 90, 84, 86, 81);

-- Insert data into sem_3_unit_1_marks
INSERT INTO sem_3_unit_1_marks (roll_number, maths, english, hindi, science, social_science)
VALUES
(1, 42, 38, 46, 44, 38),
(2, 45, 41, 42, 45, 39),
(3, 39, 42, 40, 42, 41),
(4, 46, 38, 39, 44, 42),
(5, 40, 44, 42, 38, 45),
(6, 43, 45, 38, 41, 42),
(7, 41, 42, 44, 42, 39),
(8, 39, 38, 46, 45, 41),
(9, 43, 41, 40, 39, 43),
(10, 44, 45, 42, 43, 40);

-- Insert data into sem_3_unit_2_marks
INSERT INTO sem_3_unit_2_marks (roll_number, maths, english, hindi, science, social_science)
VALUES
(1, 43, 40, 46, 44, 38),
(2, 45, 41, 43, 46, 40),
(3, 39, 43, 40, 42, 41),
(4, 46, 38, 39, 45, 43),
(5, 41, 45, 43, 39, 45),
(6, 44, 46, 38, 41, 42),
(7, 42, 42, 45, 43, 39),
(8, 40, 39, 46, 45, 42),
(9, 43, 42, 41, 40, 44),
(10, 44, 45, 42, 43, 41);

CREATE TABLE sem_4_major_marks (
    roll_number INT,
    maths INT,
    english INT,
    hindi INT,
    science INT,
    social_science INT,
    PRIMARY KEY (roll_number),
    CONSTRAINT fk_sem4_roll FOREIGN KEY (roll_number) REFERENCES student_details(roll_number)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE sem_4_unit_1_marks (
    roll_number INT PRIMARY KEY,
    maths INT,
    english INT,
    hindi INT,
    science INT,
    social_science INT,
    CONSTRAINT fk_sem4_unit1_roll FOREIGN KEY (roll_number) REFERENCES student_details(roll_number)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE sem_4_unit_2_marks (
    roll_number INT PRIMARY KEY,
    maths INT,
    english INT,
    hindi INT,
    science INT,
    social_science INT,
    CONSTRAINT fk_sem4_unit2_roll FOREIGN KEY (roll_number) REFERENCES student_details(roll_number)
    ON UPDATE CASCADE ON DELETE CASCADE
); 
-- Insert data into sem_4_major_marks (full exam marks out of 100)
INSERT INTO sem_4_major_marks (roll_number, maths, english, hindi, science, social_science)
VALUES
(1, 82, 85, 88, 79, 83),
(2, 91, 78, 84, 87, 80),
(3, 76, 89, 82, 85, 88),
(4, 85, 82, 90, 78, 84),
(5, 88, 91, 76, 83, 79),
(6, 79, 84, 85, 90, 86),
(7, 83, 77, 89, 82, 91),
(8, 90, 85, 81, 86, 78),
(9, 77, 90, 83, 89, 82),
(10, 84, 83, 87, 81, 89);

-- Insert data into sem_4_unit_1_marks (unit test marks out of 50)
INSERT INTO sem_4_unit_1_marks (roll_number, maths, english, hindi, science, social_science)
VALUES
(1, 41, 42, 44, 39, 41),
(2, 45, 39, 42, 43, 40),
(3, 38, 44, 41, 42, 44),
(4, 42, 41, 45, 39, 42),
(5, 44, 45, 38, 41, 39),
(6, 39, 42, 42, 45, 43),
(7, 41, 38, 44, 41, 45),
(8, 45, 42, 40, 43, 39),
(9, 38, 45, 41, 44, 41),
(10, 42, 41, 43, 40, 44);

-- Insert data into sem_4_unit_2_marks (unit test marks out of 50)
INSERT INTO sem_4_unit_2_marks (roll_number, maths, english, hindi, science, social_science)
VALUES
(1, 41, 43, 44, 40, 42),
(2, 46, 39, 42, 44, 40),
(3, 38, 45, 41, 43, 44),
(4, 43, 41, 45, 39, 42),
(5, 44, 46, 38, 42, 40),
(6, 40, 42, 43, 45, 43),
(7, 42, 39, 45, 41, 46),
(8, 45, 43, 41, 43, 39),
(9, 39, 45, 42, 45, 41),
(10, 42, 42, 44, 41, 45);

CREATE TABLE subject_attendance (
    id INT AUTO_INCREMENT,
    roll_number INT,
    subject VARCHAR(50),
    date DATE,
    status ENUM('Present', 'Absent'),
    FOREIGN KEY (roll_number) REFERENCES student_details(roll_number)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert attendance data for 5 students, 5 subjects, over 5 days
INSERT INTO subject_attendance (roll_number, subject, date, status)
VALUES
-- Day 1 (Monday)
(1, 'maths', '2023-11-01', 'Present'),
(1, 'english', '2023-11-01', 'Present'),
(1, 'hindi', '2023-11-01', 'Present'),
(1, 'science', '2023-11-01', 'Present'),
(1, 'social_science', '2023-11-01', 'Present'),

(2, 'maths', '2023-11-01', 'Present'),
(2, 'english', '2023-11-01', 'Absent'),
(2, 'hindi', '2023-11-01', 'Present'),
(2, 'science', '2023-11-01', 'Present'),
(2, 'social_science', '2023-11-01', 'Present'),

(3, 'maths', '2023-11-01', 'Present'),
(3, 'english', '2023-11-01', 'Present'),
(3, 'hindi', '2023-11-01', 'Absent'),
(3, 'science', '2023-11-01', 'Present'),
(3, 'social_science', '2023-11-01', 'Present'),

(4, 'maths', '2023-11-01', 'Absent'),
(4, 'english', '2023-11-01', 'Present'),
(4, 'hindi', '2023-11-01', 'Present'),
(4, 'science', '2023-11-01', 'Present'),
(4, 'social_science', '2023-11-01', 'Absent'),

(5, 'maths', '2023-11-01', 'Present'),
(5, 'english', '2023-11-01', 'Present'),
(5, 'hindi', '2023-11-01', 'Present'),
(5, 'science', '2023-11-01', 'Absent'),
(5, 'social_science', '2023-11-01', 'Present'),

-- Day 2 (Tuesday)
(1, 'maths', '2023-11-02', 'Present'),
(1, 'english', '2023-11-02', 'Present'),
(1, 'hindi', '2023-11-02', 'Present'),
(1, 'science', '2023-11-02', 'Present'),
(1, 'social_science', '2023-11-02', 'Present'),

(2, 'maths', '2023-11-02', 'Absent'),
(2, 'english', '2023-11-02', 'Present'),
(2, 'hindi', '2023-11-02', 'Present'),
(2, 'science', '2023-11-02', 'Present'),
(2, 'social_science', '2023-11-02', 'Absent'),

(3, 'maths', '2023-11-02', 'Present'),
(3, 'english', '2023-11-02', 'Present'),
(3, 'hindi', '2023-11-02', 'Present'),
(3, 'science', '2023-11-02', 'Absent'),
(3, 'social_science', '2023-11-02', 'Present'),

(4, 'maths', '2023-11-02', 'Present'),
(4, 'english', '2023-11-02', 'Absent'),
(4, 'hindi', '2023-11-02', 'Present'),
(4, 'science', '2023-11-02', 'Present'),
(4, 'social_science', '2023-11-02', 'Present'),

(5, 'maths', '2023-11-02', 'Present'),
(5, 'english', '2023-11-02', 'Present'),
(5, 'hindi', '2023-11-02', 'Absent'),
(5, 'science', '2023-11-02', 'Present'),
(5, 'social_science', '2023-11-02', 'Present'),

-- Day 3 (Wednesday)
(1, 'maths', '2023-11-03', 'Present'),
(1, 'english', '2023-11-03', 'Present'),
(1, 'hindi', '2023-11-03', 'Absent'),
(1, 'science', '2023-11-03', 'Present'),
(1, 'social_science', '2023-11-03', 'Present'),

(2, 'maths', '2023-11-03', 'Present'),
(2, 'english', '2023-11-03', 'Present'),
(2, 'hindi', '2023-11-03', 'Present'),
(2, 'science', '2023-11-03', 'Present'),
(2, 'social_science', '2023-11-03', 'Present'),

(3, 'maths', '2023-11-03', 'Absent'),
(3, 'english', '2023-11-03', 'Present'),
(3, 'hindi', '2023-11-03', 'Present'),
(3, 'science', '2023-11-03', 'Present'),
(3, 'social_science', '2023-11-03', 'Absent'),

(4, 'maths', '2023-11-03', 'Present'),
(4, 'english', '2023-11-03', 'Present'),
(4, 'hindi', '2023-11-03', 'Present'),
(4, 'science', '2023-11-03', 'Absent'),
(4, 'social_science', '2023-11-03', 'Present'),

(5, 'maths', '2023-11-03', 'Present'),
(5, 'english', '2023-11-03', 'Absent'),
(5, 'hindi', '2023-11-03', 'Present'),
(5, 'science', '2023-11-03', 'Present'),
(5, 'social_science', '2023-11-03', 'Present'),

-- Day 4 (Thursday)
(1, 'maths', '2023-11-04', 'Present'),
(1, 'english', '2023-11-04', 'Present'),
(1, 'hindi', '2023-11-04', 'Present'),
(1, 'science', '2023-11-04', 'Present'),
(1, 'social_science', '2023-11-04', 'Absent'),

(2, 'maths', '2023-11-04', 'Present'),
(2, 'english', '2023-11-04', 'Absent'),
(2, 'hindi', '2023-11-04', 'Present'),
(2, 'science', '2023-11-04', 'Present'),
(2, 'social_science', '2023-11-04', 'Present'),

(3, 'maths', '2023-11-04', 'Present'),
(3, 'english', '2023-11-04', 'Present'),
(3, 'hindi', '2023-11-04', 'Absent'),
(3, 'science', '2023-11-04', 'Present'),
(3, 'social_science', '2023-11-04', 'Present'),

(4, 'maths', '2023-11-04', 'Absent'),
(4, 'english', '2023-11-04', 'Present'),
(4, 'hindi', '2023-11-04', 'Present'),
(4, 'science', '2023-11-04', 'Present'),
(4, 'social_science', '2023-11-04', 'Present'),

(5, 'maths', '2023-11-04', 'Present'),
(5, 'english', '2023-11-04', 'Present'),
(5, 'hindi', '2023-11-04', 'Present'),
(5, 'science', '2023-11-04', 'Absent'),
(5, 'social_science', '2023-11-04', 'Present'),

-- Day 5 (Friday)
(1, 'maths', '2023-11-05', 'Present'),
(1, 'english', '2023-11-05', 'Absent'),
(1, 'hindi', '2023-11-05', 'Present'),
(1, 'science', '2023-11-05', 'Present'),
(1, 'social_science', '2023-11-05', 'Present'),

(2, 'maths', '2023-11-05', 'Present'),
(2, 'english', '2023-11-05', 'Present'),
(2, 'hindi', '2023-11-05', 'Present'),
(2, 'science', '2023-11-05', 'Absent'),
(2, 'social_science', '2023-11-05', 'Present'),

(3, 'maths', '2023-11-05', 'Present'),
(3, 'english', '2023-11-05', 'Present'),
(3, 'hindi', '2023-11-05', 'Present'),
(3, 'science', '2023-11-05', 'Present'),
(3, 'social_science', '2023-11-05', 'Absent'),

(4, 'maths', '2023-11-05', 'Present'),
(4, 'english', '2023-11-05', 'Present'),
(4, 'hindi', '2023-11-05', 'Absent'),
(4, 'science', '2023-11-05', 'Present'),
(4, 'social_science', '2023-11-05', 'Present'),

(5, 'maths', '2023-11-05', 'Absent'),
(5, 'english', '2023-11-05', 'Present'),
(5, 'hindi', '2023-11-05', 'Present'),
(5, 'science', '2023-11-05', 'Present'),
(5, 'social_science', '2023-11-05', 'Present');

CREATE TABLE exam_schedule (
    exam_id INT auto_increment PRIMARY KEY,
    roll_number int,
    exam_name VARCHAR(100),
    exam_date DATE,
    subject VARCHAR(50),
    FOREIGN KEY (roll_number) REFERENCES student_details(roll_number)
);

INSERT INTO exam_schedule (roll_number, exam_name, exam_date, subject) VALUES
(1, 'Midterm Exam', '2025-05-20', 'Maths'),
(2, 'Midterm Exam', '2025-05-21', 'Science'),
(3, 'Midterm Exam', '2025-05-22', 'English'),
(4, 'Midterm Exam', '2025-05-23', 'Social Science'),
(1, 'Final Exam', '2025-06-01', 'Maths'),
(1, 'Final Exam', '2025-06-02', 'Science'),
(2, 'Final Exam', '2025-06-03', 'English'),
(7, 'Final Exam', '2025-06-04', 'Social Science'),
(8, 'Viva Exam', '2025-06-05', 'Computer'),
(10, 'Practical Exam', '2025-06-06', 'Physics');

CREATE TABLE assignments (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    roll_number INT NOT NULL,
    assignment_name VARCHAR(255) NOT NULL,
    subject VARCHAR(100) NOT NULL,
    due_date DATE NOT NULL,
    submitted BOOLEAN DEFAULT 0,
    submission_date DATETIME DEFAULT NULL,
    file_path VARCHAR(500) DEFAULT NULL,
    FOREIGN KEY (roll_number) REFERENCES student_details(roll_number)
);

INSERT INTO assignments (roll_number, assignment_name, subject, due_date, submitted)
VALUES 
(1, 'Algebra Homework', 'Maths', '2025-05-15', 0),
(2, 'Essay Writing', 'English', '2025-05-16', 1),
(3, 'Lab Report 1', 'Science', '2025-05-17', 0),
(4, 'History Notes', 'Social Science', '2025-05-18', 1),
(5, 'Grammar Practice', 'English', '2025-05-19', 0),
(6, 'Geometry Problems', 'Maths', '2025-05-20', 1),
(7, 'Environmental Essay', 'Science', '2025-05-21', 0),
(8, 'Civics Assignment', 'Social Science', '2025-05-22', 0),
(9, 'Literature Review', 'English', '2025-05-23', 1),
(10, 'Physics Worksheet', 'Science', '2025-05-24', 0),
(1, 'World Map Practice', 'Social Science', '2025-05-25', 1),
(2, 'Maths Quiz Practice', 'Maths', '2025-05-26', 0),
(3, 'Reading Log', 'English', '2025-05-27', 0),
(4, 'Solar System Report', 'Science', '2025-05-28', 1),
(5, 'Constitution Notes', 'Social Science', '2025-05-29', 0),
(6, 'Essay on Pollution', 'English', '2025-05-30', 1),
(7, 'Trigonometry Sheet', 'Maths', '2025-06-01', 0),
(8, 'Biology Worksheet', 'Science', '2025-06-02', 0),
(9, 'Freedom Fighters Essay', 'Social Science', '2025-06-03', 1),
(10, 'Novel Summary', 'English', '2025-06-04', 0);

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255),
    subject VARCHAR(100),
    available_copies INT DEFAULT 1
);

INSERT INTO books (title, author, subject, available_copies) VALUES
('Introduction to Algorithms', 'Thomas H. Cormen', 'Computer Science', 5),
('Clean Code', 'Robert C. Martin', 'Programming', 3),
('The Great Gatsby', 'F. Scott Fitzgerald', 'Literature', 7),
('A Brief History of Time', 'Stephen Hawking', 'Physics', 2),
('To Kill a Mockingbird', 'Harper Lee', 'Literature', 4),
('The Art of Computer Programming', 'Donald Knuth', 'Computer Science', 1),
('Design Patterns', 'Erich Gamma', 'Programming', 3),
('Pride and Prejudice', 'Jane Austen', 'Literature', 6),
('Cosmos', 'Carl Sagan', 'Astronomy', 2),
('The C Programming Language', 'Brian Kernighan', 'Programming', 4),
('Data Structures and Algorithms', 'Alfred Aho', 'Computer Science', 3),
('1984', 'George Orwell', 'Literature', 5),
('The Selfish Gene', 'Richard Dawkins', 'Biology', 3),
('JavaScript: The Good Parts', 'Douglas Crockford', 'Programming', 2),
('The Catcher in the Rye', 'J.D. Salinger', 'Literature', 4),
('Database System Concepts', 'Abraham Silberschatz', 'Computer Science', 3),
('Brave New World', 'Aldous Huxley', 'Literature', 3),
('The Origin of Species', 'Charles Darwin', 'Biology', 1),
('Python Crash Course', 'Eric Matthes', 'Programming', 5),
('Lord of the Flies', 'William Golding', 'Literature', 4),
('Operating System Concepts', 'Abraham Silberschatz', 'Computer Science', 2),
('The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 6),
('Artificial Intelligence: A Modern Approach', 'Stuart Russell', 'Computer Science', 2),
('Frankenstein', 'Mary Shelley', 'Literature', 3),
('The Elegant Universe', 'Brian Greene', 'Physics', 1),
('Head First Java', 'Kathy Sierra', 'Programming', 4),
('Animal Farm', 'George Orwell', 'Literature', 5),
('The Double Helix', 'James Watson', 'Biology', 2),
('Learning PHP, MySQL & JavaScript', 'Robin Nixon', 'Programming', 3),
('The Lord of the Rings', 'J.R.R. Tolkien', 'Fantasy', 4),
('Computer Networks', 'Andrew Tanenbaum', 'Computer Science', 2),
('Crime and Punishment', 'Fyodor Dostoevsky', 'Literature', 3),
('A Short History of Nearly Everything', 'Bill Bryson', 'Science', 4),
('Eloquent JavaScript', 'Marijn Haverbeke', 'Programming', 3),
('The Adventures of Huckleberry Finn', 'Mark Twain', 'Literature', 4),
('Computer Organization and Design', 'David Patterson', 'Computer Science', 2),
('The Picture of Dorian Gray', 'Oscar Wilde', 'Literature', 3),
('The Gene: An Intimate History', 'Siddhartha Mukherjee', 'Biology', 2),
('C++ Primer', 'Stanley Lippman', 'Programming', 3),
('The Brothers Karamazov', 'Fyodor Dostoevsky', 'Literature', 2),
('Introduction to the Theory of Computation', 'Michael Sipser', 'Computer Science', 1),
('The Alchemist', 'Paulo Coelho', 'Fiction', 5),
('The Hidden Life of Trees', 'Peter Wohlleben', 'Biology', 3),
('Effective Java', 'Joshua Bloch', 'Programming', 4),
('One Hundred Years of Solitude', 'Gabriel García Márquez', 'Literature', 3),
('Computer Architecture', 'John Hennessy', 'Computer Science', 2),
('The Road', 'Cormac McCarthy', 'Literature', 2),
('The Pragmatic Programmer', 'Andrew Hunt', 'Programming', 3),
('The Silent Patient', 'Alex Michaelides', 'Fiction', 4),
('Deep Learning', 'Ian Goodfellow', 'Computer Science', 1);

CREATE TABLE borrowed_books (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    roll_number INT NOT NULL,
    book_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE DEFAULT NULL,
    FOREIGN KEY (roll_number) REFERENCES student_details(roll_number),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

INSERT INTO borrowed_books (roll_number, book_id, borrow_date, due_date, return_date) VALUES
-- Current borrows (not yet returned)
(1, 3, '2023-10-01', '2023-10-15', NULL),
(2, 7, '2023-10-02', '2023-10-16', NULL),
(3, 12, '2023-10-03', '2023-10-17', NULL),
(4, 18, '2023-10-04', '2023-10-18', NULL),
(5, 22, '2023-10-05', '2023-10-19', NULL),
(6, 27, '2023-10-06', '2023-10-20', NULL),
(7, 31, '2023-10-07', '2023-10-21', NULL),
(8, 35, '2023-10-08', '2023-10-22', NULL),
(9, 40, '2023-10-09', '2023-10-23', NULL),
(10, 45, '2023-10-10', '2023-10-24', NULL),

-- Returned borrows (on time)
(1, 5, '2023-09-01', '2023-09-15', '2023-09-14'),
(2, 8, '2023-09-02', '2023-09-16', '2023-09-15'),
(3, 11, '2023-09-03', '2023-09-17', '2023-09-16'),
(4, 14, '2023-09-04', '2023-09-18', '2023-09-17'),
(5, 19, '2023-09-05', '2023-09-19', '2023-09-18'),
(6, 23, '2023-09-06', '2023-09-20', '2023-09-19'),
(7, 28, '2023-09-07', '2023-09-21', '2023-09-20'),
(8, 32, '2023-09-08', '2023-09-22', '2023-09-21'),
(9, 37, '2023-09-09', '2023-09-23', '2023-09-22'),
(10, 42, '2023-09-10', '2023-09-24', '2023-09-23'),

-- Returned borrows (late returns)
(1, 2, '2023-08-01', '2023-08-15', '2023-08-17'),
(2, 6, '2023-08-02', '2023-08-16', '2023-08-18'),
(3, 9, '2023-08-03', '2023-08-17', '2023-08-20'),
(4, 13, '2023-08-04', '2023-08-18', '2023-08-21'),
(5, 17, '2023-08-05', '2023-08-19', '2023-08-22'),
(6, 21, '2023-08-06', '2023-08-20', '2023-08-23'),
(7, 26, '2023-08-07', '2023-08-21', '2023-08-24'),
(8, 30, '2023-08-08', '2023-08-22', '2023-08-25'),
(9, 34, '2023-08-09', '2023-08-23', '2023-08-26'),
(10, 38, '2023-08-10', '2023-08-24', '2023-08-27'),

-- Recently returned
(1, 4, '2023-10-05', '2023-10-19', '2023-10-18'),
(2, 10, '2023-10-06', '2023-10-20', '2023-10-19'),
(3, 15, '2023-10-07', '2023-10-21', '2023-10-20'),
(4, 20, '2023-10-08', '2023-10-22', '2023-10-21'),
(5, 25, '2023-10-09', '2023-10-23', '2023-10-22'),
(6, 29, '2023-10-10', '2023-10-24', '2023-10-23'),
(7, 33, '2023-10-11', '2023-10-25', '2023-10-24'),
(8, 36, '2023-10-12', '2023-10-26', '2023-10-25'),
(9, 41, '2023-10-13', '2023-10-27', '2023-10-26'),
(10, 46, '2023-10-14', '2023-10-28', '2023-10-27'),

-- Long-term borrows
(1, 1, '2023-07-01', '2023-07-15', '2023-07-14'),
(2, 16, '2023-07-05', '2023-07-19', '2023-07-18'),
(3, 24, '2023-07-10', '2023-07-24', '2023-07-23'),
(4, 39, '2023-07-15', '2023-07-29', '2023-07-28'),
(5, 47, '2023-07-20', '2023-08-03', '2023-08-02'),
(6, 48, '2023-07-25', '2023-08-08', '2023-08-07'),
(7, 49, '2023-07-30', '2023-08-13', '2023-08-12'),
(8, 50, '2023-08-04', '2023-08-18', '2023-08-17'),
(9, 43, '2023-08-09', '2023-08-23', '2023-08-22'),
(10, 44, '2023-08-14', '2023-08-28', '2023-08-27');

CREATE TABLE student_fees (
    fee_id INT AUTO_INCREMENT PRIMARY KEY,
    roll_number INT NOT NULL,
    fee_type VARCHAR(100) NOT NULL,           -- e.g., Tuition, Hostel, Lab
    total_amount DECIMAL(10,2) NOT NULL,
    paid_amount DECIMAL(10,2) DEFAULT 0.00,
    due_date DATE NOT NULL,
    FOREIGN KEY (roll_number) REFERENCES student_credential(roll_number)
        ON DELETE CASCADE
);

CREATE TABLE fee_payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    roll_number INT NOT NULL,
    payment_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    amount DECIMAL(10,2) NOT NULL,
    method VARCHAR(50) NOT NULL,              -- e.g., UPI, Cash, Bank Transfer
    reference_id VARCHAR(100),                -- Optional: transaction/receipt number
    FOREIGN KEY (roll_number) REFERENCES student_credential(roll_number)
        ON DELETE CASCADE
);

-- Insert sample fee records
INSERT INTO student_fees (roll_number, fee_type, total_amount, paid_amount, due_date) VALUES
(1, 'Tuition', 50000, 20000, '2025-06-30'),
(2, 'Tuition', 50000, 50000, '2025-06-30'),
(3, 'Hostel', 30000, 10000, '2025-06-15'),
(4, 'Lab Fee', 10000, 0, '2025-07-10'),
(5, 'Tuition', 50000, 45000, '2025-06-30'),
(6, 'Hostel', 30000, 30000, '2025-06-15'),
(7, 'Lab Fee', 10000, 5000, '2025-07-10'),
(8, 'Tuition', 50000, 0, '2025-06-30'),
(9, 'Hostel', 30000, 25000, '2025-06-15'),
(10, 'Lab Fee', 10000, 10000, '2025-07-10');

-- Insert some fee payments
INSERT INTO fee_payments (roll_number, amount, method, reference_id) VALUES
(1, 10000, 'UPI', 'TXN12345'),
(1, 10000, 'Cash', 'TXN12346'),
(2, 50000, 'Bank Transfer', 'TXN22345'),
(5, 45000, 'UPI', 'TXN52345'),
(9, 25000, 'Bank Transfer', 'TXN92345');


