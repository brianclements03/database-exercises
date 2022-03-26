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
GROUP BY region
ORDER BY sum(population);
-- What is the population for each continent?
SELECT continent, sum(population)
FROM country
GROUP BY continent
ORDER BY sum(population);
-- What is the average life expectancy globally?
SELECT avg(LifeExpectancy)
FROM country;
-- What is the average life expectancy for each region, each continent? Sort the results from shortest to longest
SELECT region, avg(LifeExpectancy)
FROM country
GROUP BY region
ORDER BY avg(LifeExpectancy);
SELECT continent, avg(LifeExpectancy)
FROM country
GROUP BY continent
ORDER BY avg(LifeExpectancy);
-- Bonus
-- Find all the countries whose local name is different from the official name
SELECT name, LocalName
FROM country
WHERE LocalName != name;
-- How many countries have a life expectancy less than x?
SELECT count(*)
FROM country
WHERE LifeExpectancy < x;
-- What state is city x located in?
SELECT district
FROM city
WHERE city.Name = 'x';
-- What region of the world is city x located in?
SELECT region
FROM country
JOIN city ON city.CountryCode = country.Code
WHERE city.name = 'x';
-- What country (use the human readable name) is city x located in?
SELECT country.name
FROM country
JOIN city ON city.CountryCode = country.Code
WHERE city.name = 'x';
-- What is the life expectancy in city x?
SELECT country.LifeExpectancy
FROM country
JOIN city ON city.CountryCode = country.Code
WHERE city.name = 'x';
-- SAKILA DATABASE --------------------
USE sakila;
-- 1. Display the first and last names in all lowercase of all the actors.
SELECT LOWER(first_name), lower(last_name)
FROM actor;
-- 2. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." 
-- What is one query would you could use to obtain this information?
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'joe';
-- 3. Find all actors whose last name contain the letters "gen":
SELECT *
FROM actor
WHERE last_name LIKE '%gen%';
-- 4. Find all actors whose last names contain the letters "li". This time, order the rows by last name and first name, in that order.
SELECT *
FROM actor
WHERE last_name LIKE '%li%'
ORDER BY last_name, first_name;
-- 5. Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China:
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');
-- 6. List the last names of all the actors, as well as how many actors have that last name
SELECT last_name, count(*)
FROM actor
GROUP BY last_name;
-- 7. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
SELECT last_name, count(*)
FROM actor
GROUP BY last_name HAVING count(*) > 1;
-- 8. You cannot locate the schema of the address table. Which query would you use to re-create it?
-- CREATE TABLE address etc etc -- was this specific enough?
-- 9. Use JOIN to display the first and last names, as well as the address, of each staff member
SELECT first_name, last_name, address
FROM staff
JOIN address using(address_id);
-- 10.Use JOIN to display the total amount rung up by each staff member in August of 2005
SELECT staff_id, sum(amount)
FROM payment
JOIN staff using(staff_id)
GROUP BY staff_id;
-- 11.List each film and the number of actors who are listed for that film
SELECT title, count(*)
FROM film
JOIN film_actor using(film_id)
GROUP BY title;
-- 12.How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT count(*)
FROM film
JOIN inventory USING(film_id)
WHERE title = 'Hunchback Impossible';
-- 13.The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, 
-- films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting 
-- with the letters K and Q whose language is English.
SELECT title
FROM film
JOIN language USING(language_id)
WHERE language_id = 
	(
    SELECT language_id FROM language WHERE name = 'english'
    )
AND title = 
	(
    SELECT title WHERE title LIKE 'K%' OR title LIKE 'Q%'
    );
-- 14.Use subqueries to display all actors who appear in the film Alone Trip
SELECT actor.first_name, actor.last_name
FROM actor
WHERE actor_id IN 
	(
    SELECT actor_id
    FROM film_actor
    WHERE film_id =
		(
		SELECT film_id
		FROM film
		WHERE title = 'alone trip'
		)
	);
-- 15.You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers
SELECT first_name, last_name, email
FROM customer
JOIN address using(address_id)
JOIN city USING(city_id)
JOIN country USING(country_id)
WHERE country_id = (SELECT country_id FROM country WHERE country = 'canada');

/*
WHERE address_id =
(
SELECT address_id
FROM address
WHERE city_id =
	(
	SELECT city_id
	FROM city
	WHERE country_id =
		(
		SELECT country_id
		FROM country
		WHERE country = 'canada'
		)
	)
)
;
WONDER WHY IT DIDN'T WORK WITH SUBQUERIES*/
-- 16.Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
-- Identify all movies categorized as famiy films.
SELECT title 
FROM film
JOIN film_category USING(film_id)
WHERE film_id IN 
	(
	SELECT film_id
	FROM film 
    WHERE category_id =
		(
        SELECT category_id
        FROM category
        WHERE category.name = 'family'
        )
	);
-- NOT THE CORRECT ANSWER....still
 
 
 
 
 
-- The following is an example of a lag function. notice the OVER() piece
SELECT *,
LAG(hire_date, 1,'1999-09-01') OVER(
ORDER BY hire_date ASC) AS EndDate
FROM employees;