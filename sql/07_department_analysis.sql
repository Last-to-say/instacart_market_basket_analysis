/* =====================================================
7. DEPARTMENT ANALYSIS
===================================================== */

/*
Business Question

Which product departments generate the largest share
of purchases on the Instacart platform?

This helps identify which grocery categories drive
the majority of demand.
*/

SELECT
    d.department,
    COUNT(*) AS items_sold,
    ROUND(
        COUNT(*)::numeric /
        SUM(COUNT(*)) OVER () * 100,
        2
    ) AS purchase_share_pct
FROM order_products_prior op
JOIN products p
    ON op.product_id = p.product_id
JOIN departments d
    ON p.department_id = d.department_id
GROUP BY d.department
ORDER BY purchase_share_pct DESC;


/*
Insight

Produce is by far the most frequently ordered department,
representing the largest share of items in customer baskets.

This aligns with earlier findings where fresh fruits and
vegetables dominated the top ordered products. The result
suggests that fresh produce acts as a primary driver of
grocery demand on the Instacart platform.

Departments such as dairy & eggs, snacks, and beverages
also show high purchase volumes, indicating that these
categories frequently appear in everyday grocery baskets.
*/
