use food_delivery_db;
-- Display customer names in uppercase, lowercase, their length, first three and last three characters.
SELECT
    customer_id,
    UPPER(customer_name) AS uppercase_name,
    LOWER(customer_name) AS lowercase_name,
    LENGTH(customer_name) AS name_length,
    LEFT(customer_name, 3) AS first_three,
    RIGHT(customer_name, 3) AS last_three
FROM customers;
-- Display food names in uppercase, their rounded prices, 10% discount, final price, absolute price difference from ₹100, and rank based on original price.
SELECT
    food_id,
    UPPER(food_name) AS food_name,
    LENGTH(food_name) AS name_length,
    ROUND(price, 2) AS original_price,
    ROUND(price * 0.10, 2) AS discount,
    ROUND(price * 0.90, 2) AS final_price,
    ABS(price - 100) AS price_difference,
    DENSE_RANK() OVER(
        ORDER BY price DESC
    ) AS price_rank
FROM food_items;
-- Display running revenue and running average of order amounts.
SELECT
    order_id,
    total_amount,
    SUM(total_amount) OVER(ORDER BY order_id) AS running_revenue,
    ROUND(AVG(total_amount) OVER(ORDER BY order_id), 2) AS running_average
FROM orders;
-- Display customer names in uppercase and lowercase, their name length, first three characters, last three characters and the position of letter 'a'. Sort by name length.
SELECT
    customer_id,
    UPPER(customer_name) AS uppercase_name,
    LOWER(customer_name) AS lowercase_name,
    LENGTH(customer_name) AS name_length,
    LEFT(customer_name, 3) AS first_three,
    RIGHT(customer_name, 3) AS last_three,
    INSTR(LOWER(customer_name), 'a') AS a_position
FROM customers
ORDER BY name_length DESC;
-- Display order date in year, month and day formats along with rounded order amount.
SELECT
    order_id,
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    MONTHNAME(order_date) AS month_name,
    DAY(order_date) AS order_day,
    ROUND(total_amount, 2) AS order_amount
FROM orders;
-- 