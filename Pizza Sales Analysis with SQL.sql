

/* SQL Queries for Pizza Sales Analysis */


/*  1. Total Revenue: */

SELECT ROUND(SUM(unit_price*quantity),2) AS Total_Revenue 
FROM pizza_sales;


/* 2. Average Order Value */
SELECT ROUND((SUM(total_price) / COUNT(DISTINCT order_id)),2) AS Avg_order_Value 
FROM pizza_sales;


/* 3. Total Pizzas Sold */
SELECT SUM(quantity) AS Total_Qty_sold 
FROM pizza_sales;

/* 4. Total Orders */
SELECT COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales;


/* 5. Average Pizzas Per Order */
SELECT 
		CAST(
			CAST(SUM(quantity) AS DECIMAL(10,2)) / 
			CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)
			) AS DECIMAL(10,2))
		AS "Avg Pizzas per Order"
FROM pizza_sales;


/* Daily Trend for Total Orders */

SELECT DATENAME(DW, order_date) AS order_day, 
		COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY DATENAME(DW, order_date);


/* Monthly Trend for Orders */

select DATENAME(MONTH, order_date) as "Month", 
		COUNT(DISTINCT order_id) as Total_Orders
from pizza_sales
GROUP BY DATENAME(MONTH, order_date);


/* % of Sales Revenue by Pizza Category */
SELECT pizza_category, 
		CAST(SUM(unit_price*quantity) AS DECIMAL(10,2)) as Revenue,
		CAST(SUM(unit_price*quantity) * 100 / 
			(SELECT SUM(unit_price*quantity) from pizza_sales) AS DECIMAL(10,2)) 
		AS "% of Revenue"
FROM pizza_sales
GROUP BY pizza_category
ORDER BY "% of Revenue" DESC;


/* % of Sales by Pizza Size */
SELECT pizza_size, 
		CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
		CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) 
										FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;


/* Total Quantity Sold by Pizza Category */
SELECT pizza_category, 
		SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;


/* Top 5 Pizzas by Revenue */
SELECT Top 5 pizza_name, 
		SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC;


/* Bottom 5 Pizzas by Revenue */
SELECT Top 5 pizza_name, 
		SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC;


/* Top 5 Pizzas by Quantity */
SELECT Top 5 pizza_name, 
		SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC;


/* Bottom 5 Pizzas by Quantity */
SELECT TOP 5 pizza_name, 
		SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC;


/* Top 5 Pizzas by Total Orders */
SELECT Top 5 pizza_name, 
		COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC;


/* Borrom 5 Pizzas by Total Orders */
SELECT Top 5 pizza_name, 
		COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC;


/* Top 5 Total Orders of Classic Pizza */
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
WHERE pizza_category = 'Classic'
GROUP BY pizza_name
ORDER BY Total_Orders ASC;


/* Rush hours for Pizza Order*/
SELECT 
		CASE
			WHEN CAST(order_time AS TIME)>='06:00:00' AND CAST (order_time AS TIME)<'12:00:00' THEN 'Breakfast'
			WHEN CAST(order_time AS TIME)>='12:00:00' AND CAST (order_time AS TIME)<'18:00:00' THEN 'Lunch'
			ELSE 'Dinner'
		END AS 'Eating time',
		COUNT(order_time) AS Total_Orders
FROM pizza_sales
GROUP BY
		CASE
			WHEN CAST(order_time AS TIME)>='06:00:00' AND CAST (order_time AS TIME)<'12:00:00' THEN 'Breakfast'
			WHEN CAST(order_time AS TIME)>='12:00:00' AND CAST (order_time AS TIME)<'18:00:00' THEN 'Lunch'
			ELSE 'Dinner'
		END
ORDER BY 
		CASE
			WHEN CAST(order_time AS TIME)>='06:00:00' AND CAST (order_time AS TIME)<'12:00:00' THEN 'Breakfast'
			WHEN CAST(order_time AS TIME)>='12:00:00' AND CAST (order_time AS TIME)<'18:00:00' THEN 'Lunch'
			ELSE 'Dinner'
		END DESC;
