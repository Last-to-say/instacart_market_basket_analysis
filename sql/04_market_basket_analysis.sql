/* =====================================================
4. MARKET BASKET ANALYSIS (ASSOCIATION / LIFT)
===================================================== */

/*
Business Question

Which products are frequently purchased together?

Market basket analysis identifies product associations
using co-occurrence within the same order and evaluates
their strength using support, confidence, and lift metrics.
*/


WITH popular_products AS (

    SELECT
        op.product_id,
        COUNT(*) AS total_orders
    FROM order_products_prior op
    GROUP BY op.product_id
    ORDER BY total_orders DESC
    LIMIT 100

),

filtered_orders AS (

    SELECT
        op.order_id,
        op.product_id
    FROM order_products_prior op
    JOIN popular_products pp
        ON op.product_id = pp.product_id

),

order_pairs AS (

    SELECT
        f1.product_id AS product_1,
        f2.product_id AS product_2,
        COUNT(*) AS times_bought_together
    FROM filtered_orders f1
    JOIN filtered_orders f2
        ON f1.order_id = f2.order_id
    WHERE f1.product_id < f2.product_id
    GROUP BY
        f1.product_id,
        f2.product_id

),

product_orders AS (

    SELECT
        product_id,
        COUNT(DISTINCT order_id) AS orders_with_product
    FROM filtered_orders
    GROUP BY product_id

),

total_orders AS (

    SELECT COUNT(*) AS total_orders
    FROM orders

),

product_affinity AS (

    SELECT
        op.product_1,
        op.product_2,
        op.times_bought_together,
        pa.orders_with_product AS orders_product_1,
        pb.orders_with_product AS orders_product_2,
        t.total_orders,

        op.times_bought_together::numeric / t.total_orders AS support,

        op.times_bought_together::numeric / pa.orders_with_product
        AS confidence_a_to_b,

        op.times_bought_together::numeric / pb.orders_with_product
        AS confidence_b_to_a,

        (op.times_bought_together * t.total_orders::numeric) /
        (pa.orders_with_product * pb.orders_with_product)
        AS lift

    FROM order_pairs op
    JOIN product_orders pa
        ON op.product_1 = pa.product_id
    JOIN product_orders pb
        ON op.product_2 = pb.product_id
    CROSS JOIN total_orders t

)

SELECT
    p1.product_name AS if_customer_buys,
    p2.product_name AS recommend_product,
    pa.confidence_a_to_b,
    pa.lift,
    pa.support
FROM product_affinity pa
JOIN products p1
    ON pa.product_1 = p1.product_id
JOIN products p2
    ON pa.product_2 = p2.product_id
WHERE
    pa.support > 0.001
    AND pa.confidence_a_to_b > 0.05
    AND pa.lift > 1
ORDER BY pa.confidence_a_to_b DESC;


/*
Insight

Lift analysis reveals that strong product associations
often occur between flavor variants and complementary
fresh ingredients.

For example, different sparkling water flavors show
very high association scores, indicating that customers
frequently purchase multiple variants together.

Similarly, produce items such as peppers and herbs
appear together in baskets, suggesting recipe-driven
shopping behavior.
*/
