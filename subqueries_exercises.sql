USE employees;
-- from examples in lesson:
-- all salaries more than twice the current avg
-- this is a 'scalar' subquery
SELECT emp_no, salary
FROM salaries
WHERE salary > 2 * (SELECT AVG(salary) FROM salaries WHERE to_date > CURDATE())
AND to_date > CURDATE();
-- all mgr names and bdays. NO JOIN RQRD
-- This is a 'column' subquery
SELECT first_name, last_name, birth_date
FROM employees
WHERE emp_no IN (
    SELECT emp_no
    FROM dept_manager
)
LIMIT 10;
-- and a ROW subquery:
SELECT first_name, last_name, birth_date
FROM employees
WHERE emp_no = (
    SELECT emp_no
    FROM employees
    WHERE emp_no = 101010
);
-- Finally, a TABLE subquery
-- Must be aliased
SELECT g.first_name, g.last_name, salaries.salary
FROM
    (
        SELECT *
        FROM employees
        WHERE first_name like 'Geor%'
    ) as g
JOIN salaries ON g.emp_no = salaries.emp_no
WHERE to_date > CURDATE();

-- 1.Find all the current employees with the same hire date as employee 101010 using a sub-query.
SELECT * 
FROM employees e 
JOIN dept_emp de USING(emp_no)
WHERE e.hire_date =
	(
    SELECT hire_date
    FROM employees
    WHERE emp_no = 101010
	)
AND to_date > NOW();
-- that shouldn't have tricked you, let's try harder on the next one
SELECT * 
FROM employees
JOIN dept_emp de using(emp_no)
WHERE hire_date = 
	(
    SELECT hire_date
    FROM employees
    WHERE emp_no = 101010
	)
    AND to_date > now();
-- 2.Find all the titles ever held by all current employees with the first name Aamod.
SELECT DISTINCT t.title
FROM titles t
JOIN employees e USING(emp_no)
WHERE to_date > NOW()
AND e.first_name = (
	SELECT e.first_name
    FROM employees e
    WHERE e.first_name = 'Aamod'
    GROUP BY e.first_name
    )
;
-- this was easier with a join lol

SELECT DISTINCT title FROM titles t
JOIN employees e using(emp_no)
WHERE to_date > now() 
AND first_name = (
	SELECT first_name
	FROM employees
	WHERE first_name = 'Aamod'
	GROUP BY first_name);
-- 3.How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
-- answer: 85108
SELECT *
FROM employees
WHERE emp_no NOT IN
	(
	SELECT emp_no
    FROM dept_emp
    WHERE to_date > now()
    );
-- THIS ^^ is the correct answer
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
SELECT count(*) as 'number salaries', count(*)/(SELECT count(*) FROM salaries WHERE to_date > now()) AS 'percent of total'
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





-- Here, I'm building up my columns and values before I group by departments and use an aggregate function to get a count of values in each column.
SELECT
    dept_name,
    CASE WHEN title = 'Senior Engineer' THEN title ELSE NULL END AS 'Senior Engineer',
    CASE WHEN title = 'Staff' THEN title ELSE NULL END AS 'Staff',
    CASE WHEN title = 'Engineer' THEN title ELSE NULL END AS 'Engineer',
    CASE WHEN title = 'Senior Staff' THEN title ELSE NULL END AS 'Senior Staff',
    CASE WHEN title = 'Assistant Engineer' THEN title ELSE NULL END AS 'Assistant Engineer',
    CASE WHEN title = 'Technique Leader' THEN title ELSE NULL END AS 'Technique Leader',
    CASE WHEN title = 'Manager' THEN title ELSE NULL END AS 'Manager'
FROM departments
JOIN dept_emp USING(dept_no)
JOIN titles USING(emp_no);

-- Next, I add my GROUP BY clause and COUNT function to get a count of all employees who have historically ever held a title by department. (I'm not filtering for current employees or current titles.)
SELECT
    dept_name,
    COUNT(CASE WHEN title = 'Senior Engineer' THEN title ELSE NULL END) AS 'Senior Engineer',
    COUNT(CASE WHEN title = 'Staff' THEN title ELSE NULL END) AS 'Staff',
    COUNT(CASE WHEN title = 'Engineer' THEN title ELSE NULL END) AS 'Engineer',
    COUNT(CASE WHEN title = 'Senior Staff' THEN title ELSE NULL END) AS 'Senior Staff',
    COUNT(CASE WHEN title = 'Assistant Engineer' THEN title ELSE NULL END) AS 'Assistant Engineer',
    COUNT(CASE WHEN title = 'Technique Leader' THEN title ELSE NULL END) AS 'Technique Leader',
    COUNT(CASE WHEN title = 'Manager' THEN title ELSE NULL END) AS 'Manager'
FROM departments
JOIN dept_emp USING(dept_no)
JOIN titles USING(emp_no)
GROUP BY dept_name
ORDER BY dept_name;

-- the following is a pivot table example from the case lesson
-- In this query, I filter in my JOINs for current employees who currently hold each title.
SELECT
    dept_name,
    COUNT(CASE WHEN title = 'Senior Engineer' THEN title ELSE NULL END) AS 'Senior Engineer',
    COUNT(CASE WHEN title = 'Staff' THEN title ELSE NULL END) AS 'Staff',
    COUNT(CASE WHEN title = 'Engineer' THEN title ELSE NULL END) AS 'Engineer',
    COUNT(CASE WHEN title = 'Senior Staff' THEN title ELSE NULL END) AS 'Senior Staff',
    COUNT(CASE WHEN title = 'Assistant Engineer' THEN title ELSE NULL END) AS 'Assistant Engineer',
    COUNT(CASE WHEN title = 'Technique Leader' THEN title ELSE NULL END) AS 'Technique Leader',
    COUNT(CASE WHEN title = 'Manager' THEN title ELSE NULL END) AS 'Manager'
FROM departments
JOIN dept_emp
    ON departments.dept_no = dept_emp.dept_no AND dept_emp.to_date > CURDATE()
JOIN titles
    ON dept_emp.emp_no = titles.emp_no AND titles.to_date > CURDATE()
GROUP BY dept_name
ORDER BY dept_name;