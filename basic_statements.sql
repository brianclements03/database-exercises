USE fruits_db;

SELECT name, 
	   quantity 
/* Multi line
comment
can go forever*/
FROM fruits;

SELECT *,
	   name
FROM fruits;

SELECT DISTINCT name,
FROM fruits;

SELECT name,
	   quantity
FROM fruits
WHERE name = 'apple'
 AND quantity = 3;
-- vs 'Apple--depends on flavor of sql'

SELECT 1 + 1;
SELECT 2 > 3;

SELECT name AS 'fruit',
	   quantity AS 'number',
	    2 = 2,
	    "fruits are delicious" AS 'quote'
FROM fruits;

SELECT id,
	   name AS 'low_quantity_fruit',
	     quantity AS 'inventory'
FROM fruits
WHERE quantity < 4;