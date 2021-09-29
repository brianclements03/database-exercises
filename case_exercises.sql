use employees;
-- 1.Write a query that returns 
-- all employees (emp_no), 
-- their department number, 
-- their start date & their end date, 
-- and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
SELECT emp_no, dept_no, de.from_date, de.to_date,
/*CASE to_date
	WHEN to_date > now() THEN true
    ELSE false
    END AS 'is_current_employee'*/
IF(de.to_date > now(), TRUE, FALSE) AS is_current_employee
FROM employees e
JOIN dept_emp de USING(emp_no)
ORDER BY is_current_employee desc;

-- 2.Write a query that returns 
-- all employee names (previous and current), 
-- a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' 
-- --------->depending on the first letter of their last name.
SELECT first_name, last_name,
    CASE 
		WHEN last_name LIKE 'A%'
			OR last_name LIKE 'B%'
			OR last_name LIKE 'C%'
			OR last_name LIKE 'D%'
			OR last_name LIKE 'E%'
			OR last_name LIKE 'F%'
			OR last_name LIKE 'G%'
			OR last_name LIKE 'H%' THEN 'A-H' 
		WHEN last_name LIKE 'I%'
			OR last_name LIKE 'J%'
			OR last_name LIKE 'K%'
			OR last_name LIKE 'L%'
			OR last_name LIKE 'M%'
			OR last_name LIKE 'N%'
			OR last_name LIKE 'O%'
			OR last_name LIKE 'P%'
			OR last_name LIKE 'Q%' THEN 'I-Q'
		ELSE 'R-Z' 
		END AS alpha_group
FROM employees;
-- OOOORRRRRR----
select first_name, last_name,
    case
    when last_name < 'I' then 'A-H'
    when last_name < 'R' then 'I-Q'
    else 'R-Z'
    end as alpha_group
from employees;
-- 3.How many employees (current or previous) were born in each decade?
SELECT COUNT(*),
CASE 
	WHEN birth_date BETWEEN '1950-01-01' AND '1959-12-31' THEN 'fifties'
    WHEN birth_date BETWEEN '1960-01-01' AND '1969-12-31' THEN 'sixties'
    ELSE NULL
    END AS Birth_Decade
FROM employees
GROUP BY Birth_Decade;

-- BONUS. What is the current average salary for each of the following department groups: 
-- R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
USE employees; SELECT dept_name FROM departments;

SELECT 
       CASE 
           WHEN dept_name IN ('research', 'development') THEN 'R&D'
           WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing' 
           WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
           WHEN dept_name IN ('Finance','Human Resources') THEN 'Finance & HR'
           ELSE 'Customer Service'
		END AS dept_group,
			AVG(salary) AS average_salary
FROM salaries
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
WHERE salaries.to_date > curdate()
GROUP BY dept_group
ORDER BY dept_group;



-- dept_group avg sal is just avg(salary_dept1) + avg(salary_dept2)
/*+-------------------+-----------------+
| dept_group        | avg_salary      |
+-------------------+-----------------+
| Customer Service  |                 |
| Finance & HR      |                 |
| Sales & Marketing |                 |
| Prod & QM         |                 |
| R&D               |                 |
+-------------------+-----------------+*/
