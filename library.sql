create database mini;
use  mini;
-- =========================
-- DIGITAL LIBRARY DATABASE
-- =========================

-- BOOKS TABLE
-- =========================
-- DIGITAL LIBRARY DATABASE
-- =========================

-- BOOKS TABLE
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Category VARCHAR(50)
);

-- STUDENTS TABLE
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    JoinDate DATE
);

-- ISSUED_BOOKS TABLE
CREATE TABLE Issued_Books (
    IssueID INT PRIMARY KEY,
    BookID INT,
    StudentID INT,
    IssueDate DATE,
    ReturnDate DATE,

    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

  -- insert values
  
  INSERT INTO Books VALUES
(1, 'Introduction to Programming', 'John Smith', 'Technology'),
(2, 'Basic Mathematics', 'R.K. Sharma', 'Education'),
(3, 'World History', 'Anita Verma', 'History'),
(4, 'Physics Fundamentals', 'S. Chand', 'Science'),
(5, 'English Grammar Guide', 'P. Kumar', 'Education'),
(6, 'Business Management', 'R. Gupta', 'Commerce'),
(7, 'Environmental Studies', 'M. Reddy', 'Science'),
(8, 'Data Structures Basics', 'K. Rao', 'Technology'),
(9, 'General Knowledge', 'S. Patel', 'Education'),
(10, 'Introduction to Economics', 'V. Mehta', 'Commerce');

INSERT INTO Students VALUES
(101, 'Asha', 'asha@gmail.com', '2022-01-10'),
(102, 'Ravi', 'ravi@gmail.com', '2018-06-15'),
(103, 'Kiran', 'kiran@gmail.com', '2020-09-20'),
(104, 'Sneha', 'sneha@gmail.com', '2023-03-05'),
(105, 'Arjun', 'arjun@gmail.com', '2022-11-11'),
(106, 'Divya', 'divya@gmail.com', '2019-07-25'),
(107, 'Rahul', 'rahul@gmail.com', '2021-12-01'),
(108, 'Pooja', 'pooja@gmail.com', '2020-05-30'),
(109, 'Nikhil', 'nikhil@gmail.com', '2018-08-18'),
(110, 'Meena', 'meena@gmail.com', '2023-02-14');


INSERT INTO Issued_Books VALUES
(1, 1, 101, '2026-03-01', '2026-03-10'),
(2, 2, 102, '2019-03-05', '2020-03-09'),
(3, 3, 103, '2026-02-20', NULL),
(4, 4, 104, '2026-03-15', '2026-03-25'),
(5, 5, 105, '2026-03-18', NULL),
(6, 6, 106, '2026-02-10', NULL),
(7, 7, 107, '2026-03-22', '2026-03-28'),
(8, 8, 108, '2026-01-30', NULL),
(9, 9, 109, '2026-03-12', '2026-03-20'),
(10, 10, 110, '2026-02-25', NULL);


SELECT s.StudentID, s.Name
FROM Students s
JOIN Issued_Books i
ON i.StudentID = s.StudentID
WHERE i.IssueDate < DATE_SUB(CURDATE(), INTERVAL 14 DAY)
AND i.ReturnDate IS NULL;

SELECT b.Category, COUNT(*) AS TotalBorrows
FROM Books b
JOIN Issued_Books ib ON b.BookID = ib.BookID
GROUP BY b.Category
ORDER BY TotalBorrows DESC;

UPDATE Issued_Books
SET IssueDate = '2018-01-01'
WHERE StudentID = 103;

SET SQL_SAFE_UPDATES = 0;
UPDATE Students
SET Name = CONCAT(Name, ' (Inactive)')
WHERE StudentID IN (
    SELECT StudentID FROM (
        SELECT s.StudentID
        FROM Students s
        LEFT JOIN Issued_Books ib 
        ON s.StudentID = ib.StudentID
        AND ib.IssueDate >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
        WHERE ib.StudentID IS NULL
    ) AS temp
);
SELECT *
FROM Students
WHERE Name LIKE '%(Inactive)%';
select * from students;

