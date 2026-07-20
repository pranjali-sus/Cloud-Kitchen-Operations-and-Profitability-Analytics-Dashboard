CREATE DATABASE CloudKitchen;
USE CloudKitchen;

SELECT COUNT(*) AS total_rows FROM sales;
SELECT COUNT(*) AS total_rows FROM food_recipe;
SELECT COUNT(*) AS total_rows FROM production_recipe;

DESCRIBE sales;
DESCRIBE food_recipe;
DESCRIBE production_recipe;

SELECT * FROM sales LIMIT 10;
SELECT * FROM food_recipe LIMIT 10;
SELECT * FROM production_recipe LIMIT 10;

ALTER TABLE sales 
RENAME COLUMN `ï»¿Restaurant Name` TO Restaurant_Name,
RENAME COLUMN `System Date` TO System_Date,
RENAME COLUMN `Order Type` TO Order_Type,
RENAME COLUMN `Sales Channle` TO Sales_Channel,
RENAME COLUMN `Order No` TO Order_No,
RENAME COLUMN `Customer Name` TO Customer_Name,
RENAME COLUMN `Order Start Time` TO Order_Start_Time,
RENAME COLUMN `Order End Time` TO Order_End_Time,
RENAME COLUMN `Food ID` TO Food_ID,
RENAME COLUMN `KSOP Reciepe Name` TO Recipe_Name,
RENAME COLUMN `Food Name` TO Food_Name,
RENAME COLUMN `Food Category` TO Food_Category,
RENAME COLUMN `Net Price` TO Net_Price,
RENAME COLUMN `Total Discount Price` TO Total_Discount_Price,
RENAME COLUMN `Tax Price` TO Tax_Price,
RENAME COLUMN `Total Price` TO Total_Price,
RENAME COLUMN `Food Cost` TO Food_Cost;

ALTER TABLE food_recipe
RENAME COLUMN `Food Name` TO Food_Name,
RENAME COLUMN `Food Name_[0]` TO Restaurant_Name;

ALTER TABLE production_recipe
RENAME COLUMN `Production Food Name` TO Production_Food_Name,
RENAME COLUMN `Ingredians` TO Ingredients;

SELECT COUNT(DISTINCT Restaurant_Name) AS Restaurants FROM sales;
SELECT COUNT(DISTINCT Sales_Channel) AS Sales_Channels FROM sales;
SELECT COUNT(DISTINCT Order_Type) AS Order_Types FROM sales;
SELECT COUNT(DISTINCT Food_Category) AS Food_Categories FROM sales;
SELECT COUNT(DISTINCT FoodTypeName) AS Food_Types FROM sales;
SELECT COUNT(DISTINCT Food_Name) AS Food_Items FROM sales;
SELECT COUNT(DISTINCT Recipe_Name) AS Recipes FROM sales;
SELECT COUNT(DISTINCT Customer_Name) AS Customers FROM sales;
SELECT COUNT(DISTINCT Food_ID) AS Food_IDs FROM sales;
SELECT COUNT(DISTINCT Food_Name) AS Foods FROM food_recipe;
SELECT COUNT(DISTINCT Restaurant_Name) AS Restaurants FROM food_recipe;
SELECT COUNT(DISTINCT Ingredients) AS Ingredients FROM food_recipe;
SELECT COUNT(DISTINCT Production_Food_Name) AS Production_Foods FROM production_recipe;
SELECT COUNT(DISTINCT Ingredients) AS Ingredients FROM production_recipe;

SELECT DISTINCT Restaurant_Name FROM sales;
SELECT DISTINCT Restaurant_Name FROM food_recipe LIMIT 30;

SELECT * FROM food_recipe LIMIT 20;
SELECT * FROM sales LIMIT 20;

ALTER TABLE food_recipe RENAME COLUMN Restaurant_Name TO Brand_Name;

SELECT
SUM(Restaurant_Name IS NULL) AS Restaurant_Name,
SUM(System_Date IS NULL) AS System_Date,
SUM(Order_Type IS NULL) AS Order_Type,
SUM(Sales_Channel IS NULL) AS Sales_Channel,
SUM(Order_No IS NULL) AS Order_No,
SUM(Customer_Name IS NULL) AS Customer_Name,
SUM(Order_Start_Time IS NULL) AS Order_Start_Time,
SUM(Order_End_Time IS NULL) AS Order_End_Time,
SUM(Food_ID IS NULL) AS Food_ID,
SUM(Recipe_Name IS NULL) AS Recipe_Name,
SUM(Food_Name IS NULL) AS Food_Name,
SUM(Quantity IS NULL) AS Quantity,
SUM(Food_Category IS NULL) AS Food_Category,
SUM(FoodTypeName IS NULL) AS Brand_Name,
SUM(Net_Price IS NULL) AS Net_Price,
SUM(Total_Discount_Price IS NULL) AS Total_Discount_Price,
SUM(Tax_Price IS NULL) AS Tax_Price,
SUM(Total_Price IS NULL) AS Total_Price,
SUM(Food_Cost IS NULL) AS Food_Cost
FROM sales;

SELECT
SUM(Food_Name IS NULL),
SUM(Brand_Name IS NULL),
SUM(Ingredients IS NULL),
SUM(Quantity IS NULL)
FROM food_recipe;

SELECT
SUM(Production_Food_Name IS NULL),
SUM(Ingredients IS NULL),
SUM(Quantity IS NULL)
FROM production_recipe;

SELECT COUNT(*) AS Total_Rows,
COUNT(DISTINCT CONCAT_WS('|', Restaurant_Name,System_Date,Order_No,Food_ID)) AS Unique_Rows
FROM sales;

SELECT COUNT(*) AS Total_Rows,
COUNT(DISTINCT CONCAT_WS('|', Food_Name,Brand_Name,Ingredients,Quantity)) AS Unique_Rows
FROM food_recipe;

SELECT COUNT(*) AS Total_Rows,
COUNT(DISTINCT CONCAT_WS('|', Production_Food_Name,Ingredients,Quantity)) AS Unique_Rows
FROM production_recipe;

SELECT Restaurant_Name, System_Date, Order_No, Food_ID, COUNT(*) AS Duplicate_Count
FROM sales
GROUP BY Restaurant_Name, System_Date, Order_No, Food_ID
HAVING COUNT(*) > 1
LIMIT 20;

SELECT * FROM sales
WHERE Order_No = 12554121
AND Food_ID = 1010;

UPDATE sales
SET Net_Price = TRIM(REPLACE(Net_Price, '$', '')),
    Total_Discount_Price = TRIM(REPLACE(Total_Discount_Price, '$', '')),
    Tax_Price = TRIM(REPLACE(Tax_Price, '$', '')),
    Total_Price = TRIM(REPLACE(Total_Price, '$', '')),
    Food_Cost = TRIM(REPLACE(Food_Cost, '$', ''));

UPDATE sales
SET Total_Discount_Price = '0'
WHERE Total_Discount_Price IN ('-', '');

SELECT Net_Price, Total_Discount_Price, Tax_Price, Total_Price, Food_Cost
FROM sales
LIMIT 10;

UPDATE sales
SET System_Date = STR_TO_DATE(System_Date, '%d-%m-%Y');

ALTER TABLE sales
MODIFY COLUMN System_Date DATE;

SELECT System_Date FROM sales LIMIT 10;

SHOW COLUMNS FROM sales LIKE 'System_Date';

SELECT 1;

SHOW VARIABLES LIKE 'wait_timeout';
SHOW VARIABLES LIKE 'interactive_timeout';
SHOW VARIABLES LIKE 'net_read_timeout';
SHOW VARIABLES LIKE 'net_write_timeout';

SELECT COUNT(*) FROM sales;

SHOW PROCESSLIST;

SELECT COUNT(*) FROM food_recipe;

KILL 13;

ALTER TABLE sales
MODIFY COLUMN Order_Start_Time TIME,
MODIFY COLUMN Order_End_Time TIME;

ALTER TABLE sales
MODIFY COLUMN Net_Price DECIMAL(10,2),
MODIFY COLUMN Total_Discount_Price DECIMAL(10,2),
MODIFY COLUMN Tax_Price DECIMAL(10,2),
MODIFY COLUMN Total_Price DECIMAL(10,2),
MODIFY COLUMN Food_Cost DECIMAL(10,2);

SELECT
SUM(Net_Price = '') AS NetPrice_Blank,
SUM(Total_Discount_Price = '') AS Discount_Blank,
SUM(Tax_Price = '') AS Tax_Blank,
SUM(Total_Price = '') AS Total_Blank,
SUM(Food_Cost = '') AS FoodCost_Blank
FROM sales;

UPDATE sales
SET Net_Price = CONCAT('-', REPLACE(REPLACE(Net_Price,'(',''),')',''))
WHERE Net_Price LIKE '(%';

UPDATE sales
SET Tax_Price = CONCAT('-', REPLACE(REPLACE(Tax_Price,'(',''),')',''))
WHERE Tax_Price LIKE '(%';

UPDATE sales
SET Total_Price = CONCAT('-', REPLACE(REPLACE(Total_Price,'(',''),')',''))
WHERE Total_Price LIKE '(%';

SELECT DISTINCT Net_Price FROM sales
WHERE Net_Price NOT REGEXP '^-?[0-9]+(\\.[0-9]+)?$';

SELECT DISTINCT Tax_Price FROM sales
WHERE Tax_Price NOT REGEXP '^-?[0-9]+(\\.[0-9]+)?$';

SELECT DISTINCT Total_Price FROM sales
WHERE Total_Price NOT REGEXP '^-?[0-9]+(\\.[0-9]+)?$';

SELECT DISTINCT Food_Cost FROM sales
WHERE Food_Cost NOT REGEXP '^-?[0-9]+(\\.[0-9]+)?$';

UPDATE sales
SET Net_Price = '0'
WHERE Net_Price = '-';

UPDATE sales
SET Tax_Price = '0'
WHERE Tax_Price = '-';

UPDATE sales
SET Total_Price = '0'
WHERE Total_Price = '-';

ALTER TABLE sales
MODIFY COLUMN Net_Price DECIMAL(10,2),
MODIFY COLUMN Total_Discount_Price DECIMAL(10,2),
MODIFY COLUMN Tax_Price DECIMAL(10,2),
MODIFY COLUMN Total_Price DECIMAL(10,2),
MODIFY COLUMN Food_Cost DECIMAL(10,2);

ALTER TABLE sales
RENAME COLUMN Food_Category TO Brand_Name,
RENAME COLUMN FoodTypeName TO Food_Category;

-- Normalization

CREATE TABLE kitchen_locations AS
SELECT DISTINCT Restaurant_Name AS Location_Name
FROM sales;

ALTER TABLE kitchen_locations
ADD COLUMN Location_ID INT AUTO_INCREMENT PRIMARY KEY FIRST;

CREATE TABLE brands AS
SELECT DISTINCT FoodTypeName AS Brand_Name
FROM sales;

ALTER TABLE brands
ADD COLUMN Brand_ID INT AUTO_INCREMENT PRIMARY KEY FIRST;

CREATE TABLE customers AS
SELECT DISTINCT Customer_Name
FROM sales;

ALTER TABLE customers
ADD COLUMN Customer_ID INT AUTO_INCREMENT PRIMARY KEY FIRST;

CREATE TABLE menu_items AS
SELECT DISTINCT Food_ID, Recipe_Name, Food_Name, Food_Category, FoodTypeName
FROM sales;

ALTER TABLE menu_items
ADD PRIMARY KEY (Food_ID);

ALTER TABLE menu_items
ADD COLUMN Brand_ID INT;

SELECT Food_ID, COUNT(*) AS cnt
FROM menu_items
GROUP BY Food_ID
HAVING COUNT(*) > 1
ORDER BY cnt DESC;

SELECT * FROM menu_items WHERE Food_ID = 1237;

SELECT * FROM sales
WHERE Food_ID = 1237
LIMIT 10;

SELECT Food_ID, Food_Name,
    COUNT(DISTINCT Food_Category) AS Category_Count,
    GROUP_CONCAT(DISTINCT Food_Category ORDER BY Food_Category) AS Categories
FROM menu_items
GROUP BY Food_ID, Food_Name
HAVING COUNT(DISTINCT Food_Category) > 1;

DROP TABLE menu_items;

CREATE TABLE menu_items (
    Menu_Item_ID INT AUTO_INCREMENT PRIMARY KEY,
    Food_ID INT,
    Recipe_Name VARCHAR(100),
    Food_Name VARCHAR(255),
    Food_Category VARCHAR(100),
    FoodTypeName VARCHAR(100)
);

INSERT INTO menu_items
(Food_ID, Recipe_Name, Food_Name, Food_Category, FoodTypeName)
SELECT DISTINCT Food_ID, Recipe_Name, Food_Name, Food_Category, FoodTypeName
FROM sales;

ALTER TABLE menu_items
ADD COLUMN Brand_ID INT;

UPDATE menu_items m JOIN brands b
ON m.FoodTypeName = b.Brand_Name
SET m.Brand_ID = b.Brand_ID;

ALTER TABLE menu_items
DROP COLUMN FoodTypeName;

ALTER TABLE orders
ADD COLUMN Menu_Item_ID INT;

CREATE TABLE orders AS
SELECT
    Order_No,
    System_Date,
    Order_Type,
    Sales_Channel,
    Customer_Name,
    Restaurant_Name,
    Food_ID,
    Recipe_Name,
    Food_Name,
    Food_Category,
    Quantity,
    Net_Price,
    Total_Discount_Price,
    Tax_Price,
    Total_Price,
    Food_Cost,
    Order_Start_Time,
    Order_End_Time
FROM sales;

ALTER TABLE orders
ADD COLUMN Customer_ID INT,
ADD COLUMN Location_ID INT,
ADD COLUMN Menu_Item_ID INT;

UPDATE orders o JOIN customers c
ON o.Customer_Name = c.Customer_Name
SET o.Customer_ID = c.Customer_ID;

KILL 40;

SELECT
    COUNT(*) AS Total,
    SUM(Customer_ID IS NOT NULL) AS Updated
FROM orders;

DROP TABLE orders;

CREATE TABLE orders AS
SELECT
    s.Order_No,
    s.System_Date,
    s.Order_Type,
    s.Sales_Channel,
    c.Customer_ID,
    k.Location_ID,
    m.Menu_Item_ID,
    s.Quantity,
    s.Net_Price,
    s.Total_Discount_Price,
    s.Tax_Price,
    s.Total_Price,
    s.Food_Cost,
    s.Order_Start_Time,
    s.Order_End_Time
FROM sales s
JOIN customers c
    ON s.Customer_Name = c.Customer_Name
JOIN kitchen_locations k
    ON s.Restaurant_Name = k.Location_Name
JOIN menu_items m
    ON s.Food_ID = m.Food_ID
   AND s.Recipe_Name = m.Recipe_Name
   AND s.Food_Name = m.Food_Name
   AND s.Food_Category = m.Food_Category;
   
SELECT COUNT(*) AS Total_Orders FROM orders;

ALTER TABLE orders
ADD COLUMN Order_Item_ID INT AUTO_INCREMENT PRIMARY KEY FIRST;

ALTER TABLE menu_items
ADD CONSTRAINT fk_menu_brand FOREIGN KEY (Brand_ID) REFERENCES brands(Brand_ID);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customer FOREIGN KEY (Customer_ID) REFERENCES customers(Customer_ID);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_location FOREIGN KEY (Location_ID) REFERENCES kitchen_locations(Location_ID);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_menu FOREIGN KEY (Menu_Item_ID) REFERENCES menu_items(Menu_Item_ID);

SHOW TABLES;

SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM brands;
SELECT COUNT(*) FROM kitchen_locations;
SELECT COUNT(*) FROM menu_items;

SELECT Food_ID, Recipe_Name, Food_Name, Food_Category, COUNT(*) AS cnt
FROM menu_items
GROUP BY Food_ID, Recipe_Name, Food_Name, Food_Category
HAVING COUNT(*) > 1;

SELECT * FROM menu_items WHERE Food_ID = 1010;

ALTER TABLE orders
DROP FOREIGN KEY fk_orders_menu;

ALTER TABLE menu_items
DROP FOREIGN KEY fk_menu_brand;

DROP TABLE orders;
DROP TABLE menu_items;
DROP TABLE brands;

CREATE TABLE brands (
    Brand_ID INT AUTO_INCREMENT PRIMARY KEY,
    Brand_Name VARCHAR(100) NOT NULL
);

INSERT INTO brands (Brand_Name)
SELECT DISTINCT Brand_Name
FROM sales
ORDER BY Brand_Name;

SELECT * FROM brands;

DELETE FROM brands
WHERE Brand_ID IS NULL
   OR Brand_Name IS NULL;

CREATE TABLE menu_items (
    Menu_ID INT AUTO_INCREMENT PRIMARY KEY,
    Food_ID INT,
    Recipe_Name VARCHAR(100),
    Food_Name VARCHAR(255),
    Brand_ID INT,
    Food_Category VARCHAR(100),
    CONSTRAINT fk_menu_brand
        FOREIGN KEY (Brand_ID)
        REFERENCES brands(Brand_ID)
);

INSERT INTO menu_items
(
    Food_ID,
    Recipe_Name,
    Food_Name,
    Brand_ID,
    Food_Category
)
SELECT DISTINCT
    s.Food_ID,
    s.Recipe_Name,
    s.Food_Name,
    b.Brand_ID,
    s.Food_Category
FROM sales s
JOIN brands b
ON s.Brand_Name = b.Brand_Name;

SELECT * FROM menu_items;

CREATE TABLE orders
(
    Order_ID INT AUTO_INCREMENT PRIMARY KEY,
    Order_No INT NOT NULL,
    System_Date DATE,
    Order_Type VARCHAR(30),
    Sales_Channel VARCHAR(50),
    Customer_ID INT,
    Location_ID INT,
    Quantity INT,
    Net_Price DECIMAL(10,2),
    Total_Discount_Price DECIMAL(10,2),
    Tax_Price DECIMAL(10,2),
    Total_Price DECIMAL(10,2),
    Food_Cost DECIMAL(10,2),
    Order_Start_Time TIME,
    Order_End_Time TIME,

    CONSTRAINT fk_orders_customer FOREIGN KEY (Customer_ID) REFERENCES customers(Customer_ID),
    CONSTRAINT fk_orders_location FOREIGN KEY (Location_ID) REFERENCES kitchen_locations(Location_ID)
);

INSERT INTO orders
(
    Order_No,
    System_Date,
    Order_Type,
    Sales_Channel,
    Customer_ID,
    Location_ID,
    Quantity,
    Net_Price,
    Total_Discount_Price,
    Tax_Price,
    Total_Price,
    Food_Cost,
    Order_Start_Time,
    Order_End_Time
)

SELECT
s.Order_No,
s.System_Date,
s.Order_Type,
s.Sales_Channel,
c.Customer_ID,
k.Location_ID,
s.Quantity,
s.Net_Price,
s.Total_Discount_Price,
s.Tax_Price,
s.Total_Price,
s.Food_Cost,
s.Order_Start_Time,
s.Order_End_Time
FROM sales s JOIN customers c
ON s.Customer_Name = c.Customer_Name
JOIN kitchen_locations k
ON s.Restaurant_Name = k.Location_Name;

-- Business Overview

-- Total Revenue
SELECT ROUND(SUM(Total_Price),2) AS Total_Revenue FROM sales;

-- Total Orders
SELECT COUNT(DISTINCT Order_No) AS Total_Orders FROM sales;

-- Total Customers
SELECT COUNT(DISTINCT Customer_Name) AS Total_Customers FROM sales;

-- Average Order value
SELECT ROUND(SUM(Total_Price) / COUNT(DISTINCT Order_No), 2) AS Average_Order_Value FROM sales;

-- Total Food Cost
SELECT ROUND(SUM(Food_Cost),2) AS Total_Food_Cost FROM sales;

-- Total Profit
SELECT ROUND(SUM(Total_Price - Food_Cost), 2) AS Total_Profit FROM sales;

-- Profit Margin
SELECT ROUND(SUM(Total_Price - Food_Cost) / SUM(Total_Price) * 100, 2) AS Profit_Margin_Percentage FROM sales;

-- Total Discount Given
SELECT ROUND(SUM(Total_Discount_Price),2) AS Total_Discount FROM sales;

-- Total Tax Collected
SELECT ROUND(SUM(Tax_Price),2) AS Total_Tax FROM sales;

-- Average Items Per Order
SELECT ROUND(SUM(Quantity) / COUNT(DISTINCT Order_No), 2) AS Avg_Items_Per_Order FROM sales;

-- Average Order Preparation Time
SELECT
ROUND(
AVG(
TIMESTAMPDIFF(MINUTE, Order_Start_Time, Order_End_Time)
),
2) AS Avg_Preparation_Time_Minutes
FROM sales;

-- Sales Performance Analysis

-- Revenue by Brand
SELECT Brand_Name AS Brand, ROUND(SUM(Total_Price), 2) AS Revenue
FROM sales
GROUP BY Brand_Name
ORDER BY Revenue DESC;

-- Profit by Brand
SELECT Brand_Name AS Brand, ROUND(SUM(Total_Price - Food_Cost), 2) AS Profit
FROM sales
GROUP BY Brand_Name
ORDER BY Profit DESC;

-- Revenue by Kitchen Location
SELECT Restaurant_Name AS Kitchen_Location, ROUND(SUM(Total_Price), 2) AS Revenue
FROM sales
GROUP BY Restaurant_Name
ORDER BY Revenue DESC;

-- Profit by Kitchen Location
SELECT Restaurant_Name AS Kitchen_Location, ROUND(SUM(Total_Price - Food_Cost), 2) AS Profit
FROM sales
GROUP BY Restaurant_Name
ORDER BY Profit DESC;

-- Revenue by Sales Channel
SELECT Sales_Channel, ROUND(SUM(Total_Price), 2) AS Revenue
FROM sales
GROUP BY Sales_Channel
ORDER BY Revenue DESC;

-- Revenue by Order Type
SELECT Order_Type, ROUND(SUM(Total_Price), 2) AS Revenue FROM sales
GROUP BY Order_Type
ORDER BY Revenue DESC;

-- Top 10 Selling Menu Items
SELECT Food_Name, SUM(Quantity) AS Total_Quantity_Sold FROM sales
GROUP BY Food_Name
ORDER BY Total_Quantity_Sold DESC
LIMIT 10;

-- Top 10 Revenue Generating Menu Items
SELECT Food_Name, ROUND(SUM(Total_Price), 2) AS Revenue FROM sales
GROUP BY Food_Name
ORDER BY Revenue DESC
LIMIT 10;

-- Top 10 Most Profitable Menu Items
SELECT Food_Name, ROUND(SUM(Total_Price - Food_Cost), 2) AS Profit FROM sales
GROUP BY Food_Name
ORDER BY Profit DESC
LIMIT 10;

-- Average Revenue Per Order by Brand
SELECT Brand_Name AS Brand,
    ROUND(SUM(Total_Price) / COUNT(DISTINCT Order_No), 2) AS Avg_Order_Revenue
FROM sales
GROUP BY Brand_Name
ORDER BY Avg_Order_Revenue DESC;

-- Time-Based Analysis

-- Monthly Revenue Trend
SELECT YEAR(System_Date) AS Year, MONTH(System_Date) AS Month, ROUND(SUM(Total_Price),2) AS Revenue
FROM sales
GROUP BY YEAR(System_Date), MONTH(System_Date)
ORDER BY Year, Month;

-- Monthly Profit Trend
SELECT YEAR(System_Date) AS Year, MONTH(System_Date) AS Month, ROUND(SUM(Total_Price - Food_Cost),2) AS Profit
FROM sales
GROUP BY YEAR(System_Date), MONTH(System_Date)
ORDER BY Year, Month;

-- Revenue by Year
SELECT YEAR(System_Date) AS Year, ROUND(SUM(Total_Price),2) AS Revenue
FROM sales
GROUP BY YEAR(System_Date)
ORDER BY Year;

-- Revenue by Month
SELECT MONTHNAME(System_Date) AS Month, ROUND(SUM(Total_Price),2) AS Revenue
FROM sales
GROUP BY MONTH(System_Date), MONTHNAME(System_Date)
ORDER BY MONTH(System_Date);

-- Revenue by Weekdays
SELECT DAYNAME(System_Date) AS Weekday, ROUND(SUM(Total_Price),2) AS Revenue
FROM sales
GROUP BY DAYOFWEEK(System_Date), DAYNAME(System_Date)
ORDER BY DAYOFWEEK(System_Date);

-- Order by Hour
SELECT HOUR(Order_Start_Time) AS Hour, COUNT(DISTINCT Order_No) AS Orders
FROM sales
GROUP BY Hour
ORDER BY Hour;

-- Revenue by Hour
SELECT HOUR(Order_Start_Time) AS Hour, ROUND(SUM(Total_Price),2) AS Revenue
FROM sales
GROUP BY Hour
ORDER BY Hour;

-- Average Preparation Time by Brand
SELECT Brand_Name AS Brand,
    ROUND(
        AVG(
            TIMESTAMPDIFF(
                MINUTE,
                Order_Start_Time,
                Order_End_Time
            )
        ), 2
    ) AS Avg_Preparation_Time
FROM sales
GROUP BY Brand_Name
ORDER BY Avg_Preparation_Time DESC;

-- Average Preparation Time by Kitchen
SELECT
    Restaurant_Name,
    ROUND(
        AVG(
            TIMESTAMPDIFF(
                MINUTE,
                Order_Start_Time,
                Order_End_Time
            )
        ), 2
    ) AS Avg_Preparation_Time
FROM sales
GROUP BY Restaurant_Name
ORDER BY Avg_Preparation_Time DESC;

-- Busiest Day of the Week
SELECT DAYNAME(System_Date) AS Weekday, COUNT(DISTINCT Order_No) AS Orders
FROM sales
GROUP BY DAYOFWEEK(System_Date), DAYNAME(System_Date)
ORDER BY Orders DESC;

-- Brand Performance

-- Revenue by Brand
SELECT Brand_Name, ROUND(SUM(Total_Price),2) AS Revenue
FROM sales
GROUP BY Brand_Name
ORDER BY Revenue DESC;

-- Profit by Brand
SELECT Brand_Name, ROUND(SUM(Total_Price - Food_Cost),2) AS Profit
FROM sales
GROUP BY Brand_Name
ORDER BY Profit DESC;

-- Brandwise Profit Margin
SELECT Brand_Name,
    ROUND(
        (SUM(Total_Price - Food_Cost) / SUM(Total_Price)) * 100, 2
    ) AS Profit_Margin_Percentage
FROM sales
GROUP BY Brand_Name
ORDER BY Profit_Margin_Percentage DESC;

-- Brandwise Average Order value
SELECT Brand_Name,
    ROUND(SUM(Total_Price) / COUNT(DISTINCT Order_No), 2) AS Average_Order_Value
FROM sales
GROUP BY Brand_Name
ORDER BY Average_Order_Value DESC;

-- Brandwise Average Discount
SELECT Brand_Name, ROUND(AVG(Total_Discount_Price),2) AS Average_Discount
FROM sales
GROUP BY Brand_Name
ORDER BY Average_Discount DESC;

-- Brandwise Total Quantity Sold
SELECT Brand_Name, SUM(Quantity) AS Total_Items_Sold
FROM sales
GROUP BY Brand_Name
ORDER BY Total_Items_Sold DESC;

-- Brandwise Revenue Contribution
SELECT Brand_Name,
    ROUND(SUM(Total_Price),2) AS Revenue,
    ROUND(
        SUM(Total_Price) * 100 / (SELECT SUM(Total_Price) FROM sales), 2
    ) AS Revenue_Contribution_Percentage
FROM sales
GROUP BY Brand_Name
ORDER BY Revenue DESC;

-- Kitchen Performance

-- Revenue by Kitchen
SELECT Restaurant_Name AS Kitchen, ROUND(SUM(Total_Price),2) AS Revenue
FROM sales
GROUP BY Restaurant_Name
ORDER BY Revenue DESC;

-- Profit by Kitchen
SELECT Restaurant_Name AS Kitchen, ROUND(SUM(Total_Price - Food_Cost),2) AS Profit
FROM sales
GROUP BY Restaurant_Name
ORDER BY Profit DESC;

-- Kitchen Ranking
SELECT Restaurant_Name, ROUND(SUM(Total_Price),2) AS Revenue,
    RANK() OVER( ORDER BY SUM(Total_Price) DESC) AS Revenue_Rank
FROM sales
GROUP BY Restaurant_Name;

-- Customer Analytics

-- Top 10 Customers by Revenue
SELECT Customer_Name, ROUND(SUM(Total_Price),2) AS Revenue
FROM sales
GROUP BY Customer_Name
ORDER BY Revenue DESC
LIMIT 10;

-- Top 10 Customers by No. of Orders
SELECT Customer_Name, COUNT(DISTINCT Order_No) AS Total_Orders
FROM sales
GROUP BY Customer_Name
ORDER BY Total_Orders DESC
LIMIT 10;

-- Average spend Per Customer
SELECT Customer_Name, ROUND(AVG(Total_Price),2) AS Average_Spend
FROM sales
GROUP BY Customer_Name
ORDER BY Average_Spend DESC;

-- Customer Lifttime value
SELECT Customer_Name, COUNT(DISTINCT Order_No) AS Orders, ROUND(SUM(Total_Price),2) AS Lifetime_Value
FROM sales
GROUP BY Customer_Name
ORDER BY Lifetime_Value DESC;

-- Repeat vs One-Time Customers
SELECT
CASE
    WHEN Order_Count = 1 THEN 'One-Time Customer'
    ELSE 'Repeat Customer'
END AS Customer_Type,
COUNT(*) AS Total_Customers
FROM
    (SELECT Customer_Name, COUNT(DISTINCT Order_No) AS Order_Count
    FROM sales
    GROUP BY Customer_Name
    ) t
GROUP BY Customer_Type;

-- Customer Ranking by Revenue
SELECT Customer_Name, ROUND(SUM(Total_Price),2) AS Revenue,
    RANK() OVER(
        ORDER BY SUM(Total_Price) DESC
    ) AS Customer_Rank
FROM sales
GROUP BY Customer_Name;

-- Top 5 Customers in each Brand
WITH CustomerRevenue AS
(SELECT Brand_Name, Customer_Name, SUM(Total_Price) AS Revenue,
    DENSE_RANK() OVER(
        PARTITION BY Brand_Name
        ORDER BY SUM(Total_Price) DESC
        ) AS Ranking
FROM sales
GROUP BY
Brand_Name,
Customer_Name
)

SELECT * FROM CustomerRevenue
WHERE Ranking <= 5
ORDER BY Brand_Name, Ranking;

-- Highest Single Order value
SELECT Customer_Name, Order_No, ROUND(SUM(Total_Price),2) AS Order_Value
FROM sales
GROUP BY Customer_Name, Order_No
ORDER BY Order_Value DESC
LIMIT 10;

-- Menu Analysis

-- Top 10 Most Profitable Menu Items
SELECT Food_Name, ROUND(SUM(Total_Price - Food_Cost),2) AS Profit
FROM sales
GROUP BY Food_Name
ORDER BY Profit DESC
LIMIT 10;

-- Lowest Profit Value Menu Iteems
SELECT Food_Name, ROUND(SUM(Total_Price - Food_Cost),2) AS Profit
FROM sales
GROUP BY Food_Name
ORDER BY Profit
LIMIT 10;

-- Top 10 Highest Discount Menu Items
SELECT Food_Name, ROUND(SUM(Total_Discount_Price),2) AS Total_Discount
FROM sales
GROUP BY Food_Name
ORDER BY Total_Discount DESC
LIMIT 10;

-- Revenue vs Profit of Menu Items
SELECT Food_Name, ROUND(SUM(Total_Price),2) AS Revenue, ROUND(SUM(Total_Price - Food_Cost),2) AS Profit
FROM sales
GROUP BY Food_Name
ORDER BY Revenue DESC;

-- Top 10 Selling Items in Every Brand
WITH RankedItems AS
(
    SELECT Brand_Name, Food_Name, SUM(Quantity) AS Quantity_Sold,
    ROW_NUMBER() OVER(
        PARTITION BY Brand_Name
        ORDER BY SUM(Quantity) DESC
	) AS rn
    FROM sales
    GROUP BY Brand_Name, Food_Name
)

SELECT Brand_Name, Food_Name, Quantity_Sold
FROM RankedItems
WHERE rn = 1;

-- Revenue Share of Every Menu Item
SELECT Food_Name, ROUND(SUM(Total_Price),2) AS Revenue,
    ROUND(SUM(Total_Price) * 100 / (SELECT SUM(Total_Price) FROM sales), 2) AS Revenue_Share_Percentage
FROM sales
GROUP BY Food_Name
ORDER BY Revenue DESC;

-- Menu Items with Above-Average Revenue
SELECT Food_Name, ROUND(SUM(Total_Price),2) AS Revenue FROM sales
GROUP BY Food_Name
HAVING SUM(Total_Price) >
(
    SELECT AVG(ItemRevenue) FROM
    (
        SELECT SUM(Total_Price) AS ItemRevenue FROM sales
        GROUP BY Food_Name
    ) t
)
ORDER BY Revenue DESC;

-- Menu Items Rank by Profit within Each Brand
WITH ItemProfit AS
( SELECT Brand_Name, Food_Name, ROUND(SUM(Total_Price - Food_Cost),2) AS Profit,
    DENSE_RANK() OVER(
    PARTITION BY Brand_Name
    ORDER BY SUM(Total_Price - Food_Cost) DESC
    ) AS Profit_Rank
FROM sales
GROUP BY Brand_Name, Food_Name
)
SELECT * FROM ItemProfit
ORDER BY Brand_Name, Profit_Rank;

-- Average Quantity Sold Per Menu Item
SELECT Food_Name, ROUND(AVG(Quantity),2) AS Average_Quantity
FROM sales
GROUP BY Food_Name
ORDER BY Average_Quantity DESC;

-- Advanced SQL Queries

-- Running Revenue by Date
SELECT System_Date, ROUND(SUM(Total_Price),2) AS Daily_Revenue,
    ROUND(
        SUM(SUM(Total_Price)) OVER (ORDER BY System_Date), 2
    ) AS Running_Revenue
FROM sales
GROUP BY System_Date
ORDER BY System_Date;

-- Cumulative Orders
SELECT System_Date, COUNT(DISTINCT Order_No) AS Daily_Orders,
    SUM(COUNT(DISTINCT Order_No)) OVER (
        ORDER BY System_Date
    ) AS Cumulative_Orders
FROM sales
GROUP BY System_Date
ORDER BY System_Date;

-- Top 25% Customers
WITH CustomerRevenue AS
(
    SELECT Customer_Name, ROUND(SUM(Total_Price),2) AS Revenue FROM sales
    GROUP BY Customer_Name
)
SELECT Customer_Name, Revenue, NTILE(4) OVER(ORDER BY Revenue DESC) AS Customer_Quartile FROM CustomerRevenue;

-- Top 10 Revenue-Contributing Menu Items
WITH ItemRevenue AS
(
    SELECT Food_Name, SUM(Total_Price) AS Revenue FROM sales
    GROUP BY Food_Name
)

SELECT Food_Name, ROUND(Revenue,2) AS Revenue,
    PERCENT_RANK() OVER(ORDER BY Revenue DESC) AS Revenue_Percent_Rank
FROM ItemRevenue;

-- Revenue Percentage by Brand
SELECT Brand_Name, ROUND(SUM(Total_Price),2) AS Revenue,
    ROUND(SUM(Total_Price) * 100 / SUM(SUM(Total_Price)) OVER(), 2) AS Revenue_Percentage
FROM sales
GROUP BY Brand_Name
ORDER BY Revenue DESC;

-- Best Selling Item of Every Month
WITH MonthlySales AS
(
    SELECT YEAR(System_Date) AS Year_No, MONTH(System_Date) AS Month_No, Food_Name, SUM(Quantity) AS Quantity_Sold,
    ROW_NUMBER() OVER(
        PARTITION BY YEAR(System_Date), MONTH(System_Date)
        ORDER BY SUM(Quantity) DESC
    ) AS rn
    FROM sales
    GROUP BY YEAR(System_Date), MONTH(System_Date), Food_Name
)
SELECT Year_No, Month_No, Food_Name, Quantity_Sold
FROM MonthlySales
WHERE rn = 1;

-- Customer Purchase Frequency
SELECT Customer_Name, COUNT(DISTINCT Order_No) AS Orders_Placed,
    DENSE_RANK() OVER(
        ORDER BY COUNT(DISTINCT Order_No) DESC
    ) AS Frequency_Rank
FROM sales
GROUP BY Customer_Name;

-- Data Export
SELECT * FROM brands;
SELECT * FROM customers;
SELECT * FROM food_recipe;
SELECT * FROM kitchen_locations;
SELECT * FROM menu_items;
SELECT * FROM orders;
SELECT * FROM production_recipe;
SELECT * FROM sales;