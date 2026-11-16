use food_delivery_db;

-- The business team wants to display all customers and their total spending. If a customer has not placed any orders, display 0 instead of NULL.
 
select
    c.customer_name,
    IFNULL(SUM(o.total_amount), 0) as total_spending
from customers c
left join orders o
    on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name;

-- The finance team wants to display payment amounts. If any payment amount is NULL, display 0 instead. Sort by payment amount in descending order.

select
    payment_id,
    order_id,
    ifnull(amount, 0) as payment_amount
from payments
order by payment_amount desc;

-- The management wants to identify customers who placed orders worth more than ₹300. Display customer name, restaurant name, order amount, and order date. Sort by order amount from highest to lowest.
select    c.customer_name,
    r.restaurant_name,
    o.total_amount,
    o.order_date
from customers c
inner join orders o
    on c.customer_id = o.customer_id
inner join restaurants r
    on o.restaurant_id = r.restaurant_id
where o.total_amount > 300
order by  o.total_amount DESC;

-- Management wants to identify food items whose prices are higher than the average price of all food items. Display restaurant name, food name, and price. Sort by price in descending order

select
    r.restaurant_name,
    f.food_name,
    f.price
from restaurants r
inner join food_items f
    on r.restaurant_id = f.restaurant_id
WHERE f.price > (
    select avg(price)
    from food_items
)
order by  f.price desc;
-- The restaurant management wants to identify food items whose total ordered quantity is greater than the average total quantity sold per food item. Display food names and total quantities.

select
    f.food_name,
    sum(oi.quantity) as total_quantity
from food_items f
inner join order_items oi
    on f.food_id = oi.food_id
GROUP BY f.food_id, f.food_name
HAVING sum(oi.quantity) > (
    select avg(food_quantity)
    from (
        select sum(quantity) as food_quantity
        from order_items
        group by food_id
    ) as food_sales
)
order by  total_quantity DESC;

-- The management wants to know the average order amount for each customer. Display customer name, order ID, order amount, and average order amount.

select
    c.customer_name,
    o.order_id,
    o.total_amount,
    avg(o.total_amount) over(
        partition  by c.customer_id
    ) AS average_amount
from customers c
inner join orders o
    on c.customer_id = o.customer_id;
    
-- Assign a rank to each food item based on its price within its restaurant.

select
    r.restaurant_name,
    f.food_name,
    f.price,
    rank() over (
        partition by f.restaurant_id
       order by  f.price DESC
    ) AS food_rank
from food_items f
inner join restaurants r
    on f.restaurant_id = r.restaurant_id;