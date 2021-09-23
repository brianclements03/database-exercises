-- Join Example Database
-- 1.Use the join_example_db. Select all the records from both the users and roles tables.
USE join_example_db;
SELECT * FROM join_example_db.users;
SELECT * FROM join_example_db.roles;
-- 2.Use join, left join, and right join to combine results from the users and roles tables 
-- as we did in the lesson. Before you run each query, guess the expected number of results.
SELECT * FROM users
JOIN roles ON users.role_id = roles.id;

SELECT * FROM users
LEFT JOIN roles ON users.role_id = roles.id;

SELECT * FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

-- 3.Although not explicitly covered in the lesson, aggregate functions like count can be used 
-- with join queries. Use count and the appropriate join type to get a list of roles along with 
-- the number of users that has the role. Hint: You will also need to use group by in the query.
SELECT roles.name, count(*) FROM roles
JOIN users ON roles.id = users.role_id
GROUP BY roles.name;

-- EMPLOYEE DATABASE
-- 1. use the employees db
USE employees;
-- 2. Using the example in the Associative Table Joins section as a guide, write a query that 
-- shows each department along with the name of the current manager for that department.
SELECT departments.dept_name AS 'Department Name', 
CONCAT(employees.first_name, ' ', employees.last_name) AS 'Department Manager' FROM employees
JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
JOIN departments on departments.dept_no = dept_manager.dept_no
WHERE dept_manager.to_date > NOW()
ORDER BY departments.dept_name; 
-- 3.  Find the name of all departments currently managed by women.
SELECT departments.dept_name AS 'Department Name', 
CONCAT(employees.first_name, ' ', employees.last_name) AS 'Department Manager' FROM employees
JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
JOIN departments on departments.dept_no = dept_manager.dept_no
WHERE dept_manager.to_date > NOW() AND employees.gender = 'F'
ORDER BY departments.dept_name; 
-- 4. Find the current titles of employees currently working in the Customer Service department
SELECT titles.title AS Title, count(titles.title) 
FROM titles
RIGHT JOIN employees ON employees.emp_no = titles.emp_no
JOIN dept_emp ON dept_emp.emp_no = titles.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name = 'Customer Service'
AND dept_emp.to_date > now() AND titles.to_date > now()
GROUP BY Title;
-- 5. Find the current salary of all current managers.
SELECT d.dept_name, CONCAT(e.first_name, ' ', e.last_name) AS 'Department Manager', s.salary
FROM departments AS d
JOIN dept_emp AS de ON d.dept_no = de.dept_no
JOIN employees as e ON e.emp_no = de.emp_no
JOIN dept_manager as dm ON dm.emp_no = e.emp_no
JOIN salaries AS s ON s.emp_no = dm.emp_no
WHERE dm.to_date > NOW()
AND s.to_date > NOW()
ORDER BY d.dept_name;

-- 6. Find the number of current employees in each department.
SELECT d.dept_no, d.dept_name, count(*) FROM departments AS d
JOIN dept_emp AS de using(dept_no)
JOIN employees AS e using(emp_no)
WHERE de.to_date > now()
GROUP BY d.dept_no, d.dept_name
ORDER BY d.dept_no;

-- 7. Which department has the highest average salary? Hint: Use current not historic information.
SELECT d.dept_name, avg(salary) AS average_salary FROM departments AS d
JOIN dept_emp AS de using(dept_no)
JOIN salaries AS s using(emp_no)
WHERE s.to_date > NOW() AND de.to_date > now() #sets dept to date along with the salaries to date (otherwise the result is off by $10)
GROUP BY d.dept_name
ORDER BY average_salary DESC LIMIT 1; #simple solution not requiring max()
/*
+-----------+----------------+
| dept_name | average_salary |
+-----------+----------------+
| Sales     | 88852.9695     |
+-----------+----------------+*/

-- 8. Who is the highest paid employee in the Marketing department?
/*
+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Akemi      | Warwick   |
+------------+-----------+*/
SELECT first_name, last_name FROM employees AS e
JOIN dept_emp AS de using(emp_no)
JOIN departments AS d using(dept_no)
JOIN salaries AS s using(emp_no)
WHERE d.dept_name = 'Marketing' AND de.to_date > now()
ORDER BY s.salary DESC LIMIT 1;

-- 9. Which current department manager has the highest salary?

SELECT e.first_name, e.last_name, salary, dept_name 
FROM departments AS d
JOIN dept_emp AS de ON d.dept_no = de.dept_no
JOIN employees as e ON e.emp_no = de.emp_no
JOIN dept_manager as dm ON dm.emp_no = e.emp_no
JOIN salaries AS s ON s.emp_no = dm.emp_no
JOIN titles AS t ON t.emp_no = s.emp_no
WHERE de.to_date > NOW() AND t.to_date > now() AND s.to_date > now() AND dm.to_date > now()
ORDER BY s.salary DESC LIMIT 1;
/*
+------------+-----------+--------+-----------+
| first_name | last_name | salary | dept_name |
+------------+-----------+--------+-----------+
| Vishwani   | Minakawa  | 106491 | Marketing |
+------------+-----------+--------+-----------+*/

-- 10. BONUS Find the names of all current employees, their department name, and their current manager's name.
SELECT concat(e.first_name,' ',e.last_name) AS 'Employee Name'#, d.dept_name AS 'Department Name', #xxx AS 'Manager Name' 
FROM employees AS e
JOIN dept_emp AS de using(emp_no)
JOIN departments AS d using(dept_no)
JOIN dept_manager AS dm using(dept_no)
JOIN employees AS e2 using(emp_no);
GROUP BY 'Employee Name' ORDER BY 'Employee Name';
#big hint: join employees twice, once for the employees and once for the managers
SELECT concat(e2.first_name,' ',e2.last_name) AS 'Employee Name', d.dept_name AS 'Department Name', concat(e.first_name,' ',e.last_name) AS 'Manager Name' 
FROM employees AS e
JOIN dept_manager AS dm using(emp_no)
JOIN departments AS d using(dept_no) #run code up to here and compare resulting tables for a sense of where the "using()" key turns up in the tables
JOIN dept_emp AS de using(dept_no)
JOIN employees AS e2 ON e2.emp_no = de.emp_no
WHERE de.to_date > now() AND dm.to_date > NOW() #here is where we filter
ORDER BY d.dept_name;


/*
240,124 Rows

Employee Name | Department Name  |  Manager Name
--------------|------------------|-----------------
 Huan Lortz   | Customer Service | Yuchang Weedman

 .....*/
 
 /*extra question
 1. Determine the average salary for each department. Use all salary information and round your results.

        +--------------------+----------------+
        | dept_name          | average_salary | 
        +--------------------+----------------+
        | Sales              | 80668          | 
        +--------------------+----------------+
        | Marketing          | 71913          |
        +--------------------+----------------+
        | Finance            | 70489          |
        +--------------------+----------------+
        | Research           | 59665          |
        +--------------------+----------------+
        | Production         | 59605          |
        +--------------------+----------------+
        | Development        | 59479          |
        +--------------------+----------------+
        | Customer Service   | 58770          |
        +--------------------+----------------+
        | Quality Management | 57251          |
        +--------------------+----------------+
        | Human Resources    | 55575          |
        +--------------------+----------------+*/