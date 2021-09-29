USE employees;
-- Employees Database
-- How much do the current managers of each department get paid, relative to the average salary for the department? 
-- Is there any department where the department manager gets paid less than the average salary?
-- first off: CURRENT SALARY OF CURRENT DEPT MANAGERS
SELECT dept_name, salary AS 'curr_mgr_sal'
FROM departments d 
JOIN dept_emp de using(dept_no)
JOIN salaries s using(emp_no)
JOIN dept_manager dm using(emp_no)
WHERE s.to_date > now() AND dm.to_date > now() #the dm.to_date clause here filters this to current dept mgrs only
ORDER BY dept_name;
-- next up: CURRENT AVG SALARY by department
SELECT dept_name, avg(salary) AS 'curr_dept_avg_sal'
    FROM salaries
    JOIN dept_emp using(emp_no)
    JOIN departments using(dept_no)
    WHERE salaries.to_date > now()
    GROUP BY dept_name #this group by filters us down to avg salary by dept (as opposed to general avg)
    ORDER BY dept_name;
-- Next, build a TEMP TABLE for the current mgr salary bit
USE employees;
CREATE TEMPORARY TABLE hopper_1563.CURRENT_SALARIES AS
SELECT dept_name, salary AS 'CURRENT MGR SALARY'
FROM departments d 
JOIN dept_emp de using(dept_no)
JOIN salaries s using(emp_no)
JOIN dept_manager dm using(emp_no)
WHERE s.to_date > now() AND dm.to_date > now() #the dm.to_date clause here filters this to current dept mgrs only
ORDER BY dept_name;

SELECT * FROM hopper_1563.CURRENT_SALARIES;
-- SECOND TEMP TABLE with info for current dept avg
USE employees;
CREATE TEMPORARY TABLE hopper_1563.CURRENT_AVG AS
SELECT dept_name, avg(salary) AS 'curr_dept_avg_sal'
    FROM salaries
    JOIN dept_emp using(emp_no)
    JOIN departments using(dept_no)
    WHERE salaries.to_date > now()
    GROUP BY dept_name;
    
SELECT * FROM hopper_1563.CURRENT_AVG;

-- ADD field to CURRENT MGR SALARY
USE hopper_1563; 
ALTER TABLE hopper_1563.CURRENT_SALARIES ADD dept_avg FLOAT(10,2);
-- Populate field with the dept avg info
UPDATE hopper_1563.CURRENT_SALARIES SET dept_avg = 
(SELECT curr_dept_avg_sal FROM CURRENT_AVG WHERE CURRENT_SALARIES.dept_name = CURRENT_SALARIES.dept_name);


SELECT curr_dept_avg_sal FROM CURRENT_AVG WHERE CURRENT_SALARIES.dept_name = CURRENT_SALARIES.dept_name;

SELECT * FROM CURRENT_AVG;
# OK GIVING UP FOR NOW
/*World Database

Use the world database for the questions below.*/
-- What languages are spoken in Santa Monica?
USE world;
SELECT Language, percentage 
FROM countrylanguage
JOIN city using(CountryCode)
WHERE city.name = 'Santa Monica'
ORDER BY percentage;

-- How many different countries are in each region?
SELECT region, count(name) AS num_countries
FROM country
GROUP BY region
ORDER BY num_countries;
-- What is the population for each region?
SELECT region, sum(population)
FROM country
GROUP BY region;
ORDER BY sum(population);
-- What is the population for each continent?



