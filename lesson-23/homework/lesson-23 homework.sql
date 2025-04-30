--Puzzle 1: In this puzzle you have to extract the month from the dt column and then append zero single digit month if any. Please check out sample input and expected output.
SELECT Id,Dt,FORMAT(Dt, 'MM') AS MonthFormatted
FROM Dates;

--Puzzle 2: In this puzzle you have to find out the unique Ids present in the table. You also have to find out the SUM of Max values of vals columns for each Id and RId. For more details please see the sample input and expected output.
WITH MaxVals AS (
    SELECT Id, rID, MAX(Vals) AS MaxVal
    FROM MyTabel
    GROUP BY Id, rID
)
select count (distinct ID) as DistinctID, max(rID) as RID, sum(MaxVal) as Sum_of_max_values
from MaxVals

--Puzzle 3: In this puzzle you have to get records with at least 6 characters and maximum 10 characters. Please see the sample input and expected output.
select *
from TestFixLengths
where len(vals) >= 6 and len(Vals) <=10

--Puzzle 4: In this puzzle you have to find the maximum value for each Id and then get the Item for that Id and Maximum value. The Challenge is to do that in a SINGLE SELECT. Please check out sample input and expected output.
with cte as (select ID,Item,Vals, max(Vals) over (partition by ID) as max_value
			from TestMaximum)
select ID,Item, max_value
from cte
where vals = max_value

--Puzzle 5: In this puzzle you have to first find the maximum value for each Id and DetailedNumber, and then Sum the data using Id only. Can you do this both in a single SELECT ?. Please check out sample input and expected output.
select dt.Id, sum(dt.max_vals) as Sum_of_Max
from
(select id, DetailedNumber, max(Vals) as max_vals
from SumOfMax
group by id,DetailedNumber) as dt
group by dt.Id

--Puzzle 6: In this puzzle you have to find difference between a and b column between each row and if the difference is not equal to 0 then show the difference i.e. a – b otherwise 0. Now you need to replace this zero with blank.Please check the sample input and the expected output.
select *, case
			when a-b = 0 then ''
			else cast(a-b as varchar)
		end
from TheZeroPuzzle

--7.What is the total revenue generated from all sales?
with cte as (select *,QuantitySold*UnitPrice as Sales_volume
from Sales)
select sum(Sales_volume) as Total_revenue
from cte

--8.What is the average unit price of products?
select cast(avg(UnitPrice) as decimal(10,2) ) as Average_unit_price
from Sales

--9.How many sales transactions were recorded?
select count( * ) as number_of_transactions
from Sales

--10.What is the highest number of units sold in a single transaction?
with cte as(select SaleID, max(QuantitySold) over (partition by SaleID) as units_sold
from Sales)
select max(units_sold) as max_unit_sold
from cte

--11.How many products were sold in each category?
select distinct Category, sum(QuantitySold) over (partition by category) as Number_of_Products
from Sales

--12.What is the total revenue for each region?
select distinct Region, sum(QuantitySold*UnitPrice) over (partition by Region) as Total_reveune
from Sales

--13.What is the total quantity sold per month?
select distinct datename(month,SaleDate) as month, SUM(QuantitySold) over (partition by  datename(month,SaleDate) ) as quantity
from Sales

--14.Which product generated the highest total revenue?
with cte as (select distinct Product, sum(QuantitySold * UnitPrice) over (partition by Product) as Revenue_per_product
from Sales), cte2 as (select *, DENSE_RANK() over (order by Revenue_per_product desc) as dr
						from cte)
select *
from cte2
where dr = 1

--15.Compute the running total of revenue ordered by sale date.
select *, QuantitySold*UnitPrice as Revenue, sum(QuantitySold*UnitPrice) over (Order by SaleDate) as Running_Total
from Sales

--16.How much does each category contribute to total sales revenue?
with cte as (select distinct Category, sum(QuantitySold*UnitPrice) over (partition by Category) as Revenue_per_category
			from Sales)
select *,cast (Revenue_per_category/(select sum(Revenue_per_category) from cte) * 100 as decimal(10,2) ) as Contribute_in_percent
from cte

--17.Show all sales along with the corresponding customer names
SELECT s.*,c.CustomerName
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID;

--18.List customers who have not made any purchases
SELECT  c.*
FROM Customers c
LEFT JOIN Sales s 
ON s.CustomerID = c.CustomerID
WHERE 
    s.CustomerID IS NULL;

--19.Compute total revenue generated from each customer
SELECT 
    c.CustomerID,
    c.CustomerName,
    SUM(s.QuantitySold * s.UnitPrice) AS TotalRevenue
FROM Sales s
JOIN Customers c
ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustomerName;

--20.Find the customer who has contributed the most revenue
WITH CustomerRevenue AS (
    SELECT 
        c.CustomerID,
        c.CustomerName,
        SUM(s.QuantitySold * s.UnitPrice) AS TotalRevenue
    FROM Sales s
    JOIN Customers c ON s.CustomerID = c.CustomerID
    GROUP BY c.CustomerID, c.CustomerName
)
SELECT TOP 1 *
FROM CustomerRevenue
ORDER BY TotalRevenue DESC;

--21.Calculate the total sales per customer per month
SELECT 
    c.CustomerID,
    c.CustomerName,
    FORMAT(s.SaleDate, 'yyyy-MM') AS SaleMonth,
    SUM(s.QuantitySold * s.UnitPrice) AS MonthlyRevenue
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustomerName, FORMAT(s.SaleDate, 'yyyy-MM')
ORDER BY c.CustomerID, SaleMonth;

--22.List all products that have been sold at least once
WITH CTE AS (select ProductName, count(ProductName) over (partition by ProductName) as Number_of_products
			from Products)
select *
from cte
where Number_of_products >= 1

--23.Find the most expensive product in the Products table
with cte as (select ProductName,DENSE_RANK() over (order by SellingPrice desc) as dr
			from Products)
select *
from cte
where dr =1

--24.Show each sale with its corresponding cost price from the Products table
select s.*,p.CostPrice
from Sales as s
left join Products as p
on s.Product = p.ProductName

--25.Find all products where the selling price is higher than the average selling price in their category
with cte as (select ProductID,ProductName,Category,CostPrice,SellingPrice, cast (AVG(SellingPrice) OVER(PARTITION BY CATEGORY) as decimal(10,2) )AS Cat_Avg_Selling_price
from Products)
select *
from cte 
where SellingPrice > Cat_Avg_Selling_price
