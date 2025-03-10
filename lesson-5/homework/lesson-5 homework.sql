SELECT * FROM Customers
SELECT * FROM ORDERS
SELECT * FROM Products

--------	EASY LEVEL TASKS

--- 1.Write a query that uses an alias to rename the ProductName column as Name in the Products table.
SELECT ProductId, ProductName as Name, Category, Price, StockQuantity 
from Products

--- 2.Write a query that uses an alias to rename the Customers table as Client for easier reference.
SELECT *
FROM Customers AS CLIENTS

--- 3.Use UNION to combine results from two queries that select ProductName from Products and ProductName from Products_Discontinued.
Select ProductName
from Products
union 
Select ProductName
from Products_Discontinued

--- 4.Write a query to find the intersection of Products and Products_Discontinued tables using INTERSECT.
Select ProductID,ProductName,Price
from Products
intersect
Select *
from Products_Discontinued

--- 5.Use UNION ALL to combine two tables, Products and Orders, that have the same structure.
select *
from products
union all
select *
from orders

--- 6.Write a query to select distinct customer names (CustomerName) and their corresponding Country using SELECT DISTINCT
select distinct customername, country 
from customers1

--- 7.Write a query that uses CASE to create a conditional column that displays 'High' if Price > 100, and 'Low' if Price <= 100.
select productid,productname,category,price,
case
	when price <100 then 'Low'
	else 'High'
end as Price_Category
from products

--- 8.Write a query to filter Employees by Department and group them by Country.
select Country,Department,COUNT(EmployeeID) AS NUMBER
from employees
group by Country,Department

--- 9.Use GROUP BY to find the number of products (ProductID) in each Category.
select Category, count(productid) as [Number of Products]
from products
group by category

--- 10.Use IIF to create a column that shows 'Yes' if Stock > 100, and 'No' otherwise.
select *, iif(StockQuantity>100,'Yes','No') as Stock_Status
from products


------- MEDIUM LEVEL TASKS

--- 1. Write a query that joins the Orders and Customers tables using INNER JOIN and aliases the CustomerName as ClientName.
select c.customerid, c.CustomerName as ClientName, c.Country,o.orderid,o.orderdate,o.totalamount,o.status
from customers1 as c
join orders as o
on c.customerid = o.customerid

--- 2. Use UNION to combine results from two queries that select ProductName from Products and ProductName from OutOfStock tables.
select ProductName
from Products
union
select ProductName
from OutOfStock

--- 3. Write a query that returns the difference between the Products and DiscontinuedProducts tables using EXCEPT.
select ProductID,ProductName,Price
from Products
except
select *
from Products_Discontinued

--- 4. Write a query that uses CASE to assign a value of 'Eligible' to customers who have placed more than 5 orders, otherwise 'Not Eligible'.
select customerid, 
case
	when quantity>=5 then 'Eligible'
	else 'Not Eligible'
end as status
from orders1

--- 5. Create a conditional column using IIF that shows 'Expensive' if the Price is greater than 100, and 'Affordable' if less.
select productid,productname,category,price,iif(price>100,'Expensive','Affordable') as price_category
from products

--- 6. Write a query that uses GROUP BY to count the number of orders per CustomerID in the Orders table.Write a query that uses GROUP BY to count the number of orders per CustomerID in the Orders table.
select customerId, count(orderId)
from orders
group by customerId

--- 7. Write a query to find employees in the Employees table who have either Age < 25 or Salary > 6000.
select *
from employees
where age <  25 or salary > 6000

--- 8. Use GROUP BY to find the total sales (SalesAmount) per Region in the Sales table.
select region, sum(SalesAmount)
from sales
group by region

--- 9. Write a query that combines data from the Customers and Orders tables using LEFT JOIN, and create an alias for OrderDate.
select customers.customerid,firstname,lastname,email,phone,address,city,state,postalcode,orderid,orderdate as date, totalamount,status
from customers
left join orders
on customers.customerid = orders.customerid

--- 10. Use IF statement to update the salary of an employee based on their department, increase by 10% if they work in 'HR'
select *,
	case 
		when departmentid = 4 then cast (salary * 1.1 as varchar(50))
		else 'not changed'
	end as new_salary
from employees


------- HARD LEVEL TASKS

--- 1. Write a query that uses UNION ALL to combine two tables, Sales and Returns, and calculate the total sales and returns for each product.
SELECT S.PRODUCTID,SUM(SALEAMOUNT)
FROM SALES AS S
GROUP BY S.PRODUCTID
UNION ALL
SELECT R.PRODUCTID,SUM(RETURNAMOUNT)
FROM RETURNS AS R
GROUP BY R.PRODUCTID

--- 2. Use INTERSECT to show products that are common between Products and DiscontinuedProducts tables.
SELECT PRODUCTID
FROM PRODUCTS_DISCONTINUED
INTERSECT
SELECT PRODUCTID
FROM PRODUCTS

--- 3. Write a query that uses CASE to assign 'Top Tier' if TotalSales > 10000, 'Mid Tier' if TotalSales BETWEEN 5000 AND 10000, and 'Low Tier' otherwise.
SELECT PRODUCTID,SUM(SALEAMOUNT) AS TotalSales,
CASE 
	WHEN SUM(SALEAMOUNT)>10000 then 'Top Tier'
	WHEN SUM(SALEAMOUNT) between 5000 and 10000 then 'Mid Tier'
	ELSE 'Low Tier'
END AS SALE_STATUS
FROM SALES
GROUP BY PRODUCTID

--- 4. Write a query that combines multiple conditions using IF and WHILE to iterate over all rows of the Employees table and update their salary based on certain criteria.
DECLARE @ID INT
SET @ID = 1

--- 5. Use EXCEPT to find customers who have placed orders but do not have a corresponding record in the Invoices table.
SELECT *
FROM ORDERS
EXCEPT
SELECT *
FROM INVOICES

--- 6. Write a query that uses GROUP BY on three columns: CustomerID, ProductID, and Region, and calculates the total sales.
SELECT CUSTOMERID,PRODUCTID,REGION, SUM(SALES)
FROM SALES
GROUP BY CUSTOMERID,PRODUCTID,REGION

--- 7. Write a query that uses CASE to apply multiple conditions and returns a Discount column based on the Quantity purchased.
SELECT *,
CASE
	WHEN QUANTITY <3 THEN '5%'
	WHEN QUANTITY =3 THEN '7%'
	ELSE '10%'
END AS DISCOUNT
FROM CUSTOMERORDERS

--- 8. Use UNION and INNER JOIN to return all products that are either in the Products or DiscontinuedProducts table and also show if they are currently in stock.
SELECT *
FROM PRODUCTS_DISCONTINUED

SELECT *
FROM PRODUCTS

SELECT *
FROM PRODUCTS_DISCONTINUED
UNION
SELECT PRODUCTID,PRODUCTNAME,PRICE
FROM PRODUCTS

--- 9. Write a query that uses IIF to create a new column StockStatus, where the status is 'Available' if Stock > 0, and 'Out of Stock' if Stock = 0.
SELECT *, IIF(STOCK>0,'Available', 'Out of Stock') as StockStatus
from ProductInformation

--- 10. Write a query that uses EXCEPT to find customers in the Customers table who are not in the VIP_Customers table based on CustomerID.
SELECT CUSTOMERID
FROM CUSTOMERS
EXCEPT 
SELECT CUSTOMERID
FROM VIP_CUSTOMERS
