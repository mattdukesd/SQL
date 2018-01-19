#1a
USE sakila
SELECT first_name, last_name
FROM actor;

#1b
SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS 'Actor Name'        
FROM actor;

#2a
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'joe';

#2b
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%gen%';

#2c
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%li%'
ORDER BY last_name, first_name;

#2d
SELECT country_id, country
FROM country
WHERE country IN ('afghanistan', 'bangladesh', 'china');

#3a
ALTER TABLE actor ADD middle_name VARCHAR(100);
ALTER TABLE actor MODIFY middle_name VARCHAR(100) AFTER first_name;

#3b
ALTER TABLE actor MODIFY middle_name BLOB;

#3c
ALTER TABLE actor
DROP COLUMN middle_name;
SELECT * FROM actor;

#4a
SELECT DISTINCT last_name,
(SELECT COUNT(last_name) FROM actor) AS 'count' 
FROM actor;

#4b
SELECT DISTINCT last_name,
(SELECT COUNT(last_name) FROM actor) AS 'count' 
WHERE (COUNT(last_name) > 1)
FROM actor;

#4c
UPDATE actor
SET first_name = 'Harpo'
WHERE first_name = 'Groucho' & last_name = 'Williams';

#7b
SELECT first_name, last_name
FROM actor
WHERE actor_id IN
(SELECT actor_id
 FROM film_actor
 WHERE film_id =
 (SELECT film_id
  FROM film
  WHERE title = 'Alone Trip'
  )
);
