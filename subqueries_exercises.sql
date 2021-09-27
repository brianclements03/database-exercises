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
-- answer: 85108
SELECT COUNT(*)
FROM employees e
WHERE emp_no IN (
	SELECT emp_no
	FROM dept_emp
    WHERE to_date < now()
    );
-- 4.Find all the current department managers that are female. List their names in a comment in your code.
/*'Isamu','Legleitner'
'Karsten','Sigstam'
'Leon','DasSarma'
'Hilary','Kambil'*/
SELECT first_name, last_name
FROM dept_manager dm
JOIN employees e using(emp_no)
WHERE to_date > now() 
AND emp_no IN (
	SELECT emp_no
    FROM employees
    WHERE gender = 'F'	 
    );
-- 5.Find all the employees who currently have a higher salary than the companies overall, historical average salary.
SELECT *
FROM employees e 
JOIN salaries s using(emp_no)
WHERE s.to_date > now()
	AND s.salary > 
    (
	SELECT avg(salary)
    FROM salaries s2
    );
-- 6.How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function 
-- to calculate the standard deviation.) What percentage of all salaries is this?
SELECT count(*) as 'number salaries', count(*)/((SELECT count(*) FROM salaries WHERE to_date > now())) AS 'percent of total'
FROM salaries s
WHERE to_date > now()
AND salary >= 
	(
	SELECT max(salary) 
	FROM salaries
	WHERE to_date > now()
	) 
	- 
	(
	SELECT stddev(salary)
    FROM salaries s2
    WHERE to_date > now()
    );
-- -----------------------------------BONUS---------------------------------------------
-- 1.Find all the department names that currently have female managers.
SELECT dept_name
FROM departments d
WHERE dept_no IN 
	(
    SELECT dept_no
	FROM dept_emp de
	WHERE to_date > now()
    AND emp_no IN 
		(
        SELECT emp_no
		FROM employees e
        WHERE gender = 'F'
        )
	)
;
-- 2.Find the first and last name of the employee with the highest salary.
SELECT first_name, last_name, emp_no
FROM employees e
WHERE emp_no IN
	(SELECT emp_no
    FROM salaries
    WHERE salary IN 
		(
        SELECT max(salary)
        FROM salaries
        WHERE to_date > now()
        )
	);
    
-- 3.Find the department name that the employee with the highest salary works in.
SELECT dept_name
FROM departments
WHERE dept_no IN
	(SELECT dept_no
	FROM departments
    WHERE dept_no IN
		(SELECT dept_no
		FROM dept_emp
        WHERE emp_no IN
			(
            SELECT emp_no
			FROM salaries
			WHERE salary IN 
				(
				SELECT max(salary)
				FROM salaries
				WHERE to_date > now()
				)
			)
		)
	);
    
-- the following lines are just to confirm--------
SELECT *
FROM dept_emp
WHERE emp_no = 43624;
SELECT dept_name
FROM departments
WHERE dept_no = 'd007';