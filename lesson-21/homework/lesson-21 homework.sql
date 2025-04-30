--1.Write a query to assign a row number to each sale based on the SaleDate.
select *, row_number() over (order by SaleDate) as rn
from ProductSales

--2.Write a query to rank products based on the total quantity sold (use DENSE_RANK())
with cte as (select ProductName, sum(Quantity) as Total_quantity
			from ProductSales
			group by ProductName)
select *,DENSE_RANK() over (order by Total_quantity) as dense_ranking
from cte

--3.Write a query to identify the top sale for each customer based on the SaleAmount.
with cte as (select SaleID,CustomerID, ProductName, SaleDate ,SaleAmount*Quantity as Sale_Amount, row_number() over (partition by customerID order by SaleAmount*Quantity desc) as Sale_rank
			from ProductSales)
select SaleID, CustomerID ,ProductName, SaleDate, Sale_Amount
from cte
where Sale_rank = 1

--4.Write a query to display each sale's amount along with the next sale amount in the order of SaleDate using the LEAD() function
select SaleID,ProductName,SaleDate,SaleAmount, lead(SaleAmount,1,0) over (order by SaleDate) as Next_day_data
from ProductSales

--5.Write a query to display each sale's amount along with the previous sale amount in the order of SaleDate using the LAG() function
select SaleID,ProductName,SaleDate,SaleAmount, lag(SaleAmount,1,0) over (order by SaleDate) as Previos_day_data
from ProductSales

--6.Write a query to rank each sale amount within each product category.
select *, dense_rank() over (partition by ProductName order by SaleAmount) as Product_category_rank
from ProductSales

--7.Write a query to identify sales amounts that are greater than the previous sale's amount
with cte as (select SaleID,ProductName,SaleDate,SaleAmount,Quantity,lag(SaleAmount,1,0) over (order by SaleDate) as Previous_Day_data
			from ProductSales)
select *
from cte
where SaleAmount > Previous_day_Data

--8.Write a query to calculate the difference in sale amount from the previous sale for every product
with cte as (select SaleID,ProductName,SaleDate,SaleAmount,Quantity,lag(SaleAmount,1,0) over (order by SaleDate) as Previous_Day_data
			from ProductSales)
select *,SaleAmount - Previous_Day_data as Difference
from cte

--9.Write a query to compare the current sale amount with the next sale amount in terms of percentage change.
with cte as (select SaleID,ProductName,SaleDate,SaleAmount,Quantity,lead(SaleAmount,1,0) over (order by SaleDate) as Next_Day_data
			from ProductSales)
select *,cast( round((next_day_data-SaleAmount)/SaleAmount * 100,2) as decimal(10,2) ) as Difference_in_Sales
from cte

--10.Write a query to calculate the ratio of the current sale amount to the previous sale amount within the same product.
with cte as (select SaleID,ProductName,SaleDate,SaleAmount,Quantity,lag(SaleAmount,1) over (partition by ProductName order by SaleDate) as Previous_Day_data
			from ProductSales)
select *,case 
			when Previous_Day_data is null then null 
			else  round(SaleAmount/Previous_Day_data, 2) 
		end as Ratio
from cte

--11.Write a query to calculate the difference in sale amount from the very first sale of that product.
select *, FIRST_VALUE(SaleAmount) over (partition by ProductName order by SaleDate) as First_sale
from ProductSales

--12.Write a query to find sales that have been increasing continuously for a product (i.e., each sale amount is greater than the previous sale amount for that product).
with cte as (select SaleID,ProductName,SaleDate,SaleAmount,Quantity,lag(SaleAmount,1) over (partition by ProductName order by SaleDate) as Previous_Day_data
			from ProductSales)
select *
from cte
where SaleAmount > Previous_day_data

--13.Write a query to calculate a "closing balance" for sales amounts which adds the current sale amount to a running total of previous sales.
select *,sum(SaleAmount) over( order by SaleDate) as Running_total
from ProductSales

--14.Write a query to calculate the moving average of sales amounts over the last 3 sales.
select *, avg(SaleAmount) over (order by SaleDate rows between 2 preceding and current row) as Moving_average_3_days
from ProductSales

--15.Write a query to show the difference between each sale amount and the average sale amount.
select SaleID,ProductName,SaleDate,SaleAmount,  cast (avg(SaleAmount) over() as decimal(10,2) ) as Average , cast (SaleAmount - avg(SaleAmount) over() as decimal(10,2) ) as Difference
from ProductSales

--16.Find Employees Who Have the Same Salary Rank
with cte as (select EmployeeID,Name,Department,Salary,HireDate, dense_rank() over (order by Salary) as ranking
from Employees1)
select *
from cte 
where ranking in (select ranking
				from cte
				group by ranking
				having count(ranking) > 1)
				
--17.Identify the Top 2 Highest Salaries in Each Department
with cte as(select *, DENSE_RANK() over (partition by department order by Salary desc) as dept_sal_rank
			from Employees1)
select *
from cte 
where dept_sal_rank <=2

--18.Find the Lowest-Paid Employee in Each Department
with cte as (select *, DENSE_RANK() over (partition by department order by Salary) as dept_salary_rank
			from Employees1)
select *
from cte
where dept_salary_rank = 1

--19.Calculate the Running Total of Salaries in Each Department
select *, sum(Salary) over (partition by department order by HireDate) as Running_Total 
from Employees1

--20.Find the Total Salary of Each Department Without GROUP BY
with cte as (select EmployeeID,Name,Department,Salary,HireDate, sum(Salary) over (partition by department order by HireDate) as Running_Total 
from Employees1), cte2 as (select EmployeeID,Name,Department,Salary,HireDate,Running_total, rank() over (Partition by Department order by Running_total desc) as rank from cte)
select Department, Running_Total as Total_salary
from cte2
where rank = 1

--21.Calculate the Average Salary in Each Department Without GROUP BY
select distinct department, cast (avg(salary) over (partition by Department) as decimal(10,2) ) as Average_salary
from Employees1

--22.Find the Difference Between an Employee’s Salary and Their Department’s Average
with cte as (select EmployeeID,Name,Department,Salary, cast (avg(salary) over (partition by Department) as decimal(10,2) ) as Department_average_Salary
			from Employees1)
select *
from cte
where Salary > Department_average_salary

--23.Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)
select *, cast(avg(salary) over (order by (select null) rows between 1 preceding and 1 following) as decimal(10,2) ) as Moving_average_over_3_days
from Employees1

--24.Find the Sum of Salaries for the Last 3 Hired Employees
with cte as (select EmployeeID,Name,Department,Salary,HireDate, DENSE_RANK() over (order by HireDate desc) as Hire_date_ranks
from Employees1)
select sum(salary) as Total_salary_of_last_3_hireds
from cte
where Hire_date_ranks <3
