CREATE DATABASE imdb;
USE imdb;
CREATE TABLE IF NOT EXISTS film (
	film_id INT NOT NULL AUTO_INCREMENT,
	title VARCHAR(25) NOT NULL,
	description VARCHAR(50),
	release_year DATE,
	CONSTRAINT film_pk PRIMARY KEY (film_id)
);
CREATE TABLE actor (
	actor_id INT NOT NULL AUTO_INCREMENT,
	first_name VARCHAR(15) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	CONSTRAINT actor_pk PRIMARY KEY (actor_id)
);
CREATE TABLE film_actor (
	actor_id INT NOT NULL,
	CONSTRAINT fk_actor_id FOREIGN KEY (actor_id) REFERENCES actor (actor_id),
	film_id INT NOT NULL,
	CONSTRAINT fk_film_id FOREIGN KEY (film_id) REFERENCES film (film_id)
);
ALTER TABLE film
	ADD last_update DATE;
ALTER TABLE actor
	ADD last_update DATE;


INSERT INTO imdb.actor
(first_name, last_name, last_update)
VALUES('gino', 'antonel', '1999-5-17');
INSERT INTO imdb.actor
(first_name, last_name, last_update)
VALUES('fede', 'vargas', '1889-12-1');

INSERT INTO imdb.film
(title, description, release_year, last_update)
VALUES('Los piratas del aljibe', 'Pelicula con buenos efectos especiales', '2003-3-25', '2008-3-25');
INSERT INTO imdb.film
(title, description, release_year, last_update)
VALUES('Fran gomez ndeah', 'Pelicula de comedia muy interesante', '2018-5-10', '2019-1-7');
SELECT * FROM film;

