USE food_delivery_db;

-- =====================================================================
-- 1. Procedure: Display all orders placed by a specific customer
-- =====================================================================
DROP PROCEDURE IF EXISTS get_customer_orders;

DELIMITER //
CREATE PROCEDURE get_customer_orders(IN cust_id INT)
BEGIN
    SELECT *
    FROM orders
    WHERE customer_id = cust_id;
END //
DELIMITER ;

CALL get_customer_orders(1);


-- =====================================================================
-- 2. Procedure: Calculate total amount spent by a specific customer
-- =====================================================================
DROP PROCEDURE IF EXISTS get_customer_spending;

DELIMITER //
CREATE PROCEDURE get_customer_spending(IN cust_id INT)
BEGIN
    SELECT
        c.customer_name,
        IFNULL(SUM(o.total_amount), 0) AS total_spending
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE c.customer_id = cust_id
    GROUP BY c.customer_id, c.customer_name;
END //
DELIMITER ;

CALL get_customer_spending(1);


-- =====================================================================
-- 3. Procedure: Display all payments made using a specific method
-- =====================================================================
DROP PROCEDURE IF EXISTS get_payments_by_method;

DELIMITER //
CREATE PROCEDURE get_payments_by_method(IN method_name VARCHAR(30))
BEGIN
    SELECT *
    FROM payments
    WHERE payment_method = method_name;
END //
DELIMITER ;

CALL get_payments_by_method('UPI');


-- =====================================================================
-- 4. Procedure: Total number of orders received by a specific restaurant
-- =====================================================================
DROP PROCEDURE IF EXISTS count_restaurant_orders;

DELIMITER //
CREATE PROCEDURE count_restaurant_orders(IN rest_id INT)
BEGIN
    SELECT
        r.restaurant_name,
        COUNT(o.order_id) AS total_orders
    FROM restaurants r
    LEFT JOIN orders o
        ON r.restaurant_id = o.restaurant_id
    WHERE r.restaurant_id = rest_id
    GROUP BY r.restaurant_id, r.restaurant_name;
END //
DELIMITER ;

CALL count_restaurant_orders(101);


-- =====================================================================
-- 5. Procedure: Total quantity of a specific food item ordered
-- =====================================================================
DROP PROCEDURE IF EXISTS get_food_quantity;

DELIMITER //
CREATE PROCEDURE get_food_quantity(IN item_id INT)
BEGIN
    SELECT
        f.food_name,
        IFNULL(SUM(oi.quantity), 0) AS total_quantity
    FROM food_items f
    LEFT JOIN order_items oi
        ON f.food_id = oi.food_id
    WHERE f.food_id = item_id
    GROUP BY f.food_id, f.food_name;
END //
DELIMITER ;

CALL get_food_quantity(201);
