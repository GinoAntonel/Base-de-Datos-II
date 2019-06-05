-- Clase 11
-- 1 Find all the film titles that are not in the inventory.
SELECT f.title
    FROM film f LEFT JOIN inventory i
    ON f.film_id = i.film_id
	WHERE i.film_id IS NULL;

-- 2 Find all the films that are in the inventory but were never rented. 
	-- Show title and inventory_id.
	-- This exercise is complicated. 
	-- hint: use sub-queries in FROM and in WHERE or use left join and ask if one of the fields is NULL
SELECT f.title, i.inventory_id
	FROM film f 
	INNER JOIN inventory i USING (film_id) 
	LEFT JOIN rental r USING (inventory_id)
	WHERE r.inventory_id IS NULL;

-- 3 Generate a report with:
	-- customer (first, last) name, store id, film title, 
	-- when the film was rented and returned for each of these customers
	-- order by store_id, customer last_name
SELECT c.first_name, c.last_name, s.store_id, f.title
	FROM film f 
	INNER JOIN inventory i ON f.film_id = i.film_id
	INNER JOIN rental r ON r.inventory_id = i.inventory_id
	INNER JOIN customer c ON c.customer_id = r.customer_id
	INNER JOIN store s ON c.store_id = s.store_id
	WHERE r.rental_date IS NOT NULL
	ORDER BY s.store_id, c.last_name
	
-- 4 Show sales per store (money of rented films)
	-- show store's city, country, manager info and total sales (money)
	-- (optional) Use concat to show city and country and manager first and last name
SELECT SUM(p.amount) AS 'Total Sales',
	CONCAT(ci.city, ' ', co.country) AS 'Localidad',
	CONCAT(st.first_name, ' ', st.last_name) AS 'Nombre completo'
	FROM payment p
	INNER JOIN rental r ON r.rental_id = p.rental_id
	INNER JOIN customer c ON r.customer_id = c.customer_id
	INNER JOIN store s ON s.store_id = c.store_id
	INNER JOIN staff st ON s.manager_staff_id = st.staff_id
	INNER JOIN address a ON a.address_id = st.address_id
	INNER JOIN city ci ON ci.city_id = a.city_id
	INNER JOIN country co ON co.country_id = ci.country_id
	GROUP BY s.store_id;
	
-- 5 Which actor has appeared in the most films?
SELECT CONCAT(a.first_name, ' ', a.last_name) AS 'Nombre Completo', a.actor_id, COUNT(a.actor_id) AS 'Veces'
    FROM actor a
    INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id
    HAVING COUNT(a.actor_id) >= ALL(SELECT COUNT(a2.actor_id)
                                        FROM actor a2
                                        INNER JOIN film_actor fa2
                                        ON a2.actor_id = fa2.actor_id
GROUP BY a2.actor_id);

