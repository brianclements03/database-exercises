SHOW databases;
USE employees;
DESCRIBE employees;
-- -------------------------------------------2------------------------------------------------
SELECT first_name FROM employees WHERE first_name IN ('Irena','Vidya','Maya');
-- 709 rows returned
-- -------------------------------------------3------------------------------------------------
SELECT first_name FROM employees WHERE first_name = 'Irena' OR first_name =  'Vidya' OR first_name = 'Maya';
SELECT first_name FROM employees WHERE (first_name = 'Irena' OR 'Vidya' OR 'Maya');
-- 709 rows returned...I initially failed to add "first_name =" in front of every "OR", which returned a different result: BOOLEAN RESULT RETURNED...USEFUL FOR MORE ADVANCED QUERIES??
-- -------------------------------------------4------------------------------------------------
SELECT first_name FROM employees WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya' AND gender = 'M';
-- 619 rows returned
-- -------------------------------------------5------------------------------------------------
SELECT last_name FROM employees WHERE last_name LIKE 'E%';
-- 7330 rows returned
-- -------------------------------------------6------------------------------------------------
SELECT last_name FROM employees WHERE (last_name LIKE 'E%' OR last_name LIKE '%E');
-- 30723 rows returned
SELECT last_name FROM employees WHERE last_name LIKE '%E' AND NOT last_name LIKE 'E%';
-- 23393 rows returned
-- -------------------------------------------7------------------------------------------------
SELECT last_name FROM employees WHERE (last_name LIKE '%E' AND last_name LIKE 'E%');
-- 899 rows returned
SELECT last_name FROM employees WHERE last_name LIKE '%E';
SELECT COUNT(*) FROM employees WHERE last_name LIKE '%e';
-- 242929 rows  returned
-- -------------------------------------------8------------------------------------------------
SELECT last_name FROM employees WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';
-- 135214 rows returned
-- -------------------------------------------9------------------------------------------------
SELECT last_name FROM employees WHERE birth_date LIKE '%-12-25';
-- YOU CAN EXTRACT INFO FROM DATE INFO TYPE: SELECT month(birth_date) etc
-- 842 rows returned
-- -------------------------------------------10------------------------------------------------
SELECT last_name FROM employees WHERE birth_date LIKE '%-12-25' AND hire_date BETWEEN '1990-01-01' AND '1999-12-31';
-- 362 rows returned
-- -------------------------------------------11------------------------------------------------
SELECT * FROM employees WHERE last_name LIKE '%q%';
-- 1873 rows returned.  note: " OR last_name LIKE '%Q%'" not required.
-- -------------------------------------------12------------------------------------------------
SELECT last_name FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';
-- 547 rows returned