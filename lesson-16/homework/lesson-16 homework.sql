--1. Write an SQL Statement to de-group the following data.
with cte as (select Product, Quantity, 1 as current_quantity
			from Grouped
			union all
			select Product, Quantity, current_quantity + 1
			from cte
			where current_quantity + 1 <= Quantity)
SELECT Product, 1 AS Quantity
FROM cte
ORDER BY Product

--2. You must provide a report of all distributors and their sales by region.
--If a distributor did not have any sales for a region, rovide a zero-dollar value for that day. Assume there is at least one sale for each region
with cte1 as (select distinct distributor
			from #RegionSales),
cte2 as (select distinct region 
		from #RegionSales),
cte3 as (select cte1.Distributor, CTE2.Region
		from cte1
		cross join cte2)
select *
from cte3
left join #RegionSales as rs
on cte3.Distributor = rs.Distributor and cte3.Region=rs.Region

--3. Find managers with at least five direct reports
select name
from Employee
where managerId is null

--4. Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.
select p.Product_name, SUM(UNIT) AS Total_Units
from Orders as o
left join Products as p
on o.product_id = p.product_id
where month(order_date) = '2' and year(order_date) = '2020'
group by p.Product_name
having sum(unit) >= 100

--5. Write an SQL statement that returns the vendor from which each customer has placed the most orders
with cte as (select OrderID,CustomerID,count,vendor,max(count) over (partition by customerID)  AS Max_count
			from Orders)
select CustomerID, Vendor
from cte
where count = Max_count

--6. You will be given a number as a variable called @Check_Prime check if this number is prime then return 'This number is prime' else eturn 'This number is not prime
create function check_prime (@check_prime int)
returns varchar(50)
as 
begin 
	declare @i int = 2
	declare @result varchar(50)

	if @Check_Prime < @i
	begin
		set @result = 'This is not prime'
		return @result
	end

	while @i <= sqrt(@check_prime)
	begin 
		if @Check_Prime%@i = 0
		begin
			set @result = 'This is not prime'
			return @result
		end
		set @i = @i + 1
	end
	 SET @Result = 'This number is prime';
    RETURN @Result;
end

select * from check_prime (55)

--7. Write an SQL query to return the number of locations,in which location most signals sent, and total number of signal for each device from the given table.
with cte1 as (select Device_id, count(distinct locations) as Number_of_locations,count(locations) as no_of_signals
			from Device
			group by Device_id),
cte2 as (select device_id,locations,count(locations) as Number_of_locations
			from device
			group by device_id,locations),
cte3 as     (select device_id,locations,Number_of_locations, max(number_of_locations) over (partition by device_id) as max_loc
			from cte2),
cte4 as     (select device_id,locations
			from cte3
			where Number_of_locations = max_loc)
select cte1.device_id, cte1.number_of_locations as no_of_location,cte4.locations max_signal_location, cte1.no_of_signals
from cte1
join cte4
on cte1.device_id = cte4.device_id


--8. Write a SQL to find all Employees who earn more than the average salary in their corresponding department. Return EmpID, EmpName,Salary in your output
with cte as(select EmpID,EmpName,Salary,DeptID, avg(salary) over (partition by DeptID) AS Dept_avg_salary
			from Employee)
select *
from cte
where Salary>Dept_avg_salary


--9. You are part of an office lottery pool where you keep a table of the winning lottery numbers along with a table of each ticket’s chosen numbers. If a ticket has some but not all the winning numbers, you win $10. 
--If a ticket has all the winning numbers, you win $100. Calculate the total winnings for today’s drawing.
with cte as (select t.TicketID,t.Number,wn.Number as match
			from Tickets as t
			left join WinningNumbers as wn
			on t.Number = wn.Number),
cte2 as     (select ticketID, count(Number) as Number, count(match) as Match
			from cte
			group by ticketID
			having count(match)>0)
select	sum(case
		when number = match then 100
		else 10
		end) as Prize
from cte2


--10.Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only and both mobile and desktop together for each date.
SELECT Spend_date, 'Mobile' AS Platform, 
       COUNT(DISTINCT User_id) AS Total_users,
       SUM(Amount) AS Total_Amount
FROM Spending s1
WHERE Platform = 'Mobile'
  AND NOT EXISTS (
    SELECT 1 FROM Spending s2 
    WHERE s2.User_id = s1.User_id AND s2.Spend_date = s1.Spend_date AND s2.Platform = 'Desktop'
)
GROUP BY Spend_date

UNION ALL

-- Get users who used only Desktop
SELECT Spend_date, 'Desktop' AS Platform, 
       COUNT(DISTINCT User_id) AS Total_users,
       SUM(Amount) AS Total_Amount
FROM Spending s1
WHERE Platform = 'Desktop'
  AND NOT EXISTS (
    SELECT 1 FROM Spending s2 
    WHERE s2.User_id = s1.User_id AND s2.Spend_date = s1.Spend_date AND s2.Platform = 'Mobile'
)
GROUP BY Spend_date

UNION ALL

-- Get users who used both Mobile and Desktop
SELECT s.Spend_date, 'Both' AS Platform,
       COUNT(DISTINCT s.User_id) AS Total_users,
       SUM(s.Amount) AS Total_Amount
FROM Spending s
JOIN Spending m ON s.User_id = m.User_id AND s.Spend_date = m.Spend_date
WHERE s.Platform = 'Desktop' AND m.Platform = 'Mobile'
GROUP BY s.Spend_date;
