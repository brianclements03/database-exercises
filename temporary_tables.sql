USE employees;

CREATE TEMPORARY TABLE hopper_1563.employees_with_salaries AS 
SELECT * FROM employees JOIN salaries USING(emp_no);

use hopper_1563;
SELECT * FROM hopper_1563.employees_with_salaries;
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
USE hopper_1563;
ALTER TABLE employees_with_departments ADD full_name VARCHAR(100);
-- 1.b.Update the table so that full name column contains the correct data
UPDATE employees_with_departments
SET full_name = concat(first_name,' ', last_name);
-- 1.c.Remove the first_name and last_name columns from the table.
ALTER TABLE hopper_1563.employees_with_departments
DROP COLUMN first_name;

ALTER TABLE hopper_1563.employees_with_departments
DROP COLUMN last_name;

SELECT * FROM employees_with_departments;
-- 1.d.What is another way you could have ended up with this same table?
USE employees;
SELECT dept_name, concat(e.first_name,' ', e.last_name) as 'full_name'
FROM departments
JOIN dept_emp USING(dept_no)
JOIN employees e USING(emp_no);
-- 2.Create a temporary table based on the payment table from the sakila database.
-- Write the SQL necessary to transform the amount column such that it is stored as an integer 
-- representing the number of cents of the payment. For example, 1.99 should become 199.
USE sakila;
CREATE TEMPORARY TABLE hopper_1563.temp_payment_table AS
SELECT * FROM payment;
use hopper_1563;
SELECT * FROM temp_payment_table;

ALTER TABLE temp_payment_table ADD amt_in_cents INT(10);
UPDATE temp_payment_table SET amt_in_cents = (amount*100);

ALTER TABLE temp_payment_table MODIFY amount INT(10);
UPDATE temp_payment_table SET amount = amt_in_cents;
/*
[ALTER TABLE database MODIFY table TYPE] function to change the table itself*/

-- 3.Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison 
-- easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?
USE employees;
-- Create current avg salary table by departments
CREATE TABLE hopper_1563.curr_avg_sal AS
SELECT dept_name AS Department, avg(salary) AS 'Dept_Mean_Salary'
FROM salaries
JOIN dept_emp ON dept_emp.emp_no = salaries.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE salaries.to_date > now()
AND dept_emp.to_date > now()
GROUP BY dept_name;
-- create table for historical avg salary and historical std deviation
CREATE TABLE hopper_1563.hist_data AS
SELECT avg(salary) AS Avg_Hist_Sal, stddev(salary) AS Hist_Std_Dev
FROM salaries;

USE hopper_1563;
SELECT * FROM curr_avg_sal;
SELECT * FROM hist_data;
SELECT * FROM curr_hist;
-- create table to join data as current and historical
CREATE TEMPORARY TABLE hopper_1563.curr_hist AS
SELECT * FROM curr_avg_sal
JOIN hist_data;

-- CREATE YOUR ZSCORE TABLE
-- here's how i display the zscore with all other fields
SELECT *,
    (
    (Dept_Mean_Salary - Avg_Hist_Sal)
    / 
    (Hist_Std_Dev) 
    ) AS zscore
FROM curr_hist
ORDER BY zscore DESC;

SELECT * FROM curr_hist;

-- here, i add a field to the curr_hist temp table and name it zscore
ALTER TABLE hopper_1563.curr_hist ADD zscore FLOAT;
SELECT * FROM curr_hist;

-- here is where i define the content of the zscore field and display my final result
UPDATE curr_hist SET zscore = (
    (Dept_Mean_Salary - Avg_Hist_Sal)
    / 
    (Hist_Std_Dev) 
    );
SELECT * FROM curr_hist
ORDER BY zscore DESC;

