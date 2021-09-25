USE employees;
-- 1.Find all the current employees with the same hire date as employee 101010 using a sub-query.
SELECT * 
FROM employees
JOIN dept_emp de using(emp_no)
WHERE hire_date = (
    SELECT hire_date
    FROM employees
    WHERE emp_no = 101010)
    AND to_date > now();
-- 2.Find all the titles ever held by all current employees with the first name Aamod.
SELECT first_name, title FROM titles t
JOIN employees e using(emp_no)
WHERE to_date > now() 
AND first_name = (
	SELECT (first_name)
	FROM employees
	WHERE first_name = 'Aamod'
	GROUP BY first_name);
-- 3.How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
SELECT * #COUNT(*)
FROM employees e
WHERE emp_no IN (
	SELECT emp_no
	FROM dept_emp
    WHERE to_date < now()
    );
-- 4.Find all the current department managers that are female. List their names in a comment in your code.
