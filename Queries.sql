-- List of all horror films with id, release year, mpaa rating 
create view horror_films AS 
select film.film_id, film.title as Title, film.release_year as Year,  film.rating
from film 
join film_category fc
on film.film_id = fc.film_id
join category 
on category.category_id = fc.category_id
WHERE category.name = 'Horror';  


-- How many horror films are currently in inventory by store? 
select inventory.store_id as store, count(*)
from inventory
join film
on film.film_id = inventory.film_id
join film_category fc
on film.film_id = fc.film_id
join category
on category.category_id = fc.category_id
WHERE category.name = 'Horror'
GROUP BY store;


--What are the top selling horror films and their rating? 
select horror_films.title as title, horror_films.rating as rating, sum(payment.amount) as sales
from payment 
join rental 
on rental.rental_id = payment.rental_id
join inventory
on inventory.inventory_id = rental.inventory_id
join horror_films
on horror_films.film_id = inventory.film_id
group by title, rating 
order by sales desc
limit 5; 


-- What are the top rented horror films? 
create view top_rented_horror AS
select horror_films.film_id as id, horror_films.title as title, count(inventory.film_id) as rented
from rental 
join inventory 
on inventory.inventory_id = rental.inventory_id 
join horror_films
on horror_films.film_id = inventory.film_id
group by id, title
order by rented desc
limit 10;
 
 
-- What was the average rental duration of these top films?
select avg(rental_duration)
from film
where exists (select * from top_rented_horror);

-- Which customers are in the same houehold?
select cust1.first_name, cust2.last_name, cust1.first_name, cust2.last_name
from customer as cust1
join customer as cust2
on cust1.customer_id <> cust2.customer_id and cust1.address_id = cust2.address_id;


-- Which customers have never rented a DVD?
select customer.first_name, customer.last_name, customer.address_id
from customer
left join rental
on customer.customer_id = rental.customer_id 
where rental.customer_id IS NULL;

-- Which stores have the most active staff? 
SELECT store.store_id, CONCAT(staff.first_name,' ', staff.last_name)
FROM store
LEFT JOIN staff
ON store.store_id = staff.store_id
WHERE staff.active = true; 

