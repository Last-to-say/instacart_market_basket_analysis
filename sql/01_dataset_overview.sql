/* =====================================================
1 Dataset Overview
===================================================== */

/*
Business Question
What is the scale of the dataset?
Understanding dataset size helps estimate query complexity
and provides context for the analysis.
*/


-- Total number of orders
SELECT
    COUNT(*) AS total_orders
FROM orders;		

-- Insight:
-- The dataset contains 3,421,083 orders.


-- Total number of customers
SELECT
    COUNT(DISTINCT user_id) AS unique_customers
FROM orders;

-- Insight:
-- There are 206,209 unique customers in the dataset.


-- Total number of products
SELECT
    COUNT(*) AS total_products
FROM products;

-- Insight:
-- The product catalog contains 49,688 products.
