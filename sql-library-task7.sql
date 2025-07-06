-- Use the correct database
USE LibraryDB;

-- 1️⃣ Create a view of member names and the books they borrowed
CREATE VIEW MemberBorrowedBooks AS
SELECT m.Name AS MemberName, b.Title AS BookTitle, br.BorrowDate
FROM Members m
JOIN Borrow br ON m.MemberID = br.MemberID
JOIN Books b ON br.BookID = b.BookID;

-- ✅ Usage Example:
SELECT * FROM MemberBorrowedBooks;

-- 2️⃣ View showing members who borrowed more than 1 book
CREATE VIEW FrequentBorrowers AS
SELECT MemberID, COUNT(*) AS TotalBorrows
FROM Borrow
GROUP BY MemberID
HAVING COUNT(*) > 1;

-- ✅ Usage Example:
SELECT * FROM FrequentBorrowers;

-- 3️⃣ View showing borrow history with author names
CREATE VIEW BorrowWithAuthors AS
SELECT br.BorrowID, m.Name AS MemberName, b.Title AS BookTitle, a.Name AS AuthorName, br.BorrowDate
FROM Borrow br
JOIN Members m ON br.MemberID = m.MemberID
JOIN Books b ON br.BookID = b.BookID
JOIN Authors a ON b.AuthorID = a.AuthorID;

-- ✅ Usage Example:
SELECT * FROM BorrowWithAuthors;

-- 4️⃣ Drop a view (example)
-- DROP VIEW IF EXISTS FrequentBorrowers;

-- 5️⃣ Create a secured view showing only members who borrowed books (abstraction)
CREATE VIEW SecureMemberInfo AS
SELECT DISTINCT m.MemberID, m.Name
FROM Members m
WHERE EXISTS (
    SELECT 1 FROM Borrow br WHERE br.MemberID = m.MemberID
)
WITH CHECK OPTION;