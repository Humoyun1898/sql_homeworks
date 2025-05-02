--### 1. Create a temporary table named MonthlySales to store the total quantity sold and total revenue for each product in the current month.--**Return: ProductID, TotalQuantity, TotalRevenue**
 select *
 from sales
 select *
 from products

 create table #MonthlySales (ProductID INT, Total_Quantity int, Total_Revenue int)
 insert into #MonthlySales (ProductID, Total_Quantity, Total_Revenue)
 select p.ProductID, isnull(sum(s.Quantity),0) as Total_Quantity, isnull(sum(p.Price*s.Quantity),0) as Total_Revenue
 from Products as p
 left join Sales as s
 on p.ProductID = s.ProductID
 group by p.ProductID
 
 select *
 from #MonthlySales

 --### 2. Create a view named vw_ProductSalesSummary that returns product info along with total sales quantity across all time.**Return: ProductID, ProductName, Category, TotalQuantitySold**
 create view vw_ProductSalesSummary
 as
 select p.ProductID,p.ProductName,p.Category, isnull(sum(Quantity),0) as Total_quantity
 from Products as p
 left join Sales as s
 on p.ProductID = s.ProductID
 group by p.ProductID,p.ProductName,p.Category

 select *
 from vw_ProductSalesSummary
 
-- ### 3. Create a function named fn_GetTotalRevenueForProduct(@ProductID INT)**Return: total revenue for the given product ID**
create function fn_GetTotalRevenueForProduct (@ProductID INT)
returns table
as
return
select p.ProductID,sum(QuantiTy*Price) as Total_revenue
 from Products as p
 left join Sales as s
 on p.ProductID = s.ProductID
 where p.ProductID = @ProductID
 group by p.ProductID

 select * from fn_GetTotalRevenueForProduct(5)
 
 --### 4. Create an function fn_GetSalesByCategory(@Category VARCHAR(50))**Return: ProductName, TotalQuantity, TotalRevenue for all products in that category.**
 alter function fn_GetSalesByCategory(@Category VARCHAR(50))
 returns table
 as 
 return
 select distinct p.ProductName, sum(quantity) over (partition by Category) as Total_Quantity, sum(Quantity*Price) over (partition by Category) as Total_revenue
 from Products as p
 left join Sales as s
 on p.ProductID = s.ProductID
 where p.Category = @Category

 select * from fn_GetSalesByCategory('Electronics')

 
-- ### 5. You have to create a function that get one argument as input from user and the function should return 'Yes' if the input number is a prime number and 'No' otherwise. You can start it like this:

Create function dbo.fn_IsPrime (@Number INT)
RETURNS VARCHAR(3)
AS
BEGIN
    DECLARE @i INT = 2;

    IF @Number < 2
        RETURN 'No';

    WHILE @i <= SQRT(@Number)
    BEGIN
        IF @Number % @i = 0
            RETURN 'No';
        SET @i = @i + 1;
    END

    RETURN 'Yes';
END;
 
 
-- ### 6. Create a table-valued function named fn_GetNumbersBetween that accepts two integers as input:
 create function fn_GetNumbersBetween (@start int, @end int)
 returns table
 as
 return
 select *
 from numbers
 where number between @start and @end

 select * from fn_GetNumbersBetween 

--### 7. Write a SQL query to return the Nth highest distinct salary from the Employee table. If there are fewer than N distinct salaries, return NULL. 
create function getNthHighestSalary(@rank int)
returns table
as 
return
with cte as (select id, salary, dense_rank() over (order by salary asc) as dr
			from Employee)
select distinct salary
from cte
where dr = @rank

 
--8. Write a SQL query to find the person who has the most friends.
 
SELECT TOP 1 id, COUNT(*) AS num
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id FROM RequestAccepted
) AS AllFriends
GROUP BY id
ORDER BY num DESC;
 
 
--9. Create a View for Customer Order Summary. 
 create view vw_Customer_sales
 as
 select c.Customer_id,c.Name, count(Order_ID) as total_orders, sum(amount) as Total_amount, max(order_date) as last_order_date
 from Customers as c
 LEFT join Orders as o
 on c.Customer_Id=o.Customer_ID
 group by c.Customer_ID,c.Name

 select * from vw_Customer_sales
 
 --### 10. Write an SQL statement to fill in the missing gaps. You have to write only select statement, no need to modify the table.
 WITH FillDown AS (
    SELECT 
        RowNumber,
        TestCase
    FROM Gaps
    WHERE RowNumber = 1
    UNION ALL
    SELECT 
        g.RowNumber,
        CASE 
            WHEN g.TestCase IS NULL THEN f.TestCase
            ELSE g.TestCase
        END AS TestCase
    FROM Gaps g
    JOIN FillDown f ON g.RowNumber = f.RowNumber + 1
)
SELECT * 
FROM FillDown
ORDER BY RowNumber;
