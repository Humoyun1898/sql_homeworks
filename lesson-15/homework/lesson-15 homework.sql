----EASY LEVEL TASKS --------

--1.Create a numbers table using a recursive query from 1 to 1000.
with cte as (select 1 as Number
			union all
			select Number + 1
			from cte
			where Number < 1000)
select *
from cte

--2.Write a query to find the total sales per employee using a derived table.(Sales, Employees)
select e.EmployeeID,e.FirstName,e.LastName,dt.Total_sales
from (select EmployeeID, sum(SalesAmount) as Total_sales
	from Sales 
	group by EmployeeID) as dt
join Employees as e
on dt.EmployeeID = e.EmployeeID

--3.Create a CTE to find the average salary of employees.(Employees)
with cte as (select avg(Salary) as Average_salary
			from Employees)
select average_salary
from cte

--4.Write a query using a derived table to find the highest sales for each product.(Sales, Products)
select p.ProductName,ISNULL(dt.Max_sales,0) as Highest_sales
from Products as p
left join (select ProductID,max(SalesAmount) as Max_sales
	from Sales
	group by ProductID) as dt
on p.ProductID = dt.ProductID

--5.Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.
with cte as(select 1 as number
			union all
			select number*2
			from cte
			where number < 1000000)
select *
from cte

--6.Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
with cte as (select EmployeeID, count(salesid) as Number_of_Sales
			from Sales
			group by EmployeeID)
select e.EmployeeID,e.FirstName,e.LastName,cte.Number_of_Sales
from Employees as e
left join cte 
on e.EmployeeID = cte.EmployeeID
where Number_of_sales > 5

--7.Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)
with cte as (select ProductID, isnull(sum(SalesAmount),0)  as Total_sales
			from Sales
			group by ProductID
			having sum(SalesAmount) > 500)
select p.ProductID,p.ProductName,cte.Total_sales
from Products as p
left join cte
on cte.ProductID = p.ProductID

--8.Create a CTE to find employees with salaries above the average salary.(Employees)
select *
from Employees
where Salary > (select avg(salary) from Employees)

----MEDIUM LEVEL TASKS--------
--1.Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
select e.FirstName,e.LastName,dt1.Number_of_orders
from Employees as e
join(select top 5 EmployeeID, dt.Number_of_orders
	from	(select EmployeeID, count(*) as Number_of_orders
			from Sales
			group by EmployeeID) as dt
	order by Number_of_orders desc) as dt1
on e.EmployeeID = dt1.EmployeeID

--2.Write a query using a derived table to find the sales per product category.(Sales, Products)
select p.CategoryID, isnull(sum(Total_sales),0) as Sales_per_Category
from Products as p
left join (select ProductID,sum(SalesAmount) as Total_sales
			from Sales
			group by ProductID) as dt
on p.ProductID = dt.ProductID
group by p.CategoryID

--3.Write a script to return the factorial of each value next to it.(Numbers1)
with cte as (select Number, 1 as Current_value, 1 as Factorial
			from Numbers1
			union all
			select number,Current_value + 1,(Current_value + 1)*Factorial
			from cte
			where Current_value + 1 <= Number)
select number, max(factorial) as Factorial
from cte
group by number

--4.This script uses recursion to split a string into rows of substrings for each character in the string.(Example)
DECLARE @start INT;
SET @start = 1;

WITH cte AS (
    SELECT id, string, SUBSTRING(string, @start, 1) AS character, @start AS position
    FROM Example
    WHERE @start <= LEN(string)
    
    UNION ALL
    
    SELECT e.id, e.string, SUBSTRING(e.string, cte.position + 1, 1) AS character, cte.position + 1
    FROM cte
    INNER JOIN Example e ON e.id = cte.id
    WHERE cte.position + 1 <= LEN(e.string)
)
SELECT id, string, character
FROM cte
WHERE character IS NOT NULL;

--5.Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)
WITH CTE AS (select FORMAT(SaleDate,'MM.yyyy') as Month, sum(SalesAmount) as Total_sales
			from sales
			group by FORMAT(SaleDate,'MM.yyyy') ),
CTE2 AS		(select Month,Total_Sales, LAG(Total_sales,1,0) over(order by Month) as Previous_month_sales
			from cte)
select Month,Total_sales,Previous_month_sales, Total_sales - Previous_month_sales as Difference
from cte2

--6.Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)
select e.FirstName,e.LastName
from Employees as e
join
(select EmployeeID
from (select EmployeeID,datepart(quarter,SaleDate) as Quarter ,SUM(SalesAmount) as Total_sales
		from Sales
		group by EmployeeID,datepart(quarter,SaleDate) ) as dt
where Total_sales > 45000
group by EmployeeID
having count(distinct Quarter) = 4) as dt2
on e.EmployeeID = dt2.EmployeeID

-----HARD LEVEL TASKS-----------
--1.This script uses recursion to calculate Fibonacci numbers
with fibonacce_cte as (select 1 as n, 0 as fib_current, 1 as fib_next
						union all
						select n+1, fib_next, fib_current+fib_next
						from fibonacce_cte
						where n<20)
select fib_next
from fibonacce_cte

--2.Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)
select *
from FindSameCharacters
where len(vals) > 1 and replace(vals,left(vals,1),'') = ''

--3.Create a numbers table that shows all numbers 1 through n and their order gradually increasing by the next number in the sequence.(Example:n=5 | 1, 12, 123, 1234, 12345)
DECLARE @n INT = 5;

WITH cte AS (
    SELECT 1 AS n, CAST('1' AS VARCHAR(MAX)) AS increase
    UNION ALL
    SELECT n + 1, increase + CAST(n + 1 AS VARCHAR)
    FROM cte
    WHERE n < @n
)
SELECT *
FROM cte;

--4.Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)
with cte as (select Employeeid,format(saledate,'MM.yyyy') as months, sum(SalesAmount) as Total_sales
			from Sales
			group by Employeeid,format(saledate,'MM.yyyy') ),
cte2 as		(select EmployeeID, months, Total_sales, DENSE_RANK() over (order by months desc) as dr
			from cte),
cte3 as     (select EmployeeID,months,Total_sales
			from cte2
			where dr<=6),
cte4 as		(select EmployeeID,sum(Total_sales) as Total_sales, DENSE_RANK() over (order by Sum(Total_sales) desc) as dr
			from cte3
			group by EmployeeID)
select e.FirstName,e.LastName,cte4.Total_sales
from cte4
join Employees as e
on cte4.EmployeeID = e.EmployeeID
where dr = 1

--5.Write a T-SQL query to remove the duplicate integer values present in the string column. Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)
WITH NumberSource AS (
    SELECT TOP 100 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects
),
Base AS (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RowNum,
        Pawanname,
        Pawan_slug_Name
    FROM RemoveDuplicateIntsFromNames
),
SplitChars AS (
    SELECT 
        b.RowNum,
        b.Pawanname,
        b.Pawan_slug_Name,
        SUBSTRING(b.Pawanname, n.n, 1) AS CharVal,
        n.n AS CharPos
    FROM Base b
    JOIN NumberSource n ON n.n <= LEN(b.Pawanname)
),
DigitFrequency AS (
    SELECT RowNum, CharVal
    FROM SplitChars
    WHERE CharVal LIKE '[0-9]'
    GROUP BY RowNum, CharVal
    HAVING COUNT(*) > 1
),
FilteredChars AS (
    SELECT 
        s.RowNum,
        s.CharVal,
        s.CharPos
    FROM SplitChars s
    LEFT JOIN DigitFrequency d 
        ON s.RowNum = d.RowNum AND s.CharVal = d.CharVal
    WHERE s.CharVal NOT LIKE '[0-9]' OR d.CharVal IS NOT NULL
),
Reconstructed AS (
    SELECT 
        RowNum,
        STRING_AGG(CharVal, '') WITHIN GROUP (ORDER BY CharPos) AS CleanedPawanname
    FROM FilteredChars
    GROUP BY RowNum
)
SELECT 
    b.Pawanname AS OriginalName,
    b.Pawan_slug_Name,
    COALESCE(r.CleanedPawanname, '') AS CleanedName
FROM Base b
LEFT JOIN Reconstructed r ON b.RowNum = r.RowNum;

select *
from RemoveDuplicateIntsFromNames
