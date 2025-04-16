select *
from Categories

------	EASY LEVEL------
--1.
--Return: OrderID, CustomerName, OrderDate
--Task: Show all orders placed after 2022 along with the names of the customers who placed them.
--Tables Used: Orders, Customers

select o.OrderID,c.FirstName,c.LastName,o.TotalAmount
from Orders as o
join Customers as c
on o.CustomerID = c.CustomerID
where year(OrderDate) > 2022

--2.
--Return: EmployeeName, DepartmentName
--Task: Display the names of employees who work in either the Sales or Marketing department.
--Tables Used: Employees, Departments

select e.Name,d.DepartmentName
from Employees as e
join Departments as d
on e.DepartmentID = d.DepartmentID
where d.DepartmentName in ('Sales','Marketing')

--3.
--Return: DepartmentName, TopEmployeeName, MaxSalary
--Task: For each department, show the name of the employee who earns the highest salary.
--Tables Used: Departments, Employees (as a derived table)

select d.DepartmentName,e.Name,dt.Max_salary
from Employees as e
join
(select DepartmentID,max(Salary) as Max_salary
from Employees
group by DepartmentID) as dt
on e.Salary = dt.Max_salary and dt.DepartmentID = e.DepartmentID
join Departments as d
on e.DepartmentID = d.DepartmentID

--4.
--Return: CustomerName, OrderID, OrderDate
--Task: List all customers from the USA who placed orders in the year 2023.
--Tables Used: Customers, Orders

select c.FirstName,c.LastName,o.OrderID,o.OrderDate
from Customers as c
join Orders as o
on c.CustomerID = o.CustomerID
where c.Country = 'USA' and year(o.OrderDate) = 2023

--5
--Return: CustomerName, TotalOrders
--Task: Show how many orders each customer has placed.
--Tables Used: Orders (as a derived table), Customers
select c.FirstName,c.LastName,dt.Number_of_orders
from Customers as c
join
(select CustomerID, count(OrderID) as Number_of_orders
from Orders
group by CustomerID) as dt
on c.CustomerID = dt.CustomerID

--6.
--Return: ProductName, SupplierName
--Task: Display the names of products that are supplied by either Gadget Supplies or Clothing Mart.
--Tables Used: Products, Suppliers

select p.ProductName,s.SupplierName
from Products as p
join Suppliers as s
on p.SupplierID = s.SupplierID
where s.SupplierName in ('Gadget Supplies', 'Clothing Mart')

--7.
--Return: CustomerName, MostRecentOrderDate, OrderID
--Task: For each customer, show their most recent order. Include customers who haven't placed any orders.
--Tables Used: Customers, Orders (as a derived table)

select c.FirstName, c.LastName, dt2.OrderDate,dt2.OrderID
from Customers as c
join
(select o.OrderID,o.OrderDate,o.CustomerID
from Orders as o
join 
(select CustomerID, max(OrderDate) as recent_order
from Orders
group by CustomerID) as dt
on o.CustomerID = dt.CustomerID and o.OrderDate = dt.recent_order) as dt2
on c.CustomerID = dt2.CustomerID


-----MEDIUM LEVEL TASKS---------
--8.
--Return: CustomerName, OrderID, OrderTotal
--Task: Show the customers who have placed an order where the total amount is greater than 500.
--Tables Used: Orders, Customers
select c.FirstName,c.LastName,o.OrderID,o.TotalAmount
from Orders as o
join Customers as c
on o.CustomerID = c.CustomerID
where o.TotalAmount > 500


--9.
--Return: ProductName, SaleDate, SaleAmount
--Task: List product sales where the sale was made in 2022 or the sale amount exceeded 400.
--Tables Used: Products, Sales
select p.ProductName,s.SaleDate,s.SaleAmount
from Products as p
join Sales as s
on p.ProductID = s.ProductID and (year(s.SaleDate) = 2022 and s.SaleAmount > 400)

--10.
--Return: ProductName, TotalSalesAmount
--Task: Display each product along with the total amount it has been sold for.
--Tables Used: Sales (as a derived table), Products
select p.ProductName,dt.SaleAmount
from Products as p
join
(select ProductID, sum(SaleAmount) as SaleAmount
from Sales 
group by ProductID) as dt
on p.ProductID = dt.ProductID

--11.
--Return: EmployeeName, DepartmentName, Salary
--Task: Show the employees who work in the HR department and earn a salary greater than 50000.
--Tables Used: Employees, Departments

select e.Name,d.DepartmentName,e.Salary
from Employees as e
join Departments as d
on e.DepartmentID = d.DepartmentID and (d.DepartmentName = 'Human Resources' and e.Salary > 50000)


--12.
--Return: ProductName, SaleDate, StockQuantity
--Task: List the products that were sold in 2023 and had more than 50 units in stock at the time.
--Tables Used: Products, Sales
select p.ProductName,s.SaleDate,p.StockQuantity
from Products as p
join Sales as s
on p.ProductID = s.ProductID and (year(s.SaleDate) = 2023 and p.StockQuantity > 50)

--13.
--Return: EmployeeName, DepartmentName, HireDate
--Task: Show employees who either work in the Sales department or were hired after 2020.
--Tables Used: Employees, Departments
select e.Name,d.DepartmentName,e.HireDate
from Employees as e
join Departments as d
on e.DepartmentID = d.DepartmentID and (d.DepartmentName ='Sales' or year(e.HireDate) > 2020)


-----HARD LEVEL TASKS------------
--14.
--Return: CustomerName, OrderID, Address, OrderDate
--Task: List all orders made by customers in the USA whose address starts with 4 digits.
--Tables Used: Customers, Orders
select c.FirstName,c.LastName,o.OrderID,c.Address,o.OrderDate
from Customers as c
join Orders as o
on c.CustomerID = o.CustomerID and (c.Country = 'USA' and c.Address like '[0-9][0-9][0-9][0-9]%')

--15.
--Return: ProductName, Category, SaleAmount
--Task: Display product sales for items in the Electronics category or where the sale amount exceeded 350.
--Tables Used: Products, Sales
select *--p.ProductName,c.CategoryName,s.SaleAmount
from Sales as s
join Products as p
on s.ProductID = p.ProductID and s.SaleAmount > 350
join Categories as c
on p.Category = c.CategoryID and c.CategoryName = 'Electronics'

--16.
--Return: CategoryName, ProductCount
--Task: Show the number of products available in each category.
--Tables Used: Products (as a derived table), Categories
select c.CategoryName,dt.Number_of_products
from Categories as c
join 
(select Category, COUNT(ProductID) as Number_of_products
from Products
group by Category) as dt
on c.CategoryID = dt.Category


--17.
--Return: CustomerName, City, OrderID, Amount
--Task: List orders where the customer is from Los Angeles and the order amount is greater than 300.
--Tables Used: Customers, Orders
select c.FirstName,c.LastName, c.City,o.OrderID,o.TotalAmount
from Customers as c
join Orders as o
on c.CustomerID = o.CustomerID and (c.City = 'Los Angeles' and o.TotalAmount > 300)


--18.
--Return: EmployeeName, DepartmentName
--Task: Display employees who are in the HR or Finance department, or whose name contains at least 4 vowels.
--Tables Used: Employees, Departments

select e.Name,d.DepartmentName
from Employees as e
join Departments as d
on e.DepartmentID = d.DepartmentID and (d.DepartmentName in ('Human Resources','Finance') or e.Name like '%[aiuio]%[aiuio]%[aiuio]%[aiuio]%')

--19.
--Return: ProductName, QuantitySold, Price
--Task: List products that had a sales quantity above 100 and a price above 500.
--Tables Used: Sales, Products
select p.ProductName,dt.Number_of_units,p.Price
from Products as p
join
(select ProductID, count(SaleID) as Number_of_units
from Sales
group by ProductID) as dt
on p.ProductID = dt.ProductID and (dt.Number_of_units > 100 and p.Price >500)


--20.
--Return: EmployeeName, DepartmentName, Salary
--Task: Show employees who are in the Sales or Marketing department and have a salary above 60000.
--Tables Used: Employees, Departments
select e.Name,d.DepartmentName,e.Salary
from Employees as e
join Departments as d
on e.DepartmentID = d.DepartmentID and (d.DepartmentName in ('Sales','Marketing') and e.Salary > 60000)
