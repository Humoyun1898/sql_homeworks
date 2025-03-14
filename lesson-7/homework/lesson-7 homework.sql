create database lesson7_homework

----------EASY LEVEL TASKS------------------
--1
select MIN(PRICE) AS Minimum_price
from products

--2
select max(salary) as Maximum_salary
from Employees

--3
select count(*) as Number_of_rows
from customers

--4
select count(distinct Category) as Number_of_categories
from products

--5
select ProductID, SUM(SaleAmount) as Sales_per_product
from Sales
group by productid

--6
select avg(age) as Average_age
from Employees

--7
select departmentid, count(EmployeeID) as Number_of_Employees
from Employees
group by DepartmentID

--8
select Category, min(price) as Minimum_price, max(price) as Maximum_price
from Products
group by Category

--9
select Region, sum(SaleAmount) as Sales_Amount
from Sales
group by Region

--10

select DepartmentID, count(EmployeeID) as Number_of_employees
from employees
group by DepartmentID
having count(EmployeeID) > 5


----------MEDIUM LEVEL TASKS------------------

--11
select Category, avg(saleamount) as Average_sales, sum(saleamount) as Total_sales
from Sales
group by Category

--12
select JobTitle, count(*)
from Employees
group by JobTitle

--13
select DepartmentID, max(salary) as maximum_salary, min(salary) as minimum_salary
from Employees
group by DepartmentID

--14
select DepartmentID, avg(salary) as Average_salary
from employees
group by DepartmentID

--15
select DepartmentID, avg(salary) as Average_salary, count(*) as Number_of_Employees
from Employees
group by DepartmentID

--16
select ProductName, avg(price) as Average_Price
from Products
group by ProductName
having avg(price) > 100

--17
SELECT COUNT(DISTINCT PRODUCTID) AS ProductCount
FROM SALES
GROUP BY PRODUCTID
HAVING SUM(SALEUNITS) > 100

--18
select year, sum(saleamount) as Total_sales
from sales
group by year

--19
select Region, count(customerid) as Number_of_Customers 
from Orders
group by Region

--20
select DepartmentID, sum(Salary) as Salary_Expenses
from Employees
group by DepartmentID
having sum(Salary) > 100000


----------HARD LEVEL TASKS------------------

--21
select Categopry,avg(Saleamount) as Sales
from Sales
group by Category
having avg(saleamount)>200

--22
select Employeeid, SUM(SALEAMOUNT) as Sales
from employees
group by Employeeid
having sum(saleamount) > 5000

--23
select DepartmentID, sum(salary) as Total_salary, avg(salary) as Average_salary
from Employees
group by DepartmentID
having avg(salary)>6000

--24
select Customerid, max(order_value), min(order_value)
from orders
group by CustomerID
having order_value > 50

--25
select region,sum(salesamount),count(distinct productid)
from sales
group by region
having count(distinct productid) > 10

--26
SELECT 
    Category,
    MIN(OrderQuantity) AS MinOrderQuantity,
    MAX(OrderQuantity) AS MaxOrderQuantity
FROM Orders
WHERE ProductID IN (SELECT ProductID FROM CategoryTable)
GROUP BY Category
ORDER BY Category

--27.
select *
from Sales
pivot(sum(sales) for [region] in ([Tashkent], [Samarqand], [Nukus]) as pivot_table

--28
select pvt.PERIOD, pvt.[sales]
from sales
unpivot(sales for [PERIOD] IN ([Q1], [Q2], [Q3],[Q4]) as pvt

--29
select p.product_category, p.product_name, count(o.order_id) as total_orders
from orders o
join products p on o.product_id = p.product_id
group by p.product_category, p.product_name
having count(o.order_id) > 50

--30
select *
from EmployeeSales
pivot(sum(sales) for [QUARTER] in ([Q1], [Q2], [Q3], [Q4]) as pivot_table
