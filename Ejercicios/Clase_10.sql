-- 1 Find all the film titles that are not in the inventory. 
SELECT title
FROM film f LEFT JOIN inventory i 
ON f.film_id = i.film_id
WHERE i.film_id IS NULL 

-- 2 Find all the films that are in the inventory but were never rented. 
	-- Show title and inventory_id.
	-- This exercise is complicated. 
	-- hint: use sub-queries in FROM and in WHERE or use left join and ask if one of the fields is NULL
SELECT f.title, i.inventory_id
FROM film f
INNER JOIN inventory i ON f.film_id = i.inventory_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.inventory_id IS NULL 

-- 3 Generate a report with:
	-- customer (first, last) name, store id, film title, 
	-- when the film was rented and returned for each of these customers
	-- order by store_id, customer last_name

SELECT c.first_name, c.last_name, s.store_id, f.title
FROM customer c
INNER JOIN store s ON s.store_id = c.store_id
INNER JOIN rental r ON r.customer_id = c.customer_id
INNER JOIN inventory i ON i.inventory_id = r.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
WHERE r.return_date IS NOT NULL
ORDER BY s.store_id, c.last_name

-- 4 Show sales per store (money of rented films)
	-- show store's city, country, manager info and total sales (money)
	-- (optional) Use concat to show city and country and manager first and last name

SELECT CONCAT(ci.city, ' ', co.country) AS 'Store location', CONCAT(st.first_name, ' ' ,st.last_name) AS 'Manager info', SUM(p.amount)
FROM payment p
INNER JOIN rental r ON p.rental_id = r.rental_id
INNER JOIN customer c ON c.customer_id = r.customer_id
INNER JOIN store s ON c.store_id = s.store_id
INNER JOIN staff st ON st.staff_id = s.manager_staff_id
INNER JOIN address a ON a.address_id = st.address_id
INNER JOIN city ci ON ci.city_id = a.city_id
INNER JOIN country co ON ci.country_id = co.country_id
GROUP BY s.store_id

-- 5 Which actor has appeared in the most films?

SELECT CONCAT_WS(" ", a.first_name, a.last_name) AS 'name', COUNT(*) AS 'times'
    FROM actor a
    INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id
    HAVING COUNT(a.actor_id) >= ALL(SELECT COUNT(a2.actor_id)
                                        FROM actor a2
                                        INNER JOIN film_actor fa2
                                        ON a2.actor_id = fa2.actor_id
GROUP BY a2.actor_id);

-- OR

SELECT CONCAT_WS(" ", a.first_name, a.last_name) AS 'name', COUNT(a.actor_id) AS 'times'
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
HAVING times >= ALL (SELECT count(film_id) FROM film_actor GROUP BY actor_id)

