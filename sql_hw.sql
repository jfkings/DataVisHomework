use sakila;

-- 1a

-- select * from actor;

select first_name, last_name 
from actor;

-- 1b

select upper(concat(first_name, ' ', last_name)) as 'Actor Name' 
from actor;

-- 2a

select actor_id, first_name, last_name 
from actor
where first_name = 'Joe';

-- 2b

select first_name, last_name
from actor
where last_name like '%gen%';

-- 2c

select last_name, first_name
from actor
where last_name like '%li%';

-- 2d 

-- select * from country;

select country_id, country
from country 
where country in
('Afghanistan', 'Bangladesh', 'China');

-- 3a 

alter table actor
add column description blob;

-- select * from actor;

-- 3b

alter table actor
drop column description;

-- select * from actor;

-- 4a 

select last_name, 
count(*) as 'Number of Actors by Last Name' 
from actor 
group by last_name;

-- 4b 

select last_name, 
count(*) as 'Number of Actors with Shared Last Name' 
from actor 
group by last_name having count(*) >= 2;

-- 4c 

update actor 
set first_name = 'Harpo'
where first_name = 'Groucho' and last_name = 'Williams';

-- select * from actor;

-- 4d 

update actor 
set first_name = 'Groucho'
where first_name = 'Harpo' and last_name = 'Williams';

-- 5a

-- select * from address;

describe sakila.address;

-- 6a

-- select * from staff;

select first_name, last_name, address
from staff 
join address 
on staff.address_id = address.address_id;

-- 6b 

-- select * from payment;

select payment.staff_id, staff.first_name, staff.last_name, payment.amount, payment.payment_date
from staff inner join payment on
staff.staff_id = payment.staff_id and payment_date like '2005-08%'; 

-- 6c

-- select * from film_actor;
-- select * from film;

select film.title as 'Title', 
count(film_actor.actor_id) as 'Number of Actors'
from film_actor inner join film 
on film_actor.film_id= film.film_id
group by film.title;

-- 6d

-- select * from inventory; 

select title, 
(
	select count(*) from inventory
	where film.film_id = inventory.film_id
)
as 'Total Copies'
from film where title = 'Hunchback Impossible';

-- 6e

-- select * from customer;
-- select * from payment;

select customer.first_name, customer.last_name, sum(payment.amount) as 'Total Paid'
from customer 
join payment 
on customer.customer_id = payment.customer_id
group by customer.last_name, customer.first_name;

-- 7a 

-- select * from film; 

select title
from film where title 
like 'k%' or title like 'q%'
and title in
(
	select title 
	from film 
	where language_id = 1
);

-- 7b

-- select * from actor;
-- select * from film;
-- select * from film_actor;

select first_name, last_name
from actor
where actor_id in
(
	select actor_id
	from film_actor
	where film_id in
(
		select film_id
		from film
		where title = 'Alone Trip'
));

-- 7c

-- select * from customer;
-- select * from country;
-- select * from address;

select customer.first_name, customer.last_name, customer.email 
from customer 
	join address on customer.address_id = address.address_id
		join city on city.city_id = address.city_id
			join country on country.country_id = city.country_id
			where country.country = 'Canada';

-- 7d

-- select * from film;
-- select * from film_category;
-- select * from category;

select title, description from film 
where film_id in
(
	select film_id from film_category
	where category_id in
(
		select category_id from category
		where name = 'Family'
));

-- 7e

-- select * from film;
-- select * from rental;
-- select * from inventory;

select  film.title, count(rental_id) as 'Times Rented' 
from rental 
	join inventory on rental.inventory_id = inventory.inventory_id
	join film on inventory.film_id = film.film_id
group by film.title
order by 'Times Rented' desc;

-- 7f 

-- select * from store;
-- select * from rental;
-- select * from inventory;
-- select * from payment;

select store.store_id, sum(amount) as 'Dollars'
from payment 
	join rental on payment.rental_id = rental.rental_id
		join inventory on inventory.inventory_id = rental.inventory_id
			join store on store.store_id = inventory.store_id
group by store.store_id; 

-- 7g

-- select * from store;
-- select * from address;
-- select * from city;
-- select * from country;

select store.store_id, city.city, country.country 
from store
	join address on store.address_id = address.address_id
	join city on city.city_id = address.city_id
	join country on country.country_id = city.country_id;


--  7h

-- select * from category;
-- select * from film_category;
-- select * from inventory;
-- select * from payment;
-- select * from rental;

select category.name as 'Genre', sum(payment.amount) as 'Gross Revenue' 
from category 
	join film_category on category.category_id = film_category.category_id
	join inventory on film_category.film_id = inventory.film_id
	join rental on inventory.inventory_id = rental.inventory_id
	join payment on rental.rental_id = payment.rental_id
group by category.name 
order by 'Gross Revenue' desc limit 5;

--  8a

create view Genre_by_Revenue as
select category.name as 'Genre', sum(payment.amount) as 'Gross Revenue' 
from category 
	join film_category on category.category_id = film_category.category_id
	join inventory on film_category.film_id = inventory.film_id
	join rental on inventory.inventory_id = rental.inventory_id
	join payment on rental.rental_id = payment.rental_id
group by category.name 
order by 'Gross Revenue' desc limit 5;

  	
--  8b

select * from Genre_by_Revenue;

--  8c

drop view Genre_by_Revenue;
