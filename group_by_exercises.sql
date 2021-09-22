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
SELECT first_name, count(*), gender FROM employees
GROUP BY first_name, gender
HAVING first_name IN ('Irena','Vidya','Maya');
-- 8. Using the query ^ that generated a username, generate a count employees for each username. Are there duplicates? (bonus: have many duplicate usernames?)
SELECT lower(concat(substr(first_name,1,1), substr(last_name,1,4), '_', 
substr(birth_date,6,2), substr(birth_date,3,2))) AS user_name, COUNT(*) FROM employees
GROUP BY user_name
HAVING count(*) > 1;
-- 9. More practice...
-- Find historic avg salary for all emp; then, current avg salary
SELECT avg(salary) FROM salaries WHERE to_date > curdate(); #the 'to_date' field includes year 9999 for current salaries
-- Find hist avg salary for each emp. (tip: you'll probably group by this same column)
SELECT emp_no, avg(salary) FROM salaries
GROUP BY emp_no;
-- Find current avg salary for each emp
SELECT emp_no, avg(salary) FROM salaries WHERE to_date LIKE '9999%'
GROUP BY emp_no, salary; #review this further (including/excluding emp_no in select and in group by)
-- Max salary for each current emp
SELECT emp_no, max(salary) FROM salaries WHERE to_date LIKE '9999%'
GROUP BY emp_no, salary; #not 100% sure this is right.  is this the max across all salaries for current emp?
-- Max salary for each current employee wher max sal >%150000
SELECT emp_no, max(salary) FROM salaries WHERE to_date LIKE '9999%'
GROUP BY emp_no, salary
HAVING salary > 150000;
-- Current avg salary for each emp where that avg salary is between $80 and $90k
SELECT emp_no, avg(salary) FROM salaries WHERE to_date LIKE '9999%'
GROUP BY emp_no, salary
HAVING avg(salary) BETWEEN 80000 AND 90000;