use food_delivery_db;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    address VARCHAR(200)
);
CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY auto_increment,
    restaurant_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    phone VARCHAR(15)
);
CREATE TABLE food_items (
    food_id INT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    food_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (restaurant_id)
    REFERENCES restaurants(restaurant_id)
);
CREATE TABLE delivery_persons (
    delivery_person_id INT PRIMARY KEY,
    person_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15)
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY auto_increment,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    delivery_person_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2) NOT NULL,
    order_status VARCHAR(30),
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id)
    REFERENCES restaurants(restaurant_id),
    FOREIGN KEY (delivery_person_id)
    REFERENCES delivery_persons(delivery_person_id)
);
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    food_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id)
    REFERENCES orders(order_id),
    FOREIGN KEY (food_id)
    REFERENCES food_items(food_id)
);
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT UNIQUE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(30),
    payment_status VARCHAR(30),
    FOREIGN KEY (order_id)
    REFERENCES orders(order_id)
)
