/* Q1: Who is the senior most employee based on job title? */ 

SELECT title, first_name, last_name FROM employee
ORDER BY levels DESC
LIMIT 1;


/* Q2: Which country has the most invoices? */

SELECT billing_country ,COUNT(invoice_id) as no_of_invoices 
FROM invoice
GROUP BY billing_country
ORDER BY no_of_invoices DESC
LIMIT 1;


/* Q3: What are top three values of total invoice? */

SELECT invoice_id, total FROM invoice
ORDER BY total DESC
LIMIT 3;


/*4- Which city has the best customers? We would like to throw a promotional Music Festival
     in the city we made the most money. Write a query that returns one city that has the 
     highest sum of invoice totals. Return both the city name & sum of all invoice totals. */


SELECT billing_city, SUM(total) as invoice_totals     
FROM invoice
GROUP BY billing_city
ORDER BY invoice_totals DESC
LIMIT 1;


/* 5- Who is the best customer? The customer who has spend the most money will be declared as 
      the best customer. Write a query that returns who has spent the most money.*/

SELECT c.customer_id, c.first_name, c.last_name, SUM(i.total) AS total_spent
FROM customer c
JOIN invoice i
ON i.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 1;

/* Q6- Write query to return the email, first_name, last_name and genre of all Rock Music 
       Listeners. Return your list ordered alphabetically by email starting with A. */

SELECT DISTINCT c.email, c.first_name, c.last_name, g.name AS genre
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Rock'
ORDER BY c.email;


/* Q7: Let us invite the artists who have written the most rock music in our dataset. Write
       a query that returns the Artist name and total track count of the top 10 rock bands. */

SELECT artist.name, genre.name, COUNT(artist.name) AS no_of_rock_songs
FROM artist 
JOIN album ON artist.artist_id = album.artist_id
JOIN track ON album.album_id = track.album_id
JOIN genre ON track.genre_id = genre.genre_id
WHERE genre.name = 'Rock'
GROUP BY artist.name, genre.name
ORDER BY no_of_rock_songs DESC
LIMIT 10;


/* Q8: Return the track names that have a song length longer than the average song length.
       Return the Name and Milliseconds for each track. Order by the song length with the 
       longest songs listed first. */

SELECT name , milliseconds
FROM track
WHERE milliseconds > (SELECT Avg(milliseconds) AS avg_track_length FROM track)
ORDER BY milliseconds DESC;


/* Q9:- Find out how much each customer has spent on the artist who has generated the most revenue.
        Return the customer's ID, their name, the artist's name, and the total amount spent by each
        customer on that artist. */

WITH best_selling_artist AS (
	SELECT artist.artist_id, artist.name AS artist_name, 
	SUM(invoice_line.unit_price*invoice_line.quantity) AS total_spent
	FROM invoice_line
	JOIN track ON invoice_line.track_id = track.track_id
    JOIN album ON track.album_id = album.album_id
	JOIN artist ON album.artist_id = artist.artist_id
	GROUP BY 1
	ORDER BY 3 DESC
	LIMIT 1
)

SELECT customer.customer_id, customer.first_name, customer.last_name, bsa.artist_name , SUM(invoice_line.unit_price * invoice_line.quantity) AS total_spent
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
JOIN track ON invoice_line.track_id = track.track_id
JOIN album ON track.album_id = album.album_id
JOIN artist ON album.artist_id = artist.artist_id
JOIN best_selling_artist bsa ON bsa.artist_id = album.artist_id
GROUP BY 1,2,3,4
ORDER BY 5 DESC;


/* Q10: We want to find out the most popular music Genre for each country. We determine the most popular 
        genre as the genre with the highest amount of purchases. Write a query that returns each country 
        along with the top Genre. For countries where the maximum number of purchases is shared return 
        all Genres. */


WITH popular_genre AS (
	  SELECT customer.country , genre.name as genre_name ,COUNT(invoice_line.quantity) AS purchases,
	  RANK() OVER(PARTITION BY customer.country  ORDER BY COUNT(invoice_line.quantity) DESC) AS rank 
	  FROM customer
	  JOIN invoice ON invoice.customer_id = customer.customer_id
	  JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
	  JOIN track  ON invoice_line.track_id = track.track_id
	  JOIN genre  ON track.genre_id = genre.genre_id 
	  GROUP BY 1,2
	  ORDER BY 1 ASC, 3 DESC
)

	SELECT country, genre_name, purchases
	FROM popular_genre
	WHERE rank = 1;

/* Q11: Write a query that determines the customer that has spent the most on music for each country. 
        Write a query that returns the country along with the top customer and how much they spent. 
        For countries where the top amount spent is shared, provide all customers who spent this amount. */

WITH top_customer AS(
	SELECT customer.customer_id , customer.first_name, customer.last_name, invoice.billing_country AS Country , SUM(invoice.total) as total_spent,
	RANK() OVER(PARTITION BY invoice.billing_country ORDER BY SUM(invoice.total) DESC) as rank
	FROM customer 
    JOIN invoice ON invoice.customer_id = customer.customer_id
	GROUP BY customer.customer_id, customer.first_name, customer.last_name, invoice.billing_country
	ORDER BY Country ASC, total_spent DESC
)
 
SELECT Country, customer_id, first_name || ' ' || last_name AS customer_name , total_spent 
FROM top_customer
WHERE rank = 1;
