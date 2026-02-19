-- Find the top 5 customers from the top 10 cities who have paid the highest total amounts

SELECT cust.customer_id,
	   cust.first_name,
       cust.last_name,
	   cou.country,
	   cit.city,
       SUM(pay.amount) AS total_payment
FROM customer AS cust

-- Join payment to customer to access each customer's transactions
INNER JOIN payment AS pay 
	ON cust.customer_id = pay.customer_id
	
	-- Join address to customer to determine where each customer lives
INNER JOIN address AS add 
	ON cust.address_id = add.address_id
	
	-- Join city to address to retrieve the customer's city information
INNER JOIN city AS cit 
	ON add.city_id = cit.city_id
	
	-- Join country to city to retrieve the corresponding country 
INNER JOIN country AS cou 
	ON cit.country_id = cou.country_id
	
	-- Filter only for the top 10 cities identified earlier
WHERE cit.city IN 
	('Aurora', 'Atlixco', 'Xintai', 'Adoni', 
	'Dhule (Dhulia)', 'Kurashiki', 'Pingxiang', 
	'Sivas', 'Celaya', 'So Leopoldo')
	
	-- Filter only for the top 10 countries identified earlier
AND cou.country IN 
	('India', 'China', 'United States', 
	'Japan', 'Mexico', 'Brazil', 
	'Russian Federation', 'Philippines', 
	'Turkey', 'Indonesia')
	
	-- Aggregate total payments per customer
GROUP BY cust.customer_id, 
		 cust.first_name, 
		 cust.last_name, 
		 cou.country, 
		 cit.city
		 
	-- Sort and limit to the top 5 high-paying customers
ORDER BY total_payment DESC
LIMIT 5;