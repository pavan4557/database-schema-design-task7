-- =============================
-- Task 2: Database & Tables
-- =============================

DROP DATABASE IF EXISTS library;
CREATE DATABASE library;
USE library;

-- Category Table
CREATE TABLE Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Author Table
CREATE TABLE Author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Book Table
CREATE TABLE Book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    published_year INT,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

-- Book_Author (Many-to-Many Relation)
CREATE TABLE Book_Author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id),
    FOREIGN KEY (author_id) REFERENCES Author(author_id)
);

-- Member Table
CREATE TABLE Member (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    join_date DATE NOT NULL
);

-- Loan Table
CREATE TABLE Loan (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    loan_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Book(book_id),
    FOREIGN KEY (member_id) REFERENCES Member(member_id)
);

-- =============================
-- Task 2: Insert Sample Data
-- =============================

INSERT INTO Category (name) VALUES 
('Programming'),
('Databases'),
('Networking');

INSERT INTO Author (name) VALUES 
('James Gosling'),
('C.J. Date'),
('Andrew Tanenbaum');

INSERT INTO Book (title, published_year, category_id) VALUES
('Java Programming', 1995, 1),
('Database Systems', 2000, 2),
('Computer Networks', 2011, 3);

INSERT INTO Book_Author (book_id, author_id) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO Member (name, email, join_date) VALUES
('Pavan', 'pavan@example.com', '2025-01-10'),
('Kalyan', NULL, '2025-02-15'),
('Ravi', 'ravi@example.com', '2025-03-20');

INSERT INTO Loan (book_id, member_id, loan_date, return_date) VALUES
(1, 1, '2025-09-01', NULL),
(2, 2, '2025-09-05', '2025-09-12'),
(3, 3, '2025-09-10', NULL);

-- =============================
-- Task 2: Update & Delete
-- =============================

UPDATE Book
SET published_year = 1996
WHERE book_id = 1;

UPDATE Member
SET email = 'not_provided@example.com'
WHERE email IS NULL;

DELETE FROM Loan WHERE loan_id = 2;
DELETE FROM Book_Author WHERE book_id = 3;

-- =============================
-- Task 3: SELECT Queries
-- =============================

SELECT * FROM Book;
SELECT * FROM Member;

SELECT title, published_year FROM Book;
SELECT name, email FROM Member;

SELECT * FROM Book WHERE published_year > 2000;
SELECT * FROM Member WHERE join_date > '2025-02-01';

SELECT * FROM Book WHERE category_id = 2 AND published_year < 2010;

SELECT * FROM Book WHERE title LIKE '%Java%';
SELECT * FROM Member WHERE name LIKE 'P%';

SELECT * FROM Book WHERE published_year BETWEEN 1990 AND 2005;
SELECT * FROM Member 
WHERE join_date BETWEEN '2025-01-01' AND '2025-03-31';

SELECT * FROM Book ORDER BY published_year DESC;
SELECT * FROM Member ORDER BY join_date ASC;

SELECT * FROM Book LIMIT 2;
SELECT * FROM Member LIMIT 1;

-- =============================
-- Task 4: Aggregate Functions & Grouping
-- =============================

SELECT COUNT(*) AS total_books FROM Book;

SELECT category_id, COUNT(*) AS books_in_category
FROM Book
GROUP BY category_id;

SELECT AVG(published_year) AS avg_published_year FROM Book;

SELECT MAX(published_year) AS newest_book, MIN(published_year) AS oldest_book FROM Book;

SELECT category_id, COUNT(*) AS book_count
FROM Book
GROUP BY category_id
HAVING COUNT(*) > 1;

SELECT m.name, COUNT(l.loan_id) AS loans_count
FROM Member m
LEFT JOIN Loan l ON m.member_id = l.member_id
GROUP BY m.member_id
HAVING COUNT(l.loan_id) > 0;

SELECT COUNT(DISTINCT category_id) AS unique_categories FROM Book;

SELECT ROUND(AVG(published_year), 0) AS avg_year_rounded FROM Book;

-- =============================
-- Task 5: Joins
-- =============================

-- INNER JOIN
SELECT m.name, b.title, l.loan_date, l.return_date
FROM Loan l
JOIN Member m ON l.member_id = m.member_id
JOIN Book b ON l.book_id = b.book_id;

-- LEFT JOIN
SELECT m.name, b.title, l.loan_date
FROM Member m
LEFT JOIN Loan l ON m.member_id = l.member_id
LEFT JOIN Book b ON l.book_id = b.book_id;

-- RIGHT JOIN (works in MySQL, not in SQLite)
SELECT b.title, m.name, l.loan_date
FROM Book b
RIGHT JOIN Loan l ON b.book_id = l.book_id
RIGHT JOIN Member m ON l.member_id = m.member_id;

-- FULL JOIN simulation (MySQL doesn’t support FULL JOIN)
SELECT m.name, b.title, l.loan_date
FROM Member m
LEFT JOIN Loan l ON m.member_id = l.member_id
LEFT JOIN Book b ON l.book_id = b.book_id
UNION
SELECT m.name, b.title, l.loan_date
FROM Member m
RIGHT JOIN Loan l ON m.member_id = l.member_id
RIGHT JOIN Book b ON l.book_id = b.book_id;

-- JOIN 3 Tables
SELECT m.name AS member_name, b.title AS book_title, c.name AS category, l.loan_date
FROM Loan l
JOIN Member m ON l.member_id = m.member_id
JOIN Book b ON l.book_id = b.book_id
JOIN Category c ON b.category_id = c.category_id;

-- =============================
-- Task 6: Subqueries
-- =============================

-- Scalar Subquery
SELECT title, published_year
FROM Book
WHERE published_year = (SELECT MAX(published_year) FROM Book);

-- Correlated Subquery
SELECT name 
FROM Author a
WHERE (
    SELECT COUNT(*) 
    FROM Book_Author ba 
    WHERE ba.author_id = a.author_id
) > 1;

-- IN Subquery
SELECT title 
FROM Book
WHERE category_id IN (
    SELECT category_id 
    FROM Category 
    WHERE name IN ('Programming', 'Databases')
);

-- EXISTS Subquery
SELECT name 
FROM Author a
WHERE EXISTS (
    SELECT 1 
    FROM Book_Author ba
    JOIN Book b ON ba.book_id = b.book_id
    JOIN Category c ON b.category_id = c.category_id
    WHERE ba.author_id = a.author_id AND c.name = 'Networking'
);

-- FROM Subquery (Derived Table)
SELECT c.name AS category, avg_table.avg_year
FROM (
    SELECT category_id, AVG(published_year) AS avg_year
    FROM Book
    GROUP BY category_id
) avg_table
JOIN Category c ON c.category_id = avg_table.category_id;
