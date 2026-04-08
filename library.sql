-- =========================
-- DIGITAL LIBRARY DATABASE
-- =========================

-- 1. TABLE CREATION (DDL)

CREATE TABLE Books (
    BookID NUMBER PRIMARY KEY,
    Title VARCHAR2(100),
    Author VARCHAR2(100),
    Category VARCHAR2(50)
);

CREATE TABLE Students (
    StudentID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Email VARCHAR2(100),
    JoinDate DATE,
    Status VARCHAR2(10)
);

CREATE TABLE IssuedBooks (
    IssueID NUMBER PRIMARY KEY,
    BookID NUMBER,
    StudentID NUMBER,
    IssueDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

-- =========================
-- 2. INSERT DATA
-- =========================
INSERT INTO Books VALUES (1, 'Java Basics', 'John Smith', 'Science');
INSERT INTO Books VALUES (2, 'World History', 'David Miller', 'History');
INSERT INTO Books VALUES (3, 'Mystery Island', 'Emily Clark', 'Fiction');
INSERT INTO Books VALUES (4, 'DBMS Guide', 'Robert Brown', 'Science');
INSERT INTO Books VALUES (5, 'English Grammar', 'William Green', 'Education');
INSERT INTO Books VALUES (6, 'Physics Intro', 'Albert Ray', 'Science');
INSERT INTO Books VALUES (7, 'Indian Economy', 'Ramesh Singh', 'Economics');
INSERT INTO Books VALUES (8, 'Short Stories', 'Leo Tolstoy', 'Fiction');
INSERT INTO Books VALUES (9, 'Networks', 'Andrew Tanenbaum', 'Science');
INSERT INTO Books VALUES (10, 'Geography', 'Helen Scott', 'Geography');

--display Books table

select * from books;

INSERT INTO Students VALUES (101, 'Ashwitha', 'ash@gmail.com', TO_DATE('2023-01-10','YYYY-MM-DD'), 'Active');
INSERT INTO Students VALUES (102, 'Anita', 'anita@gmail.com', TO_DATE('2024-06-15','YYYY-MM-DD'), 'Active');
INSERT INTO Students VALUES (103, 'Suresh Reddy', 'suresh@gmail.com', TO_DATE('2022-09-20','YYYY-MM-DD'), 'Active');
INSERT INTO Students VALUES (104, 'Priya Singh', 'priya@gmail.com', TO_DATE('2023-03-12','YYYY-MM-DD'), 'Active');
INSERT INTO Students VALUES (105, 'Varshitha', 'varshitha@gmail.com', TO_DATE('2021-11-05','YYYY-MM-DD'), 'Active');
INSERT INTO Students VALUES (106, 'Neha Gupta', 'neha@gmail.com', TO_DATE('2024-01-25','YYYY-MM-DD'), 'Active');
INSERT INTO Students VALUES (107, 'raveena', 'raveena@gmail.com', TO_DATE('2022-07-18','YYYY-MM-DD'), 'Active');
INSERT INTO Students VALUES (108, 'Meena Iyer', 'meena@gmail.com', TO_DATE('2023-08-09','YYYY-MM-DD'), 'Active');
INSERT INTO Students VALUES (109, 'Rahul Das', 'rahul@gmail.com', TO_DATE('2024-02-14','YYYY-MM-DD'), 'Active');
INSERT INTO Students VALUES (110, 'Sneha', 'sneha@gmail.com', TO_DATE('2021-05-30','YYYY-MM-DD'), 'Active');

--display students table

select * from students;

INSERT INTO IssuedBooks VALUES (1, 1, 101, TO_DATE('2026-03-01','YYYY-MM-DD'), NULL);
INSERT INTO IssuedBooks VALUES (2, 4, 102, TO_DATE('2026-03-05','YYYY-MM-DD'), NULL);
INSERT INTO IssuedBooks VALUES (3, 6, 103, TO_DATE('2026-03-02','YYYY-MM-DD'), NULL);
INSERT INTO IssuedBooks VALUES (4, 2, 104, TO_DATE('2026-03-25','YYYY-MM-DD'), NULL);
INSERT INTO IssuedBooks VALUES (5, 5, 105, TO_DATE('2026-03-28','YYYY-MM-DD'), NULL);
INSERT INTO IssuedBooks VALUES (6, 3, 106, TO_DATE('2026-02-10','YYYY-MM-DD'), TO_DATE('2026-02-20','YYYY-MM-DD'));
INSERT INTO IssuedBooks VALUES (7, 7, 107, TO_DATE('2026-02-15','YYYY-MM-DD'), TO_DATE('2026-02-25','YYYY-MM-DD'));
INSERT INTO IssuedBooks VALUES (8, 8, 108, TO_DATE('2026-03-10','YYYY-MM-DD'), NULL);
INSERT INTO IssuedBooks VALUES (9, 9, 109, TO_DATE('2026-03-12','YYYY-MM-DD'), TO_DATE('2026-03-20','YYYY-MM-DD'));
INSERT INTO IssuedBooks VALUES (10, 10, 110, TO_DATE('2026-03-03','YYYY-MM-DD'), NULL);

--display issuedbooks;
 
select * from IssuedBooks;

COMMIT;

-- =========================
-- 3. OVERDUE BOOKS QUERY
-- =========================

SELECT s.StudentID, s.Name, b.Title, i.IssueDate
FROM IssuedBooks i
JOIN Students s ON i.StudentID = s.StudentID
JOIN Books b ON i.BookID = b.BookID
WHERE i.ReturnDate IS NULL
AND i.IssueDate < SYSDATE - 14;

-- =========================
-- 4. POPULARITY INDEX
-- =========================

SELECT b.Category, COUNT(*) AS Total_Borrows
FROM IssuedBooks i
JOIN Books b ON i.BookID = b.BookID
GROUP BY b.Category
ORDER BY Total_Borrows DESC;

-- =========================
-- 5. DATA CLEANUP
-- =========================

UPDATE Students
SET Status = 'Inactive'
WHERE StudentID NOT IN (
    SELECT DISTINCT StudentID
    FROM IssuedBooks
    WHERE IssueDate >= ADD_MONTHS(SYSDATE, -36)
);

-- Check result
SELECT StudentID, Name, Status FROM Students;