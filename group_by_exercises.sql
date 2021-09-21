-- GROUP BY EXERCISES-------------
-- 2. Use DISTINCT to find the unique titles in the titles table. How many have there ever been?
-- answer: 7
SELECT DISTINCT title FROM titles;
-- 3. Find a list of all unique last names starting/ending w "e" using GROUP BY
SELECT last_name FROM employees WHERE last_name LIKE 'e%e' 
GROUP BY last_name;
-- 4. Find unique combos of 1st and last names of all employees (last name starts/ends in 'e')
SELECT concat(first_name, ' ',last_name) AS first_last_name, count(*) FROM employees
WHERE last_name LIKE "e%e"
GROUP BY first_last_name;
-- 5. Unique last name w/a 'q' but not 'qu.' Include those names in a comment
-- answer: Chleq, Lindqvist, Qiwen
SELECT last_name FROM employees
WHERE last_name LIKE '%q%' AND NOT last_name LIKE '%qu%'
GROUP BY last_name;
-- 6. Add a count() to the result to find # employees w/same last name
SELECT last_name, count(*) FROM employees
WHERE last_name LIKE '%q%' AND NOT last_name LIKE '%qu%'
GROUP BY last_name;
-- 7. Find emps w 1st name Irena/Vidya/Maya. Use count(*) and group by to find # emp for each gender w those names.
SELECT *, COUNT(*) FROM employees
WHERE first_name IN ('Irena','Vidya','Maya');