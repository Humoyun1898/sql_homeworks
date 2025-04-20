-----EASY LEVEL TASKS -----

--1.Write a query to find the minimum (MIN) price of a product in the Products table.
select min(price) as min_price
from Products

--2.Write a query to find the maximum (MAX) Salary from the Employees table.
select max(Salary) as max_salary
from Employees

--3.Write a query to count the number of rows in the Customers table using COUNT(*).
select count(*) as number_of_rows
from Customers

--4.Write a query to count the number of unique product categories (COUNT(DISTINCT Category)) from the Products table.
select count(distinct category) as Number_Of_Categories
from Products

--5.Write a query to find the total (SUM) sales amount for the product with id 7 in the Sales table.
select ProductID, sum(SaleAmount) as Total_sales
from Sales
where ProductID = 7
group by ProductID

--6.Write a query to calculate the average (AVG) age of employees in the Employees table.
select avg(age) as average_age
from Employees

--7.Write a query that uses GROUP BY to count the number of employees in each department.
select DepartmentName, count(EmployeeID) as Number_of_Employees
from Employees
group by DepartmentName

--8.Write a query to show the minimum and maximum Price of products grouped by Category. Use products table.
select Category, max(price) as Maximum_price , min(price) as Minimum_price
from Products
group by Category

--9.Write a query to calculate the total (SUM) sales per Customer in the Sales table.
select CustomerID, sum(SaleAmount) as Total_Sales
from Sales
group by CustomerID

--10.Write a query to use HAVING to filter departments having more than 5 employees from the Employees table.(DeptID is enough, if you don't have DeptName).
select DepartmentName, count(EmployeeID) AS Number_of_Employees
from Employees
group by DepartmentName
having count(EmployeeID) > 5

----MEDIUM LEVEL TASKS---

--11.Write a query to calculate the total sales and average sales for each product category from the Sales table.
select p.Category, sum(SaleAmount) as Total_sales, avg(SaleAmount) as avg_sales
from Sales as s
join Products as p
on s.ProductID = p.ProductID
group by p.Category

--12.Write a query that uses COUNT(columnname) to count the number of employees from the Department HR.
select DepartmentName, count(EmployeeID) as Number_of_Employees
from Employees
where DepartmentName = 'HR'
group by DepartmentName

--13.Write a query that finds the highest (MAX) and lowest (MIN) Salary by department in the Employees table.(DeptID is enough, if you don't have DeptName).
select DepartmentName, max(salary) as Max_salary,min(salary) as Min_salary
from Employees
group by DepartmentName

--14.Write a query that uses GROUP BY to calculate the average salary per Department.(DeptID is enough, if you don't have DeptName).
select DepartmentName, avg(salary) as average_salary
from Employees
group by DepartmentName

--15.Write a query to show the AVG salary and COUNT(*) of employees working in each department.(DeptID is enough, if you don't have DeptName).
select DepartmentName, avg(salary) as average_salary, count(EmployeeID) AS Number_of_Employees
from Employees
group by DepartmentName

--16.Write a query that uses HAVING to filter product categories with an average price greater than 400.
select Category, avg(price) as average_price
from Products
group by Category
having avg(price) > 400

--17.Write a query that calculates the total sales for each year in the Sales table, and use GROUP BY to group them.
select year(SaleDate) as _Year_, sum(SaleAmount) as Total_sales
from Sales
group by year(SaleDate) 

--18.Write a query that uses COUNT to show the number of customers who placed at least 3 orders.
select CustomerID, count(OrderID) as Number_of_orders
from Orders
group by CustomerID
having count(OrderID) >= 3

--19.Write a query that applies the HAVING clause to filter out Departments with total salary expenses greater than 500,000.(DeptID is enough, if you don't have DeptName).
select DepartmentName, SUM(SALARY) AS Total_salary
from Employees
group by DepartmentName
having sum(Salary) > 500000


---HARD LEVEL TASKS----
--20.Write a query that shows the average (AVG) sales for each product category, and then uses HAVING to filter categories with an average sales amount greater than 200.
select p.Category, AVG(SaleAmount) as average_sales
from Sales as s
join Products as p
on s.ProductID = p.ProductID
group by p.Category
having avg(SaleAmount) > 200

--21.Write a query to calculate the total (SUM) sales for each Customer, then filter the results using HAVING to include only Customers with total sales over 1500.
select CustomerID,sum(SaleAmount) as Total_sales
from Sales
group by CustomerID
having sum(SaleAmount) > 1500

--22.Write a query to find the total (SUM) and average (AVG) salary of employees grouped by department, and use HAVING to include only departments with an average salary greater than 65000.
select DepartmentName, sum(Salary) as Total_salary, avg(Salary) as Average_salary
from Employees
group by DepartmentName
having avg(salary) > 65000

--23.Write a query that finds the maximum (MAX) and minimum (MIN) order value for each customer, and then applies HAVING to exclude customers with an order value less than 50.
select CustomerID, max(TotalAmount) as max_order_value, min(TotalAmount) as min_order_value
from Orders
group by CustomerID
having min(TotalAmount) > 50

--24.Write a query that calculates the total sales (SUM) and counts distinct products sold in each month, and then applies HAVING to filter the months with more than 8 products sold.
select MONTH(SaleDate) as _month_, sum(SaleAmount) as Total_sales, count(distinct ProductID) as Number_of_distinct_products
from Sales
group by MONTH(SaleDate)
having count(distinct ProductID) > 8

--25.Write a query to find the MIN and MAX order quantity per Year. From orders table. (Do some research)
select year(OrderDate) as Years, min(quantity) as minimum_quantity, max(quantity) as maximum_quantity
from Orders
group by year(OrderDate)
