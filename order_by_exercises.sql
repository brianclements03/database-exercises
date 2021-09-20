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