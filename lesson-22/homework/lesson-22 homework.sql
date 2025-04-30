--1.Compute Running Total Sales per Customer
select sale_id,customer_id,customer_name,total_amount, sum(Total_amount) over (partition by customer_id order by order_date) as Running_total
from sales_data

--2.Count the Number of Orders per Product Category
select distinct product_category, count(*) over (partition by product_category) as Number_of_Orders
from sales_data

--3.Find the Maximum Total Amount per Product Category
select distinct product_category, max(total_amount) over (partition by product_category) as cat_max_total_amount
from sales_data

--4.Find the Minimum Price of Products per Product Category
select distinct product_category, min(unit_price) over (partition by product_category) as cat_min_price
from sales_data

--5.Compute the Moving Average of Sales of 3 days (prev day, curr day, next day)
select *, cast (avg(total_amount) over (order by order_date rows between 1 preceding and 1 following) as decimal(10,2) ) as Moving_average 
from sales_data

--6.Find the Total Sales per Region
select distinct region,sum(total_amount) over (partition by region) as Total_sales
from sales_data

--7.Compute the Rank of Customers Based on Their Total Purchase Amount
with cte as (select customer_id,customer_name, sum(total_amount) as Total_Purchase_Amount
			from sales_data
			group by customer_id,customer_name)
select *, DENSE_RANK() over (order by Total_Purchase_Amount desc) as dense_rank
from cte

--8.Calculate the Difference Between Current and Previous Sale Amount per Customer
with cte as (select sale_id, customer_id, customer_name, product_name, order_date,total_amount, lag(Total_amount,1,0) over (partition by customer_id order by order_date) as Previous_day_sales
from sales_data)
select *, total_amount - previous_day_sales as difference
from cte

--9.Find the Top 3 Most Expensive Products in Each Category
with cte as (select distinct product_category,product_name,unit_price, DENSE_RANK() over (partition by product_category order by unit_price desc) as dense_ranking
from sales_data)
select *
from cte
where dense_ranking <4
order by Product_category, dense_ranking 

--10.Compute the Cumulative Sum of Sales Per Region by Order Date
select *, sum(total_amount) over (partition by region order by order_date) as Cumultative_sum
from sales_data

--11.Compute Cumulative Revenue per Product Category
select *, sum(total_amount) over (partition by product_category order by order_date) as cumultative_revenue
from sales_data

--12.Here you need to find out the sum of previous values. Please go through the sample input and expected output.
select *, sum(id) over (order by (select null) rows between unbounded preceding and current row) as SumPreValues
from numbers

--13. Sum of Previous Values to Current Value
with cte as (select value, lag(value,1,0) over (order by (select null) ) as Previous_values
			from OneColumn)
select *, Value + Previous_values as Previous_current_row
from cte 

--14.Generate row numbers for the given data. The condition is that the first row number for every partition should be odd number.For more details please check the sample input and expected output.
with ranking as(select *,ROW_NUMBER() over (partition by id order by Vals) as rn
from Row_Nums )
select id,Vals,rn*2-1 as needed_ranking
from ranking 

WITH Partitioned AS (
    SELECT 
        Id,
        Vals,
        ROW_NUMBER() OVER (PARTITION BY Id ORDER BY Vals) AS rn,
        DENSE_RANK() OVER (ORDER BY Id) AS partition_rank
    FROM Row_Nums
),
StartingOdds AS (
    SELECT 
        *,
        (partition_rank * 2) - 1 AS start_odd
    FROM Partitioned
)
SELECT 
    Id,
    Vals,
    start_odd + rn - 1 AS RowNumber
FROM StartingOdds
ORDER BY RowNumber;

--15.Find customers who have purchased items from more than one product_category
with cte as (select customer_id,customer_name,product_category, dense_rank() over (partition by customer_id order by product_category) as dr
			from sales_data)
select customer_id,customer_name
from cte 
where dr>1

WITH customer_totals AS (
    SELECT 
        customer_id,
        customer_name,
        region,
        SUM(total_amount) AS total_spent
    FROM sales_data
    GROUP BY customer_id, customer_name, region
),

region_averages AS (
    SELECT 
        region,
        CAST(AVG(total_spent) AS DECIMAL(10,2)) AS avg_spent
    FROM customer_totals
    GROUP BY region
)

SELECT 
    ct.customer_id,
    ct.customer_name,
    ct.region,
    ct.total_spent,
    ra.avg_spent AS region_avg_spent
FROM customer_totals ct
JOIN region_averages ra
    ON ct.region = ra.region
WHERE ct.total_spent > ra.avg_spent;

--17.Rank customers based on their total spending (total_amount) within each region. If multiple customers have the same spending, they should receive the same rank (dense ranking).
with cte as (select customer_id,customer_name,region,sum(total_amount) as Total_spending
			from sales_data
			group by customer_id,customer_name,region)
select *, DENSE_RANK() over (partition by region order by total_spending desc) as ranking
from cte

--18.Calculate the running total (cumulative_sales) of total_amount for each customer_id, ordered by order_date.
with cte as (select customer_id,customer_name, order_date,total_amount, sum(total_amount) as total
from sales_data
group by customer_id,customer_name, order_date,total_amount)
select customer_id,total_amount, sum(total) over (partition by customer_id order by order_date) as running_total
from cte

--19.Calculate the sales growth rate (growth_rate) for each month compared to the previous month.
with cte as (select FORMAT(order_date, 'yyyy-MM') AS month_year, sum(Total_amount) as Total_sales
			from sales_data
			group by FORMAT(order_date, 'yyyy-MM') ), cte1 as
(select month_year, Total_sales, lag(total_sales,1,0) over (order by month_year) as Previous_sales
from cte)

select *, Total_sales - Previous_sales as Growth
from cte1

--20.Identify customers whose total_amount is higher than their last order''s total_amount.(Table sale_data)
with cte as (select customer_id,customer_name, total_amount, lag(total_amount,1) over (partition by customer_id order by order_date) as Previous_sales
			from sales_data)
select *
from cte
where Previous_sales is not null and total_amount > Previous_sales

--21.Identify Products that prices are above the average product price
with cte as (select Product_name,unit_price, cast (avg(unit_price) over () as decimal(10,2) ) as average_unit_price
			from sales_data)
select *
from cte
where unit_price > average_unit_price

--22.In this puzzle you have to find the sum of val1 and val2 for each group and put that value at the beginning of the group in the new column.
--The challenge here is to do this in a single select. For more details please see the sample input and expected output.
select *, case
			when row_number() over (partition by grp order by id) = 1 then sum(val1 + val2) over (partition by grp)
			else null
		end	as Tot
from MyData

--23.Here you have to sum up the value of the cost column based on the values of Id. For Quantity if values are different then we have to add those values.Please go through the sample input and expected output for details.
with cte as (select ID, Cost, Quantity,
			row_number() over (partition by id, Quantity order by Quantity) as rn
			from TheSumPuzzle)
select ID, sum(Cost) as Cost, sum(case when rn = 1 then Quantity else 0 end) as Quantity
from cte
group by ID

--24.You have to write a query that will give us sum of tyze for each Z. Detailed logic is given below
SELECT 
    a.Level,
    a.TyZe,
    a.Result,
    CASE 
        WHEN a.Result = 'Z' THEN b.Results
        ELSE 0
    END AS Results
FROM testSuXVI a
OUTER APPLY (
    SELECT SUM(b.TyZe) AS Results
    FROM testSuXVI b
    WHERE 
        b.Result IN ('X', 'Z') AND
        b.Level <= a.Level AND
        b.TyZe <= a.TyZe
) b
ORDER BY a.Level, a.TyZe;

--25.In this puzzle you need to generate row numbers for the given data. The condition is that the first row number for every partition should be even number.For more details please check the sample input and expected output.

WITH Partitioned AS (
    SELECT 
        Id,
        Vals,
        ROW_NUMBER() OVER (PARTITION BY Id ORDER BY Vals) AS rn,
        DENSE_RANK() OVER (ORDER BY Id) AS partition_rank
    FROM Row_Nums
),
StartingEvens AS (
    SELECT 
        *,
        partition_rank * 2 AS start_even  -- Ensure the first row starts at even number
    FROM Partitioned
)
SELECT 
    Id,
    Vals,
    start_even + rn - 1 AS RowNumber
FROM StartingEvens
ORDER BY RowNumber;
