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
		WHEN last_name IN ('A%','B%','C%','D%','E%','F%','G%','H%') THEN 'A-H' 
		WHEN last_name IN ('I%','J%','K%','L%','M%','N%','O%','P%','Q%') THEN 'I-Q'
		ELSE 'R-Z' 
		END AS alpha_group
FROM employees;

--  last_name IN ('R%','S%','T%','U%','V%','W%','X%','Y%','Z%' THEN SELECT first_name, last_name,
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
							OR last_name LIKE'N%'
								OR last_name LIKE 'O%'
									OR last_name LIKE 'P%'
										OR last_name LIKE 'Q%' THEN 'I-Q'
		ELSE 'R-Z' 
		END AS alpha_group
FROM employees;


