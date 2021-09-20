SHOW databases; USE employees;
-- ------------------------2-------------------------------
SELECT * FROM employees WHERE first_name IN ('Irena', 'Maya', 'Vidya') ORDER BY first_name ASC;
-- ------------------------3-------------------------------
SELECT * FROM employees WHERE first_name IN ('Irena', 'Maya', 'Vidya') ORDER BY first_name ASC, last_name ASC;
-- ------------------------4-------------------------------
SELECT * FROM employees WHERE first_name IN ('Irena', 'Maya', 'Vidya') ORDER BY last_name ASC, first_name ASC;
-- ------------------------5-------------------------------
SELECT * FROM employees WHERE last_name LIKE 'e%' ORDER BY emp_no;
-- ------------------------6-------------------------------
SELECT * FROM employees WHERE last_name LIKE 'e%' AND last_name LIKE '%e' ORDER BY hire_date ASC;
-- ------------------------7-------------------------------
SELECT * FROM employees WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31' AND birth_date LIKE '%-12-25' ORDER BY birth_date ASC, hire_date DESC;


