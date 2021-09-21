USE employees;

SELECT lower(concat(first_name, last_name,"@codeup.com")) 
AS email FROM employees LIMIT 10;

SELECT substr(first_name, 1, 1) FROM employees;
SELECT concat(substr(first_name, 1, 1),last_name, emp_no) FROM employees;

SELECT replace(dept_name, 'Resources', 'Solutions') FROM departments;

SELECT now();
SELECT curdate(); SELECT curtime();
SELECT datediff(curdate(), birth_date)/365 FROM employees;
SELECT dayname('1970-01-01'); SELECT dayname('2022-01-01');
SELECT unix_timestamp(); SELECT unix_timestamp('1971-01-01');
SELECT *, dayname(birth_date) AS 'day_born'
FROM employees;

SELECT avg(salary) FROM salaries; SELECT max(salary) FROM salaries;
SELECT max(salary) - min(salary) AS range_from_min_to_max FROM salaries;

SELECT * FROM employees.salaries;

-- CASTING---------------------
SELECT
    1 + '4ef',
    '3' - 1,
    CONCAT('Here is a number: ', 123);
SELECT cast(123 as CHAR);
-- now it is being treated as a string, not a number
-- https://www.w3schools.com/mysql/func_mysql_cast.asp for examples