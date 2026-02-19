-- Find top countries with highest number of sales

SELECT country,
	   COUNT(customer_id) AS count_of_cust
FROM customer AS cust

	-- Join address to customer to determine where each customer lives
INNER JOIN address AS add 
	ON cust.address_id = add.address_id
	
	-- Join city to address to retrieve the customer's city information
INNER JOIN city AS cit 
	ON add.city_id = cit.city_id
	
	-- Join country to city to retrieve the corresponding country 
INNER JOIN country AS cou 
	ON cit.country_id = cou.country_id
	
	-- Aggregate by country
GROUP BY country

	-- Sort and limit to the top 10 countries
ORDER BY COUNT (customer_id) DESC
LIMIT 10;