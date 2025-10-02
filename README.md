# database-schema-design-task7
README Content (creating_views_README.md)
📌 Task Objective

The objective of this task is to learn how to create and use views in SQL to:

Simplify complex queries

Reuse SQL logic

Restrict access to specific columns or rows

🛠 Tools Used

DB Browser for SQLite

SQLiteStudio

MySQL Workbench

📂 Deliverables

SQL script: creating_views.sql

Examples of:

Simple view (recent_books)

Join view (loan_summary)

Aggregate view (category_book_count)

📖 Hints / Mini Guide

Use CREATE VIEW with complex SELECT queries

Views can provide data abstraction and security

Test views with SELECT * FROM view_name;

Drop views first with DROP VIEW IF EXISTS view_name;

📖 Interview Questions & Answers
Question	Answer
1️⃣ What is a view?

A virtual table based on a SQL query
Example:

CREATE VIEW recent_books AS
SELECT * FROM Book WHERE published_year > 2000;


2️⃣ Can we update data through a view?

Yes, only for simple single-table views without aggregation

3️⃣ What is a materialized view?

A view where results are stored physically for faster access

4️⃣ Difference between view and table?

Feature	Table	View
Storage	Physical	Query only
Updates	Always possible	Only simple views
Security	Full	Restrict columns/rows

5️⃣ How to drop a view?

DROP VIEW view_name;


6️⃣ Why use views?

Simplify complex queries

Reuse SQL logic

Restrict access to sensitive data

7️⃣ Can we create indexed views?

Only in some databases (SQL Server)

MySQL & SQLite do not support indexed views

8️⃣ How to secure data using views?

Grant access to view only

Restrict columns/rows
Example:

GRANT SELECT ON recent_books TO user_name;


9️⃣ What are limitations of views?

Cannot update multi-table or aggregate views

No physical storage (except materialized views)

Some performance overhead

🔟 How does WITH CHECK OPTION work?

Ensures INSERT/UPDATE via view meets the view’s conditions
Example:

CREATE VIEW recent_books AS
SELECT * FROM Book
WHERE published_year > 2000
WITH CHECK OPTION;


📑 Key Concepts

Views

Data Abstraction

Query Reusability

Security & Access Control
