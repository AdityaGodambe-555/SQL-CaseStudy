/*SQL Case Study- MUSIC STORE DATA ANALYSIS*/

/*1. Who is the senior most employee based on job title?*/
select * from employee group by title having min(hire_date) order by levels desc;

/*2. Which countries have the most Invoices?*/
select billing_country ,count(invoice_id) as NoOfInvoice from invoice group by billing_country order by NoOfInvoice desc limit 1;

/*3. What are top 3 values of total invoice?*/
select round(total,3) from invoice order by total desc limit 3;

/*4. Which city has the best customers? We would like to throw a promotional Music 
Festival in the city we made the most money. Write a query that returns one city that 
has the highest sum of invoice totals. Return both the city name & sum of all invoice 
totals*/
select billing_city,sum(total) as Sum_total_Invoice from invoice group by billing_city order by Sum_total_Invoice desc limit 1;

/*5. Who is the best customer? The customer who has spent the most money will be 
declared the best customer. Write a query that returns the person who has spent the 
most money*/
select c.customer_id,c.first_name,sum(i.total) as total_spend from customer c inner join invoice i on(c.customer_id=i.customer_id) 
group by i.customer_id
order by total_spend desc;

/*6. Write query to return the email, first name, last name, & Genre of all Rock Music 
listeners. Return your list ordered alphabetically by email starting with A*/
select c.email,c.first_name,c.last_name,g.name from 
customer c join invoice i on(c.customer_id=i.customer_id)
join invoice_line il on(i.invoice_id=il.invoice_id)
join track t on(t.track_id=il.track_id)
join genre g on(g.genre_id=t.genre_id)
where g.name like 'Rock%'
order by c.email;

/*7. Let's invite the artists who have written the most rock music in our dataset. Write a 
query that returns the Artist name and total track count of the top 10 rock bands*/
select a.name,count(g.name) from artist a
join album ab on(a.artist_id=ab.artist_id)
join track t on(ab.album_id=t.album_id)
join genre g on(t.genre_id=g.genre_id)
where g.name  like 'Rock%'
group by a.name
order by count(g.name) desc
limit 10;

/*8. Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the 
longest songs listed first*/
select name,milliseconds from track 
where milliseconds >
(select avg(milliseconds) from track)
order by milliseconds desc ;



