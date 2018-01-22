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

#change a movie to foreign language to make next exercise relevant (I can't believe this is a question when all movies are in english!)
UPDATE film
SET language_id = 2
WHERE title = 'KARATE MOON';

#7a
SELECT eng.title
FROM
(SELECT *
 FROM
 (SELECT film.title, language.name 
  FROM film, language
  WHERE film.language_id = language.language_id
 ) AS lang
 WHERE lang.name = 'English'
) AS eng
WHERE eng.title LIKE 'K%' OR eng.title LIKE'Q%';

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

#7c
SELECT final.first_name, final.last_name, final.email
FROM 
(SELECT customer.first_name, customer.last_name, customer.email, drs.country
FROM customer JOIN
(SELECT cntry.country, address.address_id
 FROM address JOIN
 (SELECT country.country, city.city_id 
 FROM country JOIN city
 ON country.country_id = city.country_id
 ) AS cntry
 ON cntry.city_id = address.city_id
) AS drs
ON drs.address_id = customer.address_id
) AS final
WHERE final.country = 'CANADA';

#7d
SELECT film.title, film_text.description
FROM film JOIN film_text
ON film.title = film_text.title
WHERE film.rating = 'G';

#7e
SELECT COUNT(rental.rental_id) AS cnt, inv.title
FROM rental LEFT JOIN 
(SELECT inventory.film_id, inventory.inventory_id, film.title
 FROM film JOIN inventory
 ON inventory.film_id  = film.film_id
) AS inv
ON rental.inventory_id = inv.inventory_id
GROUP BY inv.title
ORDER BY cnt DESC;

#7f
SELECT customer.store_id AS Store, SUM(payment.amount) AS Revenue
FROM payment JOIN customer
ON payment.customer_id = customer.customer_id
GROUP BY customer.store_id;

#7g
SELECT cts.store_id AS Store, cts.city AS City, country.country AS Country
FROM country RIGHT JOIN
(SELECT stores.store_id, city.city, city.country_id
 FROM city RIGHT JOIN
 (SELECT store.store_id, address.city_id
  FROM store LEFT JOIN address
  ON store.address_id = address.address_id
 ) AS stores
 ON city.city_id = stores.city_id
) AS cts
ON cts.country_id = country.country_id;

#7h
SELECT rnt.name AS Genre, SUM(payment.amount) AS Revenue
FROM payment JOIN
 (SELECT rental.rental_id, inv.name
  FROM rental JOIN
 (SELECT inventory.inventory_id, cat.name
  FROM inventory JOIN
  (SELECT film_category.film_id, category.name
   FROM film_category JOIN category
   ON film_category.category_id = category.category_id
  ) AS cat
  ON inventory.film_id = cat.film_id
 ) AS inv
 ON rental.inventory_id = inv.inventory_id
) AS rnt
ON rnt.rental_id = payment.rental_id
GROUP BY rnt.name
ORDER BY Revenue DESC
LIMIT 5;

#8a
CREATE VIEW report AS
SELECT rnt.name AS Genre, SUM(payment.amount) AS Revenue
FROM payment JOIN
 (SELECT rental.rental_id, inv.name
  FROM rental JOIN
 (SELECT inventory.inventory_id, cat.name
  FROM inventory JOIN
  (SELECT film_category.film_id, category.name
   FROM film_category JOIN category
   ON film_category.category_id = category.category_id
  ) AS cat
  ON inventory.film_id = cat.film_id
 ) AS inv
 ON rental.inventory_id = inv.inventory_id
) AS rnt
ON rnt.rental_id = payment.rental_id
GROUP BY rnt.name
ORDER BY Revenue DESC
LIMIT 5;

#8b
SELECT * FROM report;

#8c
DROP VIEW report;
