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
What is a view?
A virtual table based on a SQL query.
Can we update data through a view?
Yes, if it’s a simple single-table view without aggregation.
What is a materialized view?
A view where query results are stored physically for faster access.
Difference between view and table?
Table stores data; view stores query only.
How to drop a view?
DROP VIEW view_name;
Why use views?
For abstraction, security, and reuse of queries.
Can we create indexed views?
Only in some databases like SQL Server.
How to secure data using views?
Grant access to view only, restrict columns/rows.
What are limitations of views?
Cannot update multi-table/aggregate views; no physical storage; performance overhead.
How does WITH CHECK OPTION work?
Ensures updates/inserts via view meet the view’s conditions.


📑 Key Concepts

Views

Data Abstraction

Query Reusability

Security & Access Control
