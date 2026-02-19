-- Find the top 5 customers from the top 10 cities who have paid the highest total amounts use CTE

WITH average_CTE (customer_id,
	   first_name,
       last_name,
	   city,
	   country,
	   customer_numbers,
	   total_amount_paid)
AS
(SELECT c.customer_id,
		first_name,
		last_name,
		city,
		country,
		COUNT(c.customer_id) AS customer_numbers,
		SUM(amount) AS total_amount_paid
	FROM customer c
	
	-- Join payment to customer to access each customer's transactions
	INNER JOIN payment AS p 
		ON c.customer_id = p.customer_id
	
	-- Join address to customer to determine where each customer lives
	INNER JOIN address AS add 
		ON c.address_id = add.address_id
	
	-- Join city to address to retrieve the customer's city information
	INNER JOIN city AS cit 
		ON add.city_id = cit.city_id
	
	-- Join country to city to retrieve the corresponding country 
	INNER JOIN country AS cou 
		ON cit.country_id = cou.country_id
	
		-- Filter only for the top 10 cities identified earlier
	WHERE city IN 
		('Aurora', 'Atlixco', 'Xintai', 'Adoni', 
		'Dhule (Dhulia)', 'Kurashiki', 'Pingxiang', 
		'Sivas', 'Celaya', 'So Leopoldo')
	
	-- Filter only for the top 10 countries identified earlier
	AND country IN 
		('India', 'China', 'United States', 
		'Japan', 'Mexico', 'Brazil', 
		'Russian Federation', 'Philippines', 
		'Turkey', 'Indonesia')
	
		-- Aggregate total payments per customer
	GROUP BY c.customer_id, 
			 c.first_name, 
			 c.last_name, 
			 cou.country, 
			 cit.city
			 
		-- Sort and limit to the top 5 high-paying customers
	ORDER BY total_payment DESC
	LIMIT 5
)

SELECT AVG(total_amount_paid) as avg_amount_paid from average_CTE;



	
	
	

	
