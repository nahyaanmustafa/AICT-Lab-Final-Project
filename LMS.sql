CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(100)
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(150),
    Author VARCHAR(100),
    Genre VARCHAR(50)
);

CREATE TABLE BorrowRecords (
    RecordID INT PRIMARY KEY,
    MemberID INT,
    BookID INT,
    BorrowDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

INSERT INTO Members (MemberID, Name, Email) VALUES 
(1, 'Saad Khan', 'saad.k@gmail.com'),
(2, 'Zara Ahmed', 'zara99@hotmail.com'),
(3, 'Bilal Raza', 'bilal.r@gmail.com'),
(4, 'Ayesha Malik', 'ayesha.m@yahoo.com');

INSERT INTO Books (BookID, Title, Author, Genre) VALUES
(101, 'The Alchemist', 'Paulo Coelho', 'Fiction'),
(102, 'Pir-E-Kamil', 'Umerah Ahmed', 'Fiction'),
(103, 'Atomic Habits', 'James Clear', 'Self-help'),
(104, 'Intro to Algorithms', 'Thomas Cormen', 'Computer Science');

INSERT INTO BorrowRecords (RecordID, MemberID, BookID, BorrowDate, ReturnDate) VALUES
(1, 1, 101, '2025-01-02', '2025-01-09'),
(2, 2, 102, '2025-01-05', NULL),
(3, 3, 103, '2025-01-07', '2025-01-14'),
(4, 1, 102, '2025-01-15', NULL),
(5, 4, 104, '2025-02-01', NULL);

SELECT m.Name, b.Title
FROM BorrowRecords r
JOIN Members m ON r.MemberID = m.MemberID
JOIN Books b ON r.BookID = b.BookID;

SELECT b.Title
FROM BorrowRecords r
JOIN Books b ON r.BookID = b.BookID
WHERE r.ReturnDate IS NULL;

SELECT m.Name, COUNT(*) AS BooksBorrowed
FROM BorrowRecords r
JOIN Members m ON m.MemberID = r.MemberID
GROUP BY m.MemberID;

SELECT DISTINCT m.Name
FROM BorrowRecords r
JOIN Members m ON r.MemberID = m.MemberID
JOIN Books b ON r.BookID = b.BookID
WHERE b.Genre = 'Computer Science';

SELECT b.Genre, COUNT(r.BookID) AS TotalBorrows
FROM BorrowRecords r
JOIN Books b ON r.BookID = b.BookID
GROUP BY b.Genre
ORDER BY TotalBorrows DESC
LIMIT 2;

SELECT m.Name, COUNT(r.BookID) AS Total
FROM Members m
JOIN BorrowRecords r ON m.MemberID = r.MemberID
GROUP BY m.Name
HAVING COUNT(r.BookID) > 1;