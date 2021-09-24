-- -------------------INDEXES------------------------
#primary key vs foreign keys
USE employees;
#UNIQUE is similar, as it constrains new input to unique values
#format is UNIQUE(COLUMN TO CONTRAIN), or UNIQUE(first_name, last_name) for example
-- Multi Column indexes: up to 16 columns.  Example below
CREATE TABLE authors (
    id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id), #first index, which is primary
    UNIQUE (first_name, last_name)
);
-- ------------------JOINS------------------------
JOIN #a.k.a INNER JOIN
LEFT JOIN
RIGHT JOIN
#types of relationships: "many to one" vs "one to many"; vs "many to many"
-- syntax:
SELECT columns
FROM table_a as A #<--referred to as the 'left table'
JOIN table_b/*<--the 'right' table*/ as B ON A.id = B.fk_id;
#so, ^^ the query is going to pull from table_a on the column id "A.id" and "B.fk_id"
#refer to the TABLES THEY CREATED in the curriculum. users table and roles table; user role
#defaults to null; not all users have a role and no one has the commenter role
#example query:
SELECT users.name as user_name, roles.name as role_name
FROM users
JOIN roles ON users.role_id = roles.id;
#this is a basic join based on the relationshipo between users.role_id and roles.id
#the 'middle part' of a venn diagram (an inner join would return the same)
SELECT users.name AS user_name, roles.name AS role_name
FROM users
LEFT JOIN roles ON users.role_id = roles.id; #this is an example of a LEFT JOIN
#this query would give you all the employees that have an assigned role, plus any with a null role
SELECT users.name AS user_name, roles.name AS role_name
FROM users
RIGHT JOIN roles ON users.role_id = roles.id; #RIGHT JOIN example
#returns all the user names and their role, plus 'NULL' for the commenter role name
SELECT users.name as user_name, roles.name as role_name
FROM roles
LEFT JOIN users ON users.role_id = roles.id;#RIGHT JOIN REWRITTEN AS A LEFT JOIN
-- ASSOCIIATIVE TABLES
#see examples below.  in EMPLOYEES, there is an associative table 'dept_emp' with foreign keys
#to the employees and departments tables. also has a 'from' and 'to' date to associate emps with 
#different depts over time-->think 'MANY TO MANY'
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name, d.dept_name#return full name and dept name
FROM employees AS e #working w employees table
JOIN dept_emp AS de #NOTE THE ALIASING which works 
  ON de.emp_no = e.emp_no #joining employees w dept_emp on the emp_no relationship
JOIN departments AS d
  ON d.dept_no = de.dept_no#join departments on the dept_no relationship
WHERE de.to_date = '9999-01-01' AND e.emp_no = 10001;#limiting to current emp 10001
#full name and department for the employee with an employee id of 10001


-- other examples, progressively more complex
SELECT *
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
join departments on departments.dept_no = dept_emp.dept_no;
#basic join returning employees (all) joing w dep_emp and departments on dept_no
#multiple joins required in order to get emp name along w dep no

USE employees;

SELECT *
FROM employees #querying from employees
JOIN dept_emp using(emp_no) #joining dept_emp based on emp_no
join departments using(dept_no) #joining departments based on dept_no
where to_date > curdate(); #limiting to current employees

SELECT first_name, count(*) #same query as above, but only querying first_name and count of first_name
FROM employees 
JOIN dept_emp using(emp_no) 
join departments using(dept_no) 
where to_date > curdate() 
group by first_name; #grouping obviously
