-- List of all horror films with id, release year, mpaa rating 
create view horror_films AS 
select film.film_id, film.title as Title, film.release_year as Year,  film.rating
from film 
join film_category fc
on film.film_id = fc.film_id
join category 
on category.category_id = fc.category_id
where category.name = 'Horror';  

-- How many titles are in each rating group?
select rating, count(*)
from horror_films
group by rating; 

-- How many horror films are currently in inventory by store? 
select inventory.store_id as store, count(*)
from inventory
join film
on film.film_id = inventory.film_id
join film_category fc
on film.film_id = fc.film_id
join category
on category.category_id = fc.category_id
where category.name = 'Horror'
group by store;


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
select horror_films.film_id as id, horror_films.title as title, count(inventory.film_id) as rented, rating  
from rental 
join inventory 
on inventory.inventory_id = rental.inventory_id 
join horror_films
on horror_films.film_id = inventory.film_id
group by id, title, rating
order by rented desc
limit 10;
 
select * 
from top_rented_horror; 
 
-- What was the average rental duration of these top films?
select avg(rental_duration)
from film
where exists (select * from top_rented_horror);

-- Which customers in the United States live in a city that start with A, B, or C?
-- We can use this is a marketing list and start from A,B,C...to Z cities 
select c.first_name, c.last_name, city.city, country.country 
from country 
join  city 
on country.country_id = city.country_id
join address 
on city.city_id = address.city_id 
join customer c 
on c.customer_id = address.city_id
where country.country = 'United States' AND city.city ~ '^[ABC]';

-- Which customers have never rented a DVD?
-- Maybe these customers can be marketed to
select customer.first_name, customer.last_name, customer.address_id
from customer
left join rental
on customer.customer_id = rental.customer_id 
where rental.customer_id IS NULL;

-- Which customers are in the same houehold?
-- We don't want to send duplicate marketing materials if two people live in the same household 
select cust1.first_name, cust2.last_name, cust1.first_name, cust2.last_name
from customer as cust1
join customer as cust2
on cust1.customer_id <> cust2.customer_id and cust1.address_id = cust2.address_id;

-- Which stores have the most active staff? 
-- Want to see if there is enough staff avaliable for the holiday 
select store.store_id, CONCAT(staff.first_name,' ', staff.last_name)
from store
left join staff
on store.store_id = staff.store_id
where staff.active = true; 
