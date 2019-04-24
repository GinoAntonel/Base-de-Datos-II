-- 1 Get the amount of cities per country in the database. Sort them by country, country_id.
SELECT cy.country, cy.country_id, COUNT(*)
	FROM city c, country cy
	WHERE c.country_id = cy.country_id
	GROUP BY cy.country, cy.country_id

-- 2 Get the amount of cities per country in the database. Show only the countries with more than 10 cities, 
-- order from the highest amount of cities to the lowest
SELECT cy.country, cy.country_id, COUNT(*)
	FROM city c, country cy
	WHERE c.country_id = cy.country_id
	GROUP BY cy.country, cy.country_id
	HAVING COUNT(*) > 10
	ORDER BY COUNT(*) DESC
	
-- 3 Generate a report with customer (first, last) name, address, total films rented and the total money spent renting films. 
	-- Show the ones who spent more money first .
SELECT c.first_name, c.last_name,
(SELECT a.address FROM address a WHERE c.address_id = a.address_id) AS 'Address',
(SELECT COUNT(*) FROM rental r WHERE r.customer_id = c.customer_id GROUP BY c.first_name) AS 'Total films',
(SELECT SUM(p.amount) FROM payment p WHERE p.customer_id = c.customer_id GROUP BY c.first_name) AS 'Total_spent'
FROM customer c
ORDER BY Total_spent DESC

-- 4 Which film categories have the larger film duration (comparing average)?
	-- Order by average in descending order

SELECT c.name, AVG(`length`)
FROM category c, film_category fc, film f
WHERE c.category_id = fc.category_id AND fc.film_id = f.film_id
GROUP BY c.name
HAVING AVG(`length`) > (SELECT AVG(`length`) FROM film)
ORDER BY AVG(`length`) DESC

-- 5 Show sales per film rating
SELECT f.rating, SUM(p.amount) AS 'Sales per rating'
FROM film f INNER JOIN inventory USING (film_id) INNER JOIN rental r USING (inventory_id) INNER JOIN payment p USING (rental_id)
GROUP BY f.rating 

