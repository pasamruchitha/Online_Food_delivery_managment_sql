#  Food Delivery Management System

---

## Description

The ** Food Delivery Management System** is a robust relational database project designed and developed using **MySQL 8.0**. It models the core operations of on-demand food delivery platforms like Swiggy and Zomato, managing customers, partner restaurants, food menus, delivery personnel, customer orders, order line items, and payment transactions.

The database is structured in **Third Normal Form (3NF)** to ensure referential integrity, eliminate data redundancy, and support both high-throughput daily transactions and complex analytical queries for business decision-making.

---

## Features

* **Customer Management**: Stores customer profiles, unique contact numbers, verified emails, and delivery addresses.
* **Restaurant & Menu Catalog**: Tracks partner restaurants across various locations and maps food items with real-time pricing.
* **Order Lifecycle & Tracking**: Records order placements, totals, order dates, and live status (`Placed`, `Preparing`, `Out for Delivery`, `Delivered`).
* **Itemized Order Billing**: Tracks individual food items, quantities, and item subtotals within each order.
* **Delivery Fleet Coordination**: Assigns delivery partners to specific orders for fulfillment and contact tracking.
* **Secure Payment Processing**: Handles multiple payment modes (`UPI`, `Card`, `Cash`) with payment status verification (`Successful`, `Pending`) in a strict 1:1 relationship with orders.
* **Advanced Business Analytics**:
  * Multi-table `INNER JOIN` and `LEFT JOIN` operations.
  * Scalar and correlated subqueries.
  * Analytical Window Functions (`RANK() OVER`, `AVG() OVER (PARTITION BY)`).
* **Database Views**: Pre-built modular views for order tracking, restaurant revenue performance, delivery contact logs, and high-value orders.
* **Stored Procedures**: Parameterized routines for customer spending lookup, restaurant order counts, order history, and dish sales metrics.
* **Built-in SQL Functions**: String formatting, mathematical discount calculations, date/time extraction, and cumulative running revenue metrics.

---

## Technologies Used

* **Database Engine**: MySQL Server 8.0
* **Query Language**: Structured Query Language (SQL - ANSI compliant, MySQL dialect)
* **Development Environment**: Visual Studio Code
* **Database Client / Extension**: SQLTools with SQLTools MySQL/MariaDB Driver
* **Database Modeling Tool**: MySQL Workbench (ER Diagram Design)
* **Version Control**: Git & GitHub
* **Operating System**: Windows 11

---

## Database Structure

### Entity Relationship (ER) Model
The schema consists of 7 normalized relational tables:

```text
 [customers] 1 ────< N [orders] N >──── 1 [restaurants]
                         │   │                      │
                         │   └─── 1 >─── N [order_items] N ───< 1 [food_items]
                         │
                         ├─── N >─── 1 [delivery_persons]
                         │
                         └─── 1 ──── 1 [payments]
```

* **Visual Diagram**: Available in [`Documentation/ER_diagram_MYSql.png`](file:///c:/Users/Ruchitha/Desktop/sql/Documentation/ER_diagram_MYSql.png)
* **Workbench Source Model**: Available in [`Documentation/ER_diagram.mwb`](file:///c:/Users/Ruchitha/Desktop/sql/Documentation/ER_diagram.mwb)

---

### Tables and Constraints (Data Dictionary)

#### 1. `customers`
| Column Name | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `customer_id` | INT | PRIMARY KEY | Unique customer identifier |
| `customer_name` | VARCHAR(100) | NOT NULL | Customer full name |
| `phone` | VARCHAR(15) | UNIQUE | Contact phone number |
| `email` | VARCHAR(100) | UNIQUE | Customer email address |
| `address` | VARCHAR(200) | NULLABLE | Primary delivery address |

#### 2. `restaurants`
| Column Name | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `restaurant_id` | INT | PRIMARY KEY, AUTO_INCREMENT | Unique restaurant identifier |
| `restaurant_name` | VARCHAR(100) | NOT NULL | Outlet name |
| `location` | VARCHAR(100) | NULLABLE | City / Neighborhood area |
| `phone` | VARCHAR(15) | NULLABLE | Restaurant contact number |

#### 3. `food_items`
| Column Name | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `food_id` | INT | PRIMARY KEY | Unique food item SKU |
| `restaurant_id` | INT | NOT NULL, FK ➔ `restaurants` | Restaurant offering the dish |
| `food_name` | VARCHAR(100) | NOT NULL | Name of the dish |
| `price` | DECIMAL(10,2)| NOT NULL | Price in INR (₹) |

#### 4. `delivery_persons`
| Column Name | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `delivery_person_id`| INT | PRIMARY KEY | Unique delivery partner ID |
| `person_name` | VARCHAR(100) | NOT NULL | Partner name |
| `phone` | VARCHAR(15) | NULLABLE | Contact mobile number |

#### 5. `orders`
| Column Name | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `order_id` | INT | PRIMARY KEY, AUTO_INCREMENT | Unique order tracking number |
| `customer_id` | INT | NOT NULL, FK ➔ `customers` | Ordering customer reference |
| `restaurant_id` | INT | NOT NULL, FK ➔ `restaurants` | Fulfilling restaurant reference |
| `delivery_person_id`| INT | NULLABLE, FK ➔ `delivery_persons` | Assigned delivery personnel |
| `order_date` | DATE | NULLABLE | Date order was placed |
| `total_amount` | DECIMAL(10,2)| NOT NULL | Total bill amount in INR (₹) |
| `order_status` | VARCHAR(30) | NULLABLE | Order state (`Delivered`, etc.) |

#### 6. `order_items`
| Column Name | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `order_item_id` | INT | PRIMARY KEY | Unique item line ID |
| `order_id` | INT | NOT NULL, FK ➔ `orders` | Parent order reference |
| `food_id` | INT | NOT NULL, FK ➔ `food_items` | Ordered food item reference |
| `quantity` | INT | NOT NULL | Number of units ordered |
| `price` | DECIMAL(10,2)| NOT NULL | Subtotal price for the units |

#### 7. `payments`
| Column Name | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `payment_id` | INT | PRIMARY KEY | Unique transaction receipt ID |
| `order_id` | INT | UNIQUE, NOT NULL, FK ➔ `orders` | Paid order ID (1:1 relationship) |
| `amount` | DECIMAL(10,2)| NOT NULL | Total amount paid |
| `payment_method` | VARCHAR(30) | NULLABLE | Payment mode (`UPI`, `Card`, `Cash`) |
| `payment_status` | VARCHAR(30) | NULLABLE | Settlement state (`Successful`, `Pending`) |

---

## Installation Steps

### 1. Install Prerequisites
* Install **MySQL Server 8.0+** and **MySQL Workbench** on your machine.
* Install **Visual Studio Code**.
* In VS Code, install the **SQLTools** extension and the **SQLTools MySQL/MariaDB** driver.

### 2. Verify MySQL Service
Ensure the local MySQL service is running on port `3306`:
```powershell
# In PowerShell:
Get-Service -Name *mysql*
```

### 3. Open the Workspace in VS Code
Open the project directory in VS Code:
```text
File -> Open Folder -> Select the 'sql' directory
```

### 4. Connect VS Code to MySQL
The connection profile is pre-configured in `.vscode/settings.json`:
* Click the **SQLTools** icon on the left sidebar.
* Click **`mysql local`**.
* Enter your MySQL `root` password when prompted.

---

## How to Execute SQL Files

To respect foreign key dependencies, execute the SQL files in this exact sequential order:

### Execution Order:
1. **`database/create_databse.sql`**: Creates and initializes `food_delivery_db`.
2. **`database/create_tables.sql`**: Creates all 7 relational tables with primary and foreign keys.
3. **`database/insert_values.sql`**: Seeds all tables with realistic sample data.
4. **`database/queries.sql`**: Runs business analytics queries.
5. **`database/Functions.sql`**: Tests string, numeric, date, and window functions.
6. **`database/views.sql`**: Creates modular views and queries against views.
7. **`database/procedures.sql`**: Creates and calls stored procedures.

---

### Execution Method A: Using VS Code Terminal (Recommended)
Open the integrated terminal in VS Code (`Ctrl + ` `~`):

```powershell
# 1. Start MySQL interactive terminal:
& "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -p

# 2. Enter your MySQL password when prompted.

# 3. Run the scripts in order:
source database/create_databse.sql;
source database/create_tables.sql;
source database/insert_values.sql;
source database/queries.sql;
source database/Functions.sql;
source database/views.sql;
source database/procedures.sql;
```

---

### Execution Method B: Using VS Code SQLTools Display
1. Open any `.sql` file (e.g. `queries.sql`).
2. Highlight the query you want to run.
3. Right-click the highlighted code and click **`Run Selected Query`** (or press `Ctrl + E, Ctrl + E`).
4. The interactive tabular results will render in the visual results panel on your screen.

---

## Sample Queries

### 1. Total Customer Spending (Handling 0 Orders with NULL-safety)
```sql
SELECT
    c.customer_name,
    IFNULL(SUM(o.total_amount), 0) AS total_spending
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;
```
**Output:**
| customer_name | total_spending |
| :--- | :--- |
| Rahul | 1000.00 |
| Priya | 280.00 |
| Kiran | 320.00 |
| Sneha | 360.00 |
| Arun | 520.00 |

---

### 2. High-Value Customer Orders (> ₹300) with Restaurant Names
```sql
SELECT
    c.customer_name,
    r.restaurant_name,
    o.total_amount,
    o.order_date
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN restaurants r
    ON o.restaurant_id = r.restaurant_id
WHERE o.total_amount > 300
ORDER BY o.total_amount DESC;
```
**Output:**
| customer_name | restaurant_name | total_amount | order_date |
| :--- | :--- | :--- | :--- |
| Arun | Pista House | 520.00 | 2026-11-03 |
| Rahul | Paradise | 500.00 | 2026-11-01 |
| Rahul | Bawarchi | 500.00 | 2026-11-02 |
| Sneha | Paradise | 360.00 | 2026-11-03 |
| Kiran | Pista House | 320.00 | 2026-11-02 |

---

### 3. Food Items Priced Higher Than the Menu Average
```sql
SELECT
    r.restaurant_name,
    f.food_name,
    f.price
FROM restaurants r
INNER JOIN food_items f
    ON r.restaurant_id = f.restaurant_id
WHERE f.price > (
    SELECT AVG(price)
    FROM food_items
)
ORDER BY f.price DESC;
```
**Output:**
| restaurant_name | food_name | price |
| :--- | :--- | :--- |
| Pista House | Mutton Biryani | 320.00 |
| Bawarchi | Chicken Biryani | 280.00 |
| Paradise | Chicken Biryani | 250.00 |

---

### 4. Ranking Food Items by Price within Each Restaurant (Window Function)
```sql
SELECT
    r.restaurant_name,
    f.food_name,
    f.price,
    RANK() OVER (
        PARTITION BY f.restaurant_id
        ORDER BY f.price DESC
    ) AS food_rank
FROM food_items f
INNER JOIN restaurants r
    ON f.restaurant_id = r.restaurant_id;
```
**Output:**
| restaurant_name | food_name | price | food_rank |
| :--- | :--- | :--- | :--- |
| Paradise | Chicken Biryani | 250.00 | 1 |
| Paradise | Veg Biryani | 180.00 | 2 |
| Bawarchi | Chicken Biryani | 280.00 | 1 |
| Bawarchi | Paneer Biryani | 220.00 | 2 |
| Pista House | Mutton Biryani | 320.00 | 1 |
| Pista House | Chicken 65 | 200.00 | 2 |

---

### 5. Running Stored Procedures
```sql
-- Retrieve all orders for customer ID 1 (Rahul):
CALL get_customer_orders(1);

-- Calculate total spending for customer ID 1:
CALL get_customer_spending(1);

-- View all payments made via UPI:
CALL get_payments_by_method('UPI');

-- Count total orders received by restaurant 101 (Paradise):
CALL count_restaurant_orders(101);

-- Check total quantity sold for food item 201 (Chicken Biryani):
CALL get_food_quantity(201);
```

---

## Future Enhancements

1. **Rating and Reviews Module**: Implement a reviews table allowing customers to rate both the restaurant food quality and delivery service on a 1-to-5 star scale.
2. **Promotions, Coupons, and Discounts**: Create dedicated tables for promo codes (`SUMMER50`, `WELCOME`) with expiration dates, minimum order values, and max discount caps.
3. **Live Geolocation & Routing**: Integrate GPS coordinates (`latitude`, `longitude`) for customers, restaurants, and drivers to compute real-time delivery distances and optimal routes.
4. **Driver Commission & Payout Tracking**: Automate calculation of platform commissions (e.g. 20% platform fee, 80% restaurant payout) and delivery partner tips/wages.
5. **Database Triggers**: Add automated triggers to update order timestamps upon delivery, deduct inventory levels, and auto-generate invoice records.
6. **Full-Stack Application Integration**: Connect the database with a backend REST API (using Node.js/Express, Python/FastAPI, or Java/Spring Boot) and a frontend mobile/web client.
