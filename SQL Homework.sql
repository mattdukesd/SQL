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
SELECT COUNT(last_name) AS 'This Many Times', last_name AS 'Last Name'
FROM actor
GROUP BY last_name;

#4b
SELECT * FROM 
(SELECT COUNT(last_name) AS 'Quantity', last_name
 FROM actor
 GROUP BY last_name
) AS nest
WHERE nest.quantity > 1;

#4c
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

#4d
UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO' AND last_name = 'WILLIAMS';

#5a
USE sakila
CREATE TABLE address;

#6a
SELECT staff.first_name, staff.last_name, address.address
FROM staff, address
WHERE staff.address_id = address.address_id;

#6b
SELECT staff.first_name, SUM(aug.amount) AS 'aug_sales' FROM staff,
(SELECT *
 FROM payment
 WHERE payment_date LIKE '2005-08%'
) AS aug
WHERE aug.staff_id = staff.staff_id
GROUP BY aug.staff_id;

#6c
SELECT film.title, COUNT(film_actor.actor_id) AS 'actors'
FROM film_actor, film
WHERE film_actor.film_id = film.film_id
GROUP BY actor_id;

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
