--1. Find customers who purchased at least one item in March 2024 using EXISTS
select distinct s1.CustomerName
from #Sales as s1 where exists (select 1 from #Sales as s2 where s2.CustomerName = s1.CustomerName and month(SaleDate) = 3)

--2. Find the product with the highest total sales revenue using a subquery.
with cte as (select *, (select sum(Quantity*Price) from #Sales as s2 where s2.Product = s1.Product) as Revenue
from #Sales as s1)
select distinct Product, Revenue
from cte
where Revenue = (select max(dt.Revenue)
from (select Product, sum(Quantity*Price) as Revenue
		from #Sales
		group by Product) as dt)

--3. Find the second highest sale amount using a subquery
select top 1 Sales_amount
from (select top 2 (Quantity*Price) as Sales_amount
		from #Sales
		order by (Quantity*Price) desc) dt
order by Sales_amount asc

--4. Find the total quantity of products sold per month using a subquery
select distinct DATENAME(month, saledate) as Month, (select sum(quantity) from #Sales as s2 where datename(month,s2.SaleDate) = DATENAME(MONTH, s1.SaleDate) ) as Total_quantity
from #Sales as s1

--5. Find customers who bought same products as another customer using EXISTS
select distinct s1.CustomerName
from #Sales as s1
where exists (select 1 from #Sales as s2 where s2.Product = s1.Product and s1.CustomerName != s2.CustomerName)

--6. Return how many fruits does each person have in individual fruit level
select *
from Fruits
pivot (count(fruit) for [fruit] in ([Apple], [Orange], [Banana]) ) as pivots

--7. Return older people in the family with younger ones
select f1.ParentId, f2.ChildID
from Family as f1
join Family as f2
on f1.ParentId < f2.ChildID
order by f1.ParentId

--8. Write an SQL statement given the following requirements. For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas
select *
from #Orders as o1
where CustomerID in (select distinct CustomerID
					from #Orders as o2
					where o2.DeliveryState = 'CA')
and o1.DeliveryState = 'TX'

--9. Insert the names of residents if they are missing
select *,	case
				when charindex(fullname,address) = 0 then address + ' name=' + fullname
				else address
			end as corrected_version
from #residents

-- 10. Write a query to return the route to reach from Tashkent to Khorezm. The result should include the cheapest and the most expensive routes
WITH Paths AS (
    
    SELECT 
        r1.DepartureCity,
        r1.ArrivalCity,
        CAST(r1.DepartureCity + ' - ' + r1.ArrivalCity AS VARCHAR(MAX)) AS Route,
        r1.Cost
    FROM #Routes r1
    WHERE r1.DepartureCity = 'Tashkent' 
      AND r1.ArrivalCity = 'Samarkand'

    UNION ALL

    SELECT 
        p.DepartureCity,
        r2.ArrivalCity,
        CAST(p.Route + ' - ' + r2.ArrivalCity AS VARCHAR(MAX)) AS Route,
        p.Cost + r2.Cost
    FROM Paths p
    JOIN #Routes r2 ON p.ArrivalCity = r2.DepartureCity
    WHERE r2.ArrivalCity IN ('Khorezm', 'Bukhoro')
)

SELECT Route, Cost
FROM Paths
WHERE ArrivalCity = 'Khorezm'
ORDER BY Cost ASC;

--11. Rank products based on their order of insertion.
select *, (select count(*) from #RankingPuzzle as r2 where r2.ID <= r1.ID and r2.Vals = 'Product') as order_insertion
from #RankingPuzzle as r1

--12. You have to return Ids, what number of the letter would be next if inserted, the maximum length of the consecutive occurence of the same digit
WITH Numbered AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Id ORDER BY (SELECT NULL)) AS rn
    FROM #Consecutives
),
Groups AS (
    SELECT n.*,
           n.Vals 
           - LAG(n.Vals) OVER (PARTITION BY n.Id ORDER BY n.rn) AS diff
    FROM Numbered n
),
GroupStart AS (
    SELECT g.*,
           SUM(CASE WHEN diff <> 0 OR diff IS NULL THEN 1 ELSE 0 END)
               OVER (PARTITION BY g.Id ORDER BY g.rn) AS grp
    FROM Groups g
),
ConsecutiveCounts AS (
    SELECT Id, grp, Vals, COUNT(*) AS ConsecutiveLength
    FROM GroupStart
    GROUP BY Id, grp, Vals
),
MaxConsecutive AS (
    SELECT Id, MAX(ConsecutiveLength) AS MaxConsecutive
    FROM ConsecutiveCounts
    GROUP BY Id
),
LastVals AS (
    SELECT Id, Vals AS NextValue
    FROM (
        SELECT Id, Vals,
               ROW_NUMBER() OVER (PARTITION BY Id ORDER BY (SELECT NULL) DESC) AS rn
        FROM #Consecutives
    ) t
    WHERE rn = 1
)
SELECT l.Id, l.NextValue, m.MaxConsecutive
FROM LastVals l
JOIN MaxConsecutive m ON l.Id = m.Id
ORDER BY l.Id;

--13.Find employees whose sales were higher than the average sales in their department
with cte as (select *, (select avg(salesamount) from #EmployeeSales as e2 where e2.Department = e1.Department) as dep_avg_sales
from #EmployeeSales as e1)
select *
from cte
where SalesAmount > dep_avg_sales

--14. Find employees who had the highest sales in any given month using EXISTS
SELECT e1.*
FROM #EmployeeSales e1
WHERE not EXISTS (
    SELECT 1
    FROM #EmployeeSales e2
    WHERE e2.SalesMonth = e1.SalesMonth
      AND e2.SalesAmount > e1.SalesAmount
);

--15. Find employees who made sales in every month using NOT EXISTS
SELECT e1.EmployeeID, e1.EmployeeName
FROM #EmployeeSales e1
GROUP BY e1.EmployeeID, e1.EmployeeName
HAVING NOT EXISTS (
    SELECT 1
    FROM (SELECT DISTINCT SalesMonth FROM #EmployeeSales) AS all_months
    WHERE NOT EXISTS (
        SELECT 1
        FROM #EmployeeSales e2
        WHERE e2.EmployeeID = e1.EmployeeID
          AND e2.SalesMonth = all_months.SalesMonth
    )
);

--16. Retrieve the names of products that are more expensive than the average price of all products.
select *, (select avg(price) from Products) as products_avg_price
from Products
where price > (select avg(price) from Products) 

--17.Find the products that have a stock count lower than the highest stock count.
select *
from Products
where stock < (select max(stock) from Products)

--18.Get the names of products that belong to the same category as 'Laptop'.
select *
from Products as p1
where exists (select 1 from Products as p2 where p2.Category = p1.Category and p2.Name = 'Laptop')

--19.Retrieve products whose price is greater than the lowest price in the Electronics category.
select *
from Products
where price > (select min(price)
				from Products
				where Category = 'Electronics')

--20. Find the products that have a higher price than the average price of their respective category.
with cte as (select ProductID,Name,Category,Price,Stock,(select avg(price) from Products as p2 where p2.Category = p1.Category ) as cat_avg_price
from Products as p1)
select *
from cte
where Price > cat_avg_price

--21. Find the products that have been ordered at least once.
 with cte as(select ProductID
			from Orders o1
			where exists (select 1 from Orders as o2 where o2.ProductID = o1.ProductID) )
select Products.Name
from cte
join Products
on cte.ProductID = PRODUCTs.ProductID

--22. Retrieve the names of products that have been ordered more than the average quantity ordered.
with cte as (select ProductID
			from Orders
			where Quantity > (select avg(quantity) from Orders) )
select PRODUCTs.Name
from cte
join Products
on cte.ProductID = Products.ProductID

--23. Find the products that have never been ordered.
select p.Name
from Products as p
left join Orders as o
on p.ProductID = o.ProductID
where o.OrderID is null

--24. Retrieve the product with the highest total quantity ordered.
 with cte as (select productid, sum(Quantity) as Total_quant
				from Orders 
				group by ProductID
				having sum(Quantity) =  (select max(Total_quantity)
										from (select ProductID, sum(Quantity) as Total_quantity
										from Orders
										group by ProductID) as dt ) )
select Products.Name,Products.Category,cte.Total_quant
from cte
join Products
on cte.ProductID = Products.ProductID

--25. Find the products that have been ordered more times than the average number of orders placed.
 with cte as (select ProductID, count(ProductID) as Times_ordered
				from Products
				group by ProductID
				having count(ProductID) > (select avg(Times_ordered)
											from (select ProductID, count(Productid) as Times_ordered
												from Orders
												group by ProductID) as dt) )
select p.Name, cte.Times_ordered
from cte
join Products as p
on cte.ProductID = p.ProductID
