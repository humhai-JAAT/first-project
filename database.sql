create database project;

use project;

CREATE TABLE student_details (
    roll_number INT primary key,
    address VARCHAR(100),
    contact_number VARCHAR(15),
    mail_id VARCHAR(100),
    class VARCHAR(10),
    stu_photo longblob 
);

CREATE TABLE student_marks (
    roll_number INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    maths INT,
    english INT,
    hindi INT,
    science INT,
    social_science INT,
    total_marks INT,
    percentage FLOAT,
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

INSERT INTO student_details (roll_number, address, contact_number, mail_id, class)
VALUES
(1, '456 Oak St, Brooklyn, NY', '9876543211', 'alicia.bright@example.com', '10A'),
(2, '789 Elm Rd, Austin, TX', '9876543212', 'leslie.williams@example.com', '10A'),
(3, '321 Maple Dr, Miami, FL', '9876543213', 'amy.hawkins@example.com', '10A'),
(4, '654 Pine Ln, Denver, CO', '9876543214', 'morgan.branch@example.com', '10A'),
(5, '12 Sunset Blvd, Phoenix, AZ', '9876543215', 'brittany.bell@example.com', '10A'),
(6, '77 Hilltop Rd, Seattle, WA', '9876543216', 'mary.miller@example.com', '10A'),
(7, '90 Lakeview Ave, Chicago, IL', '9876543217', 'eric.foster@example.com', '10A'),
(8, '105 Forest Way, Orlando, FL', '9876543218', 'anna.harrison@example.com', '10A'),
(9, '42 Mountain Rd, Boston, MA', '9876543219', 'marcus.richardson@example.com', '10A'),
(10, '123 Main St, Springfield, IL', '9876543210', 'john.callahan@example.com', '10A');


INSERT INTO major_marks (roll_number, first_name, last_name, maths, english, hindi, science, social_science, total_marks, percentage)
VALUES
(1, 'Alicia', 'Bright', 75, 87, 63, 98, 70, 393, 78.6),
(2, 'Leslie', 'Williams', 42, 86, 76, 88, 55, 347, 69.4),
(3, 'Amy', 'Hawkins', 95, 50, 87, 64, 82, 378, 75.6),
(4, 'Morgan', 'Branch', 49, 98, 68, 57, 100, 372, 74.4),
(5, 'Brittany', 'Bell', 79, 72, 58, 67, 62, 338, 67.6),
(6, 'Mary', 'Miller', 71, 55, 46, 60, 77, 309, 61.8),
(7, 'Eric', 'Foster', 95, 73, 99, 99, 65, 431, 86.2),
(8, 'Anna', 'Harrison', 54, 44, 49, 66, 75, 288, 57.6),
(9, 'Marcus', 'Richardson', 87, 67, 98, 83, 79, 414, 82.8),
(10, 'John', 'Callahan', 78, 40, 46, 61, 43, 268, 53.6);

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


CREATE TABLE unit_1_marks (
    roll_number INT PRIMARY KEY,
    maths INT,
    english INT,
    hindi INT,
    science INT,
    social_science INT
);

CREATE TABLE unit_2_marks (
    roll_number INT PRIMARY KEY,
    maths INT,
    english INT,
    hindi INT,
    science INT,
    social_science INT
);

-- Example: Add foreign key if students table exists
ALTER TABLE unit_1_marks
ADD CONSTRAINT fk_unit1_roll
FOREIGN KEY (roll_number) REFERENCES student_details(roll_number)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE unit_2_marks
ADD CONSTRAINT fk_unit2_roll
FOREIGN KEY (roll_number) REFERENCES student_details(roll_number)
ON DELETE CASCADE
ON UPDATE CASCADE;

INSERT INTO unit_1_marks (roll_number, maths, english, hindi, science, social_science) VALUES
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

INSERT INTO unit_2_marks (roll_number, maths, english, hindi, science, social_science) VALUES
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

