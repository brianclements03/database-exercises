-- 1. use the employees db
USE employees;
-- 2. Using the example in the Associative Table Joins section as a guide, write a query that 
-- shows each department along with the name of the current manager for that department.
SELECT dept_name, concat(first_name, ' ', last_name)
FROM departments
JOIN dept_manager using(dept_no)
JOIN employees using(emp_no)
WHERE to_date > now();
-- 3.  Find the name of all departments currently managed by women.
SELECT dept_name, concat(first_name, ' ', last_name)
FROM departments
JOIN dept_manager using(dept_no)
JOIN employees using(emp_no)
WHERE to_date > now() AND gender = 'F';
-- 4. Find the current titles of employees currently working in the Customer Service department
SELECT title, count(title)
FROM titles AS t
JOIN dept_emp AS de using(emp_no)
JOIN departments AS d using(dept_no)
WHERE t.to_date > now() AND dept_name = 'Customer Service' AND de.to_date > now()
GROUP BY title;
-- 5. Find the current salary of all current managers.
SELECT  dept_name AS 'Department Name', concat(first_name, ' ',last_name) AS 'Name', salary AS 'Salary'
FROM salaries s
JOIN dept_manager dm using(emp_no)
JOIN employees e using(emp_no)
JOIN departments d using(dept_no)
WHERE s.to_date > now() AND dm.to_date > now();
-- 6. Find the number of current employees in each department.
SELECT dept_no, dept_name, count(*)
FROM employees e
JOIN dept_emp de using(emp_no)
JOIN departments d using(dept_no)
WHERE de.to_date > now()
GROUP BY dept_no
ORDER BY dept_no;
-- 7. Which department has the highest average salary? Hint: Use current not historic information.
SELECT dept_name, avg(salary)
FROM salaries s
JOIN dept_emp de using(emp_no)
JOIN departments d using(dept_no)
WHERE s.to_date > now() AND de.to_date > now()
GROUP BY dept_name
ORDER BY dept_name DESC LIMIT 1;
-- 8. Who is the highest paid employee in the Marketing department?
SELECT first_name, last_name
FROM employees e
JOIN dept_emp de using(emp_no)
JOIN departments d using(dept_no)
JOIN salaries s using(emp_no)
WHERE de.to_date > now() AND dept_name = 'Marketing'
ORDER BY salary DESC LIMIT 1;
-- 9. Which current department manager has the highest salary?
SELECT first_name, last_name, salary, d.dept_name
FROM dept_manager dm
JOIN departments d using(dept_no)
JOIN employees e using(emp_no)
JOIN salaries s using(emp_no)
WHERE dm.to_date > now()
ORDER BY salary DESC LIMIT 1;