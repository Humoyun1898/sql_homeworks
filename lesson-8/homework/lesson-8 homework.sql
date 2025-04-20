-----EASY LEVEL TASKS ---

--1.Using Products table, find the total number of products available in each category.
select Category, count(ProductID) as Number_of_products
from Products
group by Category

--2.Using Products table, get the average price of products in the 'Electronics' category.
select Category, avg(Price) as Average_price
from Products
where Category = 'Electronics'
group by Category

--3.Using Customers table, list all customers from cities that start with 'L'.
select *
from Customers
where city like 'L%'

--4.Using Products table, get all product names that end with 'er'.
select *
from Products
where ProductName like '%er'

--5.Using Customers table, list all customers from countries ending in 'A'.
select *
from Customers
where Country like '%A'

--6.Using Products table, show the highest price among all products.
select max(Price) as max_price
from Products

--7.Using Products table, use IIF to label stock as 'Low Stock' if quantity < 30, else 'Sufficient'.
select *,iif(StockQuantity<30, 'Low Stock','Sufficient') as Stock_label
from Products

--8.Using Customers table, find the total number of customers in each country.
select Country,count(CustomerID) as Number_of_Customers
from Customers
group by Country

--9.Using Orders table, find the minimum and maximum quantity ordered.
select min(Quantity) as Mim_quantity, max(Quantity) as Max_quantity
from Orders


----MEDIUM LEVEL TASKS ----------
--10.Using Orders and Invoices tables, list customer IDs who placed orders in 2023 (using EXCEPT) to find those who did not have invoices.
select CustomerID
from Orders
where year(OrderDate) = 2023
except 
select CustomerID
from Invoices

--11.Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted including duplicates.
select ProductName
from Products
union all
select ProductName
from Products_Discounted

--12.Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted without duplicates.
select ProductName
from Products
union
select ProductName
from Products_Discounted

--13.Using Orders table, find the average order amount by year.
select year(OrderDate) as Years, avg(TotalAmount) as Average_order
from Orders
group by year(OrderDate)

--14.Using Products table, use CASE to group products based on price: 'Low' (<100), 'Mid' (100-500), 'High' (>500). Return productname and pricegroup.
select ProductName, case
					when Price<100 then 'Low'
					when Price between 100 and 500 then 'Mid'
					else 'High'
					end as Price_group
from Products

--15.Using Customers table, list all unique cities where customers live, sorted alphabetically.
select distinct Country
from Customers
order by Country asc

--16.Using Sales table, find total sales per product Id.
select ProductID,sum(SaleAmount) as Total_sales
from Sales
group by ProductID

--17.Using Products table, use wildcard to find products that contain 'oo' in the name. Return productname.
select ProductName
from Products
where ProductName like '%oo%'

--18.Using Products and Products_Discounted tables, compare product IDs using INTERSECT.
select ProductID
from Products
intersect
select ProductID
from Products_Discounted

--HARD LEVEL TASKS------
--19.Using Invoices table, show top 3 customers with the highest total invoice amount. Return CustomerID and Totalspent.
select CustomerID,sum (TotalAmount) as Total_amount
from Invoices
group by CustomerID
order by sum(TotalAmount) desc
offset 0 rows
fetch next 3 rows only

--20.Find product ID and productname that are present in Products but not in Products_Discounted.
select ProductID,ProductName
from Products
except
select ProductID,ProductName
from Products_Discounted

--21. Using Products and Sales tables, list product names and the number of times each has been sold. (Research for Joins)
select p.ProductName, count(s.SaleID) as Number_of_products_sold
from Sales as s
join Products as p
on s.ProductID = p.ProductID
group by p.ProductName

--22.Using Orders table, find top 5 products (by ProductID) with the highest order quantities.
select top 5 ProductID, sum(Quantity) as Total_quantity
from Orders
group by ProductID
order by Total_quantity desc



