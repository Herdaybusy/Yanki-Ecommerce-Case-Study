-- Claculate the total sales amount for each order along with the individual products sale
SELECT 
	o.Order_ID,
	p.Product_ID,
	p.Price,
	o.Quantity,
	o.Total_Price,
	SUM(p.Price * o.Quantity) OVER (PARTITION BY o.Order_ID) AS total_sales_amount
FROM 
	yanki.orders o
JOIN 
	yanki.products p ON o.Product_ID = p.Product_ID

	  
-- CALCULATE THE RUNNING COST OF EACH ORDER
SELECT 
	Order_ID,
	Product_ID,
	Quantity,
	Total_Price,
	sum(Total_Price) OVER (ORDER BY Order_ID) as running_total_price
FROM 
	yanki.orders o
	
-- RANK EACH PRODUCTS BY THEIR PRICE WITHIN EACH CATEGORY
SELECT 
	Product_Name,
	Brand,
	category,
	price,
	Rank() OVER ( PARTITION BY Category ORDER BY Price DESC) AS price_rank_by_category
FROM 
yanki.products

-- RANK CUSTOMERS BY TOTAL AMOUNT SPENT 
SELECT
	C.Customer_ID,
	C.Customer_name,
	O.Total_Price,
	Rank() OVER (ORDER BY total_price desc) as customer_rank_by_total_amount
FROM
	yanki.customers c
JOIN
	yanki.orders o ON c.Customer_ID = O.Customer_ID

-- RANK PRODUCT BY THEIR TOTAL SALES AMOUNT
SELECT
	p.Product_ID,
	p.Product_name,
	o.Total_price,
	o.Quantity,
	Rank() OVER(ORDER BY Total_price DESC) AS product_rank
FROM 
	yanki.products p
JOIN
	yanki.orders o ON p.Product_ID = o.Product_ID

-- RANK ORDERS BY THEIR TOTAL PRICE
SELECT 
	Order_ID,
	Total_Price,
	Rank() OVER (ORDER BY Total_Price DESC) AS order_rank
FROM
	yanki.Orders 

-- CATEGORIZE ORDERS BASED ON TOTAL PRICE
SELECT 
	Order_ID,
	Total_Price,
	CASE
		WHEN Total_Price >= 1000 THEN 'HIGH'
		WHEN Total_Price >=500 AND Total_Price < 1000   THEN 'MEDIUM'
		ELSE 'LOW'
	END AS PRICE_CATEGORY
FROM 
	yanki.orders

-- CLASSIFY CUSTOMERS BY NUMBER OF ORDERS THEY MADE
SELECT 
	c.Customer_ID,
	c.Customer_name,
	COUNT(o.Order_ID) AS num_orders,
	CASE
		WHEN COUNT(Order_ID) >= 10 THEN 'FREQUENT'
		WHEN COUNT(Order_ID) >= 5 AND COUNT(Order_ID) <10 THEN 'REGULAR'
		ELSE 'OCCASIONAL'
	END AS Order_frequency
FROM
	yanki.customers c
JOIN
	yanki.orders o ON c.Customer_ID = O.Customer_ID
GROUP BY
	c.Customer_ID,
	c.Customer_name;

-- CATEGORIZE PRODUCTS BASED ON THEIR PRICE
SELECT 
	Product_ID,
	Product_name
	Price,
	CASE
		WHEN Price >= 500 THEN 'EXPENSIVE'
		WHEN Price >=100 AND Price < 500   THEN 'MODERATE'
		ELSE 'AFFORDABLE'
	END AS PRICE_CATEGORY
FROM 
	yanki.products

-- RETRIEVE CUSTOMER DETAILS ALONG WITH PRODUCTS THEY ORDERED
SELECT 
	c.Customer_ID,
	c.Customer_name,
	c.email,
	c.Phone_number,
	o.order_ID,
	p.Product_name,
	p.Product_ID,
	p.Brand
FROM
	yanki.customers c
INNER JOIN 
	yanki.orders o ON c.Customer_ID = O.Customer_ID
INNER JOIN 
	yanki.products p ON o.product_ID = p.Product_ID
	