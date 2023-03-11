/*
 * Write a SQL query SELECT query that:
 * List the first and last names of all actors who have appeared in movies in the "Children" category,
 * but that have never appeared in movies in the "Horror" category.
 */

/* This query assumes that by "appeared in movies" we mean "has appeared in one or more movies", not "has appeared in 2 or more movies". */
SELECT DISTINCT first_name, last_name FROM actor
    JOIN film_actor USING (actor_id)
    JOIN film USING (film_id)
    JOIN film_category USING (film_id)
    JOIN category USING (category_id)
    WHERE name='Children'
    EXCEPT ALL
    (
        SELECT first_name, last_name FROM actor
            JOIN film_actor USING (actor_id)
            JOIN film USING (film_id)
            JOIN film_category USING (film_id)
            JOIN category USING (category_id)
            WHERE name='Horror'
    )
    ORDER BY last_name ASC, first_name ASC;
