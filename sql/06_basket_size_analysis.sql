/* =====================================================
6. BASKET SIZE ANALYSIS
===================================================== */

/*
Business Question

How many products do customers typically purchase
in a single order?

Understanding basket size helps identify typical
shopping behavior and purchasing patterns.
*/


WITH basket_sizes AS (

    SELECT
        order_id,
        COUNT(*) AS items_in_order
    FROM order_products_prior
    GROUP BY order_id

)


-- Average and median basket size

SELECT
    ROUND(AVG(items_in_order)::numeric, 2) AS avg_items_per_order,
    PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY items_in_order)
        AS median_items_per_order
FROM basket_sizes;



-- Distribution of basket sizes

SELECT
    items_in_order,
    COUNT(*) AS number_of_orders
FROM basket_sizes
GROUP BY items_in_order
ORDER BY items_in_order;


/*
Insight

Instacart orders are relatively small.

The median basket size is **8 items**, while the average basket
size is slightly higher at **10 items** due to a small number of
large orders.

The distribution peaks around **5–7 items**, indicating that most
customers place relatively small, routine grocery orders rather
than large bulk purchases.
*/
