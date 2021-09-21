SELECT DISTINCT first_name FROM employees;

-- 253 different georgis
SELECT * FROM employees WHERE first_name = 'georgi';
-- group the columns (names here)
SELECT first_name, count(first_name)
FROM employees 
GROUP BY first_name;
-- we can aggregate functions on those groups (count * in this case)
SELECT title, count(*) FROM titles GROUP BY title;
-- What's the average salary of each department?
SELECT dept_no, avg(salary), min(salary), max(salary)
FROM salaries
JOIN dept_emp using(emp_no)
GROUP BY dept_no;
-- it's like working the math functions on the whole group insted of whole table...
-- What's the historic average salary of each department?
SELECT dept_no, avg(salary), min(salary), max(salary)
FROM salaries
JOIN dept_emp using(emp_no)
WHERE salaries.to_date > curdate()
GROUP BY dept_no;

-- show number of duplicate first names
-- only show duplicate numbers less than 200
-- "having" is just a where clause for groups
SELECT first_name, count(first_name) as count_first_names
FROM employees  #where gender = 'F' e.g.
GROUP BY first_name
having count_first_names < 200; #between 247 and 275 e.g.

-- 
SELECT emp_no, max(salary), avg(salary)
FROM salaries
GROUP BY emp_no;