/* =====================================================
5. REORDER BEHAVIOR
===================================================== */

/*
Business Question

How frequently do customers place repeat orders?

Understanding reorder intervals helps identify typical
shopping cycles and customer purchasing patterns.
*/


-- Distribution of days between orders

SELECT
    days_since_prior_order,
    COUNT(*) AS order_count
FROM orders
WHERE days_since_prior_order IS NOT NULL
GROUP BY days_since_prior_order
ORDER BY days_since_prior_order;


-- Average and median reorder interval

SELECT
    ROUND(AVG(days_since_prior_order)::numeric, 2) AS avg_days_between_orders,
    PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY days_since_prior_order)
    AS median_days_between_orders
FROM orders
WHERE days_since_prior_order IS NOT NULL;


/*
Insight

Customer reorder behavior shows a strong weekly shopping cycle.

The distribution of `days_since_prior_order` peaks at **7 days**,
indicating many customers place grocery orders approximately
once per week.

Another visible cluster appears at **30 days**, representing
customers with monthly or irregular shopping intervals.
This bucket includes all orders occurring **30 days or more**
after the previous order due to dataset limitations.

The median reorder interval confirms that the typical
customer shops roughly once per week.
*/
