--1.Create a stored procedure that:--Creates a temp table #EmployeeBonus.--Inserts EmployeeID, FullName (FirstName + LastName), Department, Salary, and BonusAmount into it.(BonusAmount = Salary * BonusPercentage / 100).Then, selects all data from the temp table.

ALTER procedure GET_EMPPLOYEE_BONUS
as 
begin

create table #EmployeeBonus (EmployeeID INT,FullName varchar(50),Department varchar(50),salary decimal(10,2),BonusAmount decimal(10,2) )

INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount)
select e.EmployeeID,CONCAT_WS(' ',FirstName,LastName) as Full_Name,e.Department,e.Salary,e.Salary*db.BonusPercentage/100 as Bonus_amount
from Employees as e
join DepartmentBonus as db
on e.Department =db.Department

select * from #EmployeeBonus

end

EXEC GET_EMPPLOYEE_BONUS

--2.Create a stored procedure that:--Accepts a department name and an increase percentage as parameters.--Increases salary of all employees in the given department by the given percentage.--Returns updated employees from that department.

alter procedure dp_new_salary @new_percent int,@department nvarchar(50)
as 
begin
	update DepartmentBonus
	set BonusPercentage = BonusPercentage + @new_percent
	where Department = @department

	select e.EmployeeID,e.FirstName,e.LastName,e.Department,e.Salary*d.BonusPercentage as New_salary
	from Employees as e
	join DepartmentBonus as d
	on e.Department = d.Department
end

exec dp_new_salary @new_percent = 3, @department = 'Sales'

--3.Perform a MERGE operation that:--Updates ProductName and Price if ProductID matches--Inserts new products if ProductID does not exist--Deletes products from Products_Current if they are missing in Products_New--Return the final state of Products_Current after the MERGE.

merge Products_Current as Target
using Products_New as Source

on target.ProductID = source.ProductID

when matched then
update
set target.ProductName = source.ProductName,
	target.Price = source.Price
	
when not matched by target --not in employees
then insert (ProductID, ProductName,Price) values(source.ProductID, source.ProductName,source.Price)

when not matched by source
then delete;

select *
from Products_New

--4.Each node in the tree can be one of three types:--"Leaf": if the node is a leaf node.--"Root": if the node is the root of the tree.--"Inner": If the node is neither a leaf node nor a root node.--Write a solution to report the type of each node in the tree.

SELECT 
    id,
    CASE 
        WHEN p_id IS NULL THEN 'Root'
        WHEN id NOT IN (SELECT DISTINCT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Leaf'
        ELSE 'Inner'
    END AS NodeType
FROM Tree;


--5.Find the confirmation rate for each user. If a user has no confirmation requests, the rate should be 0.
with cte1 as (select user_id, action, count(action) as numbers
from Confirmations
group by user_id, action),
cte2 as (select USER_ID, count(action) as number
		from Confirmations
		group by USER_ID),
cte3 as (select cte1.user_id, cte1.action,cte1.numbers, cte2.number
		from cte1
		join cte2
		on cte1.USER_ID = CTE2.USER_ID),
cte4 as (select s.user_id, cte3.action, case
								when action is null then 0
								when action is not null then numbers/cast (number as decimal(3,2))
								end  as ration
						
		from Signups as s
		left join cte3
		on s.user_id = cte3.user_id
		)
select*
from cte4
where cte4.action != 'timeout'

--6.Find employees with the lowest salary. Find all employees who have the lowest salary using subqueries.
select *
from Employees
where salary = (select min(salary)from Employees)

--7.Accepts a @ProductID input.Total Quantity Sold.Total Sales Amount (Quantity × Price).First Sale Date.Last Sale Date.If the product has no sales, return NULL for quantity, total amount, first date, and last date, but still return the product name.
CREATE PROCEDURE GetProductSalesSummary @ProductID INT
AS
BEGIN
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantitySold,
        SUM(s.Quantity * p.Price) AS TotalSalesAmount,
        MIN(s.SaleDate) AS FirstSaleDate,
        MAX(s.SaleDate) AS LastSaleDate
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.ProductID = @ProductID
    GROUP BY p.ProductName;
END;

exec GetProductSalesSummary @ProductID = 18
