#Digital Library Database (SQL Project)

## Project Overview

This project implements a **Digital Library Management System** using MySQL.
It helps track:

* Books available in the library
* Students who borrow books
* Issued and returned books
* Overdue records
* Popular book categories
* Inactive student accounts

---

## Database Structure

### 1. Books Table

Stores information about books.

* `BookID` (Primary Key)
* `Title`
* `Author`
* `Category`

### 2. Students Table

Stores student details.

* `StudentID` (Primary Key)
* `Name`
* `Email`
* `JoinDate`

### 3. Issued_Books Table

Tracks book borrowing.

* `IssueID` (Primary Key)
* `BookID` (Foreign Key)
* `StudentID` (Foreign Key)
* `IssueDate`
* `ReturnDate`

---

## Relationships

* One student can borrow multiple books
* One book can be borrowed multiple times
* Implemented using **Issued_Books (bridge table)**

---

## ⚙️ Features Implemented

### 1. Overdue Books Detection

Finds students who have not returned books within 14 days.

```sql
SELECT s.StudentID, s.Name
FROM Students s
JOIN Issued_Books i ON i.StudentID = s.StudentID
WHERE i.IssueDate < DATE_SUB(CURDATE(), INTERVAL 14 DAY)
AND i.ReturnDate IS NULL;
```

---

###2. Most Popular Book Category

Identifies which genre is borrowed the most.

```sql
SELECT b.Category, COUNT(*) AS TotalBorrows
FROM Books b
JOIN Issued_Books ib ON b.BookID = ib.BookID
GROUP BY b.Category
ORDER BY TotalBorrows DESC;
```

---

###3. Inactive Students Detection

Marks students who haven’t borrowed books in the last 3 years.

```sql
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
```

---

## Sample Data

* 10 Books
* 10 Students
* 10 Issued Records

Includes:

* Returned books
* Not returned books
* Overdue cases
* Old records for inactivity testing

---

## Key Concepts Used

* DDL (CREATE TABLE)
* DML (INSERT, UPDATE)
* JOIN (INNER JOIN, LEFT JOIN)
* GROUP BY & COUNT
* Date functions (`CURDATE()`, `DATE_SUB`)
* Subqueries
* Foreign Key Constraints

---

## Conclusion

This project demonstrates how SQL can be used to:

* Manage real-world data
* Perform analysis
* Identify trends and inactive users

It can be further extended with:

* Fine/Penalty calculation
* Login system
* Admin dashboard

---

## 👩‍💻 Author

Nama Ashwitha
