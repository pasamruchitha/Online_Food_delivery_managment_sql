use food_delivery_db;
INSERT INTO customers VALUES
(1,'Rahul','9876543210','rahul@gmail.com','Hyderabad'),
(2,'Priya','9876543211','priya@gmail.com','Secunderabad'),
(3,'Kiran','9876543212','kiran@gmail.com','Kukatpally'),
(4,'Sneha','9876543213','sneha@gmail.com','Miyapur'),
(5,'Arun','9876543214','arun@gmail.com','Gachibowli');


INSERT INTO restaurants VALUES
(101,'Paradise','Hyderabad','9000011111'),
(102,'Bawarchi','RTC Cross Roads','9000022222'),
(103,'Pista House','Charminar','9000033333');



INSERT INTO food_items VALUES
(201,101,'Chicken Biryani',250),
(202,101,'Veg Biryani',180),
(203,102,'Chicken Biryani',280),
(204,102,'Paneer Biryani',220),
(205,103,'Mutton Biryani',320),
(206,103,'Chicken 65',200);

INSERT INTO delivery_persons VALUES
(301,'Ramesh','9111111111'),
(302,'Suresh','9222222222'),
(303,'Mahesh','9333333333');


INSERT INTO orders VALUES
(401,1,101,301,'2026-11-01',500,'Delivered'),
(402,2,102,302,'2026-11-01',280,'Delivered'),
(403,3,103,303,'2026-11-02',320,'Out for Delivery'),
(404,1,102,301,'2026-11-02',500,'Preparing'),
(405,4,101,302,'2026-11-03',360,'Placed'),
(406,5,103,303,'2026-11-03',520,'Delivered');
INSERT INTO order_items VALUES
(501,401,201,2,250),
(502,402,203,1,280),
(503,403,205,1,320),
(504,404,203,1,280),
(505,404,204,1,220),
(506,405,202,2,180),
(507,406,205,1,320),
(508,406,206,1,200);

INSERT INTO payments VALUES
(601,401,500,'UPI','Successful'),
(602,402,280,'Card','Successful'),
(603,403,320,'UPI','Successful'),
(604,404,500,'Cash','Pending'),
(605,405,360,'UPI','Pending'),
(606,406,520,'Card','Successful');



SELECT * FROM customers;
SELECT * FROM restaurants;
SELECT * FROM food_items;
SELECT * FROM delivery_persons;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM payments;
select*from orders;