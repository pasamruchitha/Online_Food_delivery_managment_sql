use food_delivery_db;

-- 1. Customer Order Summary View

CREATE VIEW customer_order_summary AS
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_date,
    o.total_amount,
    o.order_status
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id;

SELECT * FROM customer_order_summary;


-- 2. Restaurant Performance View

CREATE VIEW restaurant_performance AS
SELECT
    r.restaurant_id,
    r.restaurant_name,
    COUNT(o.order_id) AS total_orders,
    IFNULL(SUM(o.total_amount), 0) AS total_revenue
FROM restaurants r
LEFT JOIN orders o
    ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name;

SELECT * FROM restaurant_performance;


-- 3. Delivery Person Contact View

CREATE VIEW delivery_contact_view AS
SELECT
    d.person_name,
    d.phone,
    o.order_id,
    o.order_status
FROM delivery_persons d
INNER JOIN orders o
    ON d.delivery_person_id = o.delivery_person_id;

SELECT * FROM delivery_contact_view;


-- 4. High Value Orders View

CREATE VIEW high_value_orders AS
SELECT
    o.order_id,
    c.customer_name,
    o.total_amount,
    o.order_status
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.total_amount > 400;

SELECT * FROM high_value_orders;


-- =====================================================================
-- Queries using Views
-- =====================================================================

-- Query 1: Display customer names and their high-value order amounts.
SELECT
    c.customer_name,
    h.order_id,
    h.total_amount
FROM customer_order_summary c
INNER JOIN high_value_orders h
    ON c.order_id = h.order_id;

-- Query 2: Display delivery persons who handled more than one order.
SELECT
    person_name,
    COUNT(order_id) AS total_orders
FROM delivery_contact_view
GROUP BY person_name
HAVING COUNT(order_id) > 1;

-- Query 3: Display restaurant names along with their total revenue and order count.
FROM customer_order_summary
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM customer_order_summary
);
