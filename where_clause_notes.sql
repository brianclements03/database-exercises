SHOW databases;
USE employees;
DESCRIBE employees;
SELECT first_name
FROM employees
WHERE first_name LIKE '%sus%';
-- This query will select all first names with the letters combination 'sus'
SELECT DISTINCT first_name
FROM employees
WHERE first_name LIKE '%sus%';
-- instead of seeing over 1,600 names with sus in them, we can see the 7 distinct names with 'sus' in them.
SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no BETWEEN 10026 AND 10082;
-- Define employee number boundaries
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name IN ('Herber', 'Dredge', 'Lipner', 'Baek');
-- all employees with these ^ last names
SELECT emp_no, title
FROM titles
WHERE to_date IS NOT NULL;
-- self explanatory...
SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no < 20000
  AND last_name IN ('Herber','Baek')
   OR first_name = 'Shridhar';
-- chaining where statements
SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no < 20000
  AND (
      last_name IN ('Herber','Baek')
   OR first_name = 'Shridhar'
);
-- force evaluation grouping??^^
