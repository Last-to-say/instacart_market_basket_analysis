/* =====================================================
3. PRODUCT POPULARITY
===================================================== */

/*
Business Question
What are the most frequently ordered products?
This helps identify staple grocery items that drive demand.
*/

SELECT
    p.product_id,
    p.product_name,
    COUNT(*) AS total_orders
FROM order_products_prior op
JOIN products p
    ON op.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY
    total_orders DESC
LIMIT 10;


/*
Insight

Fresh produce dominates the most frequently ordered products.
Items such as bananas, strawberries, avocados, and spinach
appear in several of the top positions.

This suggests:

• Customers frequently reorder fresh produce
• These items likely act as basket anchors
• Demand forecasting for produce is particularly important
*/

/*
Business Question
How many unique customers purchased each product?

This helps determine whether product popularity is driven by
broad customer demand or by a small number of repeat buyers.
*/

SELECT
    p.product_id,
    p.product_name,
    COUNT(*) AS total_orders,
    COUNT(DISTINCT o.user_id) AS unique_buyers
FROM order_products_prior op
JOIN products p
    ON op.product_id = p.product_id
JOIN orders o
    ON op.order_id = o.order_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY
    total_orders DESC
LIMIT 10;


/*
Insight

Top products are purchased by a large number of unique customers,
indicating that demand is broadly distributed across the customer base.

This pattern is typical for staple grocery products that are
frequently included in everyday shopping baskets.
*/
