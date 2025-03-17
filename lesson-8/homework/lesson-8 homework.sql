--------------EASY LEVEL TASKS------------
--1
select c.cust_name, o.ord_date
from customer as c
join orders as o
on c.customer_id = o.customer_id

--2
select *
from EmployeeDetails as ed
join Employees as e 
on ed.Employee_ID = e.Employee_ID

--3
select p.ProductName, c.CategoryName
from Products as p
join Categories as c
on p.Product_ID = c.Product_ID

--4
select c.cust_name, o.ord_date
from Orders as o
left join Customer as c
on o.customer_id = c.customer_id

--5
select *
from Orders as o
join OrderDetails as od
on o.OrderID = od.OrderID
join Products as p
on od.ProductID = p.ProductID

--6
select *
from Products
cross join Categories

--7
select *
from Customers as c
join Orders as o
on c.CustomerID = o.CustomerID

--8
select *
from Products as p
cross join Orders as o
where o.OrderAmount>500

--9
select e. Employee_Name, d.Department 
from Employees as e
join Departments as d
on e.EmployeeID = d.EmployeeID

--10
select *
from Orders as o
join Customers as c 
on o.CustomerID != c.CustomerID

--------------------MEDIUM LEVEL TASKS-----------------------
--11
select c.CustomerID, COUNT(*)
from Customers as c
join Orders as o
on c.CustomerID = o.CustomerID
group by c.CustomerID

--12
select *
from Students as s
join StudentCourses as sc
on s.StudentID = sc.StudentID
join Courses as c
on sc.CourseID = c.CourseID

--13
select *
from Employees as e
cross join Departments as d
where e.Salary > 5000

--14
select e.Name, ed.Address, ed.Email, ed.Salary
from Employees as e
join EmployeeDetails as ed
on e.EmployeeID = ed.EmployeeID

--15
select *
from Products as p
join Suppliers as s
on p.ProductID = s.ProductID
where s.Supplier = 'SupplierA'

--16
select p.ProductID, sum(SaleAmount) as Sales_per_Product
from Products as p
join Sales as s
on p.ProductID = s.ProductID 
group by p.ProductID

--17
select *
from Departments as d
left join Employees as e
on d. DepartmentID = E.DepartmentID
where Salary>4000 and DepartmentName = 'HR'

--18
select *
from Sales as S
join Invoices as I
on S.SaleAmount >= I.TotalAmount

--19
select *
from Products as P
join Sales as S
on P.ProductID =S.ProductID
where P.Price >=50

--20
select *
from Sales as S
cross join Regions 
where S.SaleAmount > 1000

---------------------HARD LEVEL TASKS---------------------
--21
SELECT A.Name,B.Title
FROM Authors AS A
JOIN Books_Authors AS BA 
ON A.AuthorID = BA.AuthorID
JOIN BOOKS AS B
ON B.BookID = BA.BookID

--22
select *
from Products as P
join Categories a C
on P.ProductID = C.ProductID
where C.Category != 'Electronics'

--23
select *
from Products as p
cross join Orders as o
where o.Quantity >100

--24
SELECT e.EmployeeID, e.EmployeeName, e.HireDate, d.DepartmentName
FROM Employees e
JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID
    AND DATEDIFF(YEAR, e.HireDate, GETDATE()) >= 5;

--25
select *
from Employees as E
join Departments as D
on E.DepartmentID = D.DepartmentID

--26
select *
from products as P
cross join suppliers as S
where Category = 'Category A'

--27
select *
from Customers as C
join Orders1 as O
on C.CustomerID = O.CustomerID
where Quantity > 10

--28
select C.CourseName, COUNT(*)
from Courses as C
join Students as S
on C.CourseID = S.CourseID
group by C.CourseName

--29
select *
from Employees as E
left join Departments as D
on E.DepartmentID = D.DepartmentID
where DepartmentName = 'MARKETING'

--30
select *
from Table1 as t1
join Table2 as t2
on t1.number <= t2.number



