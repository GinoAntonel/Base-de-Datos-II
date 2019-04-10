-- 1
SELECT title, special_features FROM film
WHERE rating = 'PG-13'

-- 2
SELECT DISTINCT title,`length` FROM film

-- 3
SELECT title, rental_rate, replacement_cost FROM film
WHERE replacement_cost BETWEEN 20.00 AND 24.00

-- 4
SELECT title, category.name, rating FROM film, film_category, category
WHERE film.film_id = film_category.film_id AND film_category.category_id = category.category_id AND special_features = 'Behind the Scenes'

-- 5
SELECT actor.first_name, actor.last_name FROM film, film_actor, actor
WHERE film.film_id = film_actor.film_id AND film_actor.actor_id = actor.actor_id AND title = 'ZOOLANDER FICTION'

-- 6
SELECT address.address, city.city, country.country FROM store, address, city, country
WHERE store.address_id = address.address_id AND address.city_id = city.city_id AND city.country_id = country.country_id AND store.store_id = 1

-- 7
SELECT f1.title,f2.title, f1.rating
FROM film f1, film f2
WHERE f1.rating = f2.rating AND f1.film_id <> f2.film_id;

-- 8

SELECT DISTINCT title, staff.first_name, staff.last_name
FROM film,inventory,store,staff
WHERE store.store_id = 2 AND film.film_id = inventory.film_id
AND inventory.store_id = store.store_id AND store.store_id = staff.store_id;
