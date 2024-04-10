use bakery;
-- window function

-- rolling forecast

SELECT 
	customer_id,
    order_total,
    SUM(order_total) OVER(PARTITION BY customer_id ORDER BY order_total) AS Rolling_Total
FROM customer_orders;

-- row number

WITH cte AS(
SELECT
	c.customer_id as customers,
	first_name,
    order_total,
    ROW_NUMBER() OVER(PARTITION BY first_name ORDER BY order_total DESC) AS row_num
FROM customers c
JOIN customer_orders co
	ON c.customer_id = co.customer_id
)
SELECT 
	customers,
	first_name,
	order_total,
    row_num
FROM cte
WHERE row_num = 1
;

-- lead and lag function

SELECT *,
	CASE 
		WHEN salary < lags THEN 'Less'
        WHEN salary = lags THEN 'Equal'
        ELSE 'More'
	END AS salary_diff
FROM
	(SELECT *,
			LAG(salary) OVER(PARTITION BY department ORDER BY employee_id) AS lags
	FROM employees) AS lag_table 
;



