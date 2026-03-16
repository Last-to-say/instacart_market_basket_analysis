/* =====================================================
2. ORDER BEHAVIOR ANALYSIS
===================================================== */

/*
Business Question
When do customers place the most orders during the day?
*/

SELECT
    order_hour_of_day,
    COUNT(order_id) AS total_orders,
    ROUND(
        COUNT(order_id)::numeric /
        SUM(COUNT(order_id)) OVER () * 100,
        2
    ) AS order_share_pct
FROM orders
GROUP BY order_hour_of_day
ORDER BY order_hour_of_day;


/*
Insight

Orders peak during late morning and early afternoon,
with the highest activity between 10 AM and 3 PM.
*/
