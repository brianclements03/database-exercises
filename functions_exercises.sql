SHOW databases; USE employees;
-- ------------------------2-------------------------------
SELECT * FROM employees WHERE first_name IN ('Irena', 'Maya', 'Vidya') ORDER BY first_name ASC;
-- 1st/last names in results vs table? Irena Reutenauer and Vidya Simmen (did i understand the question?)
-- ------------------------3-------------------------------
SELECT * FROM employees WHERE first_name IN ('Irena', 'Maya', 'Vidya') ORDER BY first_name ASC, last_name ASC;
-- 1st/last name of first row of res.? Table? Irena ACton and Vidya Simmen
-- ------------------------4-------------------------------
SELECT * FROM employees WHERE first_name IN ('Irena', 'Maya', 'Vidya') ORDER BY last_name ASC, first_name ASC;
-- same question: Irena Acton and Maya Zyda
-- ------------------------5-------------------------------
SELECT * FROM employees WHERE last_name LIKE 'e%' ORDER BY emp_no;
-- # employees returned, and 1st and last: 7330; 10021 Ramzi Erde and 499968 Dharmaraja Ertl
-- ------------------------6-------------------------------
SELECT * FROM employees WHERE last_name LIKE 'e%' AND last_name LIKE '%e' ORDER BY hire_date ASC;
-- # empl ret and name: 899; oldest: Sergi Erde; newest: Teiji Edridge
-- ------------------------7-------------------------------
SELECT * FROM employees WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31' AND birth_date LIKE '%-12-25' ORDER BY birth_date ASC, hire_date DESC;
-- # emp ret and oldes/hired last and youngest/hired first: 362 rows; Khun Bernini; Douadi Pettis
-- --------BEGIN FUNCTIONS EXERCISES-----------------------
-- -------2. Query emp whose last name START AND ENDS w 'E'. Use concat to combine and alias as 'full_name'
USE employees; 
SELECT last_name FROM employees WHERE last_name LIKE 'e%e';
SELECT concat(first_name, '', last_name) AS full_name FROM employees 
WHERE last_name LIKE 'e%e';
-- 3. ----Convert the names to uppercase
SELECT upper(concat(first_name, '', last_name)) AS full_name FROM employees 
WHERE last_name LIKE 'e%e';
-- 4. ----Find all emp hired in 90s AND born on xmas. Use datediff() to find how many days they've been at the company
SELECT datediff(curdate(), hire_date) FROM employees WHERE hire_date LIKE '199%' 
AND birth_date LIKE '%-12-25';
-- 5. ----Find min and max salary from salaries table
SELECT min(salary), max(salary) FROM salaries;
-- 6. ----Generate a username for all emp. All lowercase, 1st char of 
-- first_name, 1st 4 char last_name, "_", birth month, last 2 digs of birth year
SELECT lower(concat(substr(first_name,1,1), substr(last_name,1,4), '_', 
substr(birth_date,6,2), substr(birth_date,3,2))) AS user_name, first_name, last_name, birth_date FROM employees;

