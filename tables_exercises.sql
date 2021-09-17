show databases;
-- Use the employees database
use employees;
-- List all the tables in the database
show tables;
-- Explore the employees table. What different data types are present on this table?
describe employees;
-- Which table(s) do you think contain a numeric type column?
-- Which table(s) do you think contain a string type column?
-- Which table(s) do you think contain a date type column?

-- What is the relationship between the employees and the departments tables? SEE dept_emp TABLE! CROSS REFERENCE
describe departments;
describe employees;
-- Show the SQL that created the dept_manager table.
SHOW CREATE TABLE `dept_manager`;