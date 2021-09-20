-- -------------------ORDER BY NOTES------------------------
SHOW databases;
USE employees;
DESCRIBE employees;
SELECT first_name, last_name, emp_no FROM employees ORDER BY last_name;
SELECT first_name, last_name FROM employees GROUP BY last_name;
-- curr says group by is a thing, not getting it to work this minute...
SELECT first_name, last_name, emp_no FROM employees ORDER BY last_name ASC;
-- DESC vs ASC
-- -----------CHAINING ORDER BY CLAUSES---------------------
SELECT first_name, last_name FROM employees ORDER BY last_name DESC, first_name ASC;

-- some notes from Ravinder:
/*-- parentheses > NOT > AND > OR

SELECT NULL = NULL -----> NULL
SELECT NULL = 2 --------> NULL
	--When selecting for NULL, sometimes you have to use "IS" instead of "=" for the query to find the results
		-- (or IS NOT) */
		
SELECT * FROM employees WHERE first_name LIKE 'eb' AND NOT first_name LIKE '%e';
SELECT * FROM logs WHERE cohort_id IS NOT NULL AND user_id = 40;


-- -------------------LIMIT NOTES-----------------------------
-- The limit clauses limits results to a range or a number
SELECT emp_no, first_name, last_name FROM employees WHERE first_name LIKE 'M%' LIMIT 10;
-- OFFSET tells it where to start from
SELECT emp_no, first_name, last_name FROM employees WHERE first_name LIKE 'M%' LIMIT 25 OFFSET 50;
-- commonly used for "pagination"