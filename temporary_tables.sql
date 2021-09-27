USE employees;

CREATE TEMPORARY TABLE hopper_1563.employees_with_salaries AS 
SELECT * FROM employees JOIN salaries USING(emp_no);

use hopper_1563;
SELECT * FROM employees_with_salaries;
-- ------------------------------------EXERCISES---------------------------------------------------
-- 1. Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, 
-- and dept_name for employees currently with that department
USE employees;
CREATE TEMPORARY TABLE hopper_1563.employees_with_departments AS
SELECT first_name, last_name, dept_name
FROM employees 
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no);
-- 1.a.Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name 
-- and last name columns
