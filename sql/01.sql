/*
 * You want to watch a movie tonight.
 * But you're superstitious,
 * and don't want anything to do with the letter 'F'.
 *
 * Write a SQL query that lists the titles of all movies that:
 * 1) do not have the letter 'F' in their title,
 * 2) have no actors with the letter 'F' in their names (first or last),
 * 3) have never been rented by a customer with the letter 'F' in their names (first or last).
 * 4) have never been rented by anyone with an 'F' in their address (at the street, city, or country level).
 *
 * NOTE:
 * Your results should not contain any duplicate titles.
 */

/* I'm going to assume that by avoiding the letter 'F', this means that we want to avoid everything that has 'F' or 'f'. If it was supposed to be just 'F', then I would change all of the ILIKE keywords to LIKE keywords instead. */

WITH contains_f AS (
    SELECT film_id FROM film
    WHERE title ILIKE '%F%'
UNION (
    SELECT film_id FROM film_actor
    JOIN actor USING (actor_id)
    WHERE first_name ILIKE '%F%' OR last_name ILIKE '%F%'
) UNION (
    SELECT film_id FROM film
    JOIN inventory USING (film_id)
    JOIN rental USING (inventory_id)
    JOIN customer USING (customer_id)
    WHERE first_name ILIKE '%F%' OR last_name ILIKE '%F%'
) UNION (
    SELECT film_id FROM film
    JOIN inventory USING (film_id)
    JOIN rental USING (inventory_id)
    JOIN customer USING (customer_id)
    JOIN address USING (address_id)
    JOIN city USING (city_id)
    JOIN country USING (country_id)
    WHERE address ILIKE '%F%' OR city ILIKE '%F%' OR country ILIKE '%F%'
))
SELECT title FROM film
WHERE film_id NOT IN
(SELECT film_id FROM contains_f);

