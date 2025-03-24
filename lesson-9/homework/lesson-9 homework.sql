-------EASY LEVEL TASKS--------
--1. Write a query to join Employees and Departments using an INNER JOIN, and apply a WHERE clause to show only employees whose salary is greater than 5000.
SELECT E.Name AS EMPLOYEE_NAME, D.DepartmentName AS DEPARTMENT_NAME, E.Salary AS EMPLOYEE_SALARY
FROM Employees AS E
JOIN Departments AS D
ON E.DepartmentID = D.DepartmentID
WHERE E.Salary > 5000

--2. Write a query to join Customers and Orders using an INNER JOIN, and apply the WHERE clause to return only orders placed in 2023.
SELECT O.ORDERID AS ORDER_ID
FROM Customers as C
join Orders as O
ON C.CustomerID = O.CustomerID 
WHERE YEAR(OrderDate) = '2023'

--3. Write a query to demonstrate a LEFT OUTER JOIN between Employees and Departments, showing all employees and their respective departments (including employees without departments).

SELECT E.EMPLOYEEID AS EMPLOYEE_ID, E.NAME AS EMPLOYEE_NAME, D.DEPARTMENTNAME as DepartmentName
FROM Employees AS E
LEFT OUTER JOIN Departments AS D
ON E.DepartmentID = D.DepartmentID


--4. Write a query to perform a RIGHT OUTER JOIN between Products and Suppliers, showing all suppliers and the products they supply (including suppliers without products).

SELECT P.SupplierID as SupplierID, S.SupplierName AS SupplierName, P.ProductName as ProductName
FROM PRODUCTS AS P
RIGHT OUTER JOIN SUPPLIERS AS S
ON S.SupplierID = P.SupplierID

--5. Write a query to demonstrate a FULL OUTER JOIN between Orders and Payments, showing all orders and their corresponding payments (including orders without payments and payments without orders).

SELECT O.OrderID as OrderID, P.PaymentID as PaymentID, P.Amount as Amount
FROM Orders as O
FULL OUTER join Payments as P
ON O.OrderID = P.OrderID

--6. Write a query to perform a SELF JOIN on the Employees table to display employees and their respective managers (showing EmployeeName and ManagerName).
SELECT E1.NAME AS EMPLOYEE_NAME, E2.NAME AS MANAGER_NAME
FROM EMPLOYEES AS E1
JOIN EMPLOYEES AS E2
ON E1.MANAGERID = E2.EMPLOYEEID
ORDER BY E2.NAME

--7. Write a query to join Students and Courses using INNER JOIN, and use the WHERE clause to show only students enrolled in 'Math 101'.(USE ENROLLMENTS TABLE AS A BRIDGE TABLE)
SELECT S.*,C.*
FROM STUDENTS AS S
JOIN ENROLLMENTS AS E
ON S.STUDENTID = E.STUDENTID
JOIN COURSES AS C
ON E.COURSEID = C.COURSEID
WHERE C.COURSENAME = 'Math 101'

--8. Write a query that uses INNER JOIN between Customers and Orders, and filters the result with a WHERE clause to show customers who have placed more than 3 items at once.

SELECT C.FIRSTNAME as first_name, C.LASTNAME as last_name, SUM(O.QUANTITY) AS QUANTITY
FROM CUSTOMERS AS C
JOIN ORDERS AS O
ON C.CUSTOMERID = O.CUSTOMERID
WHERE O.QUANTITY > 3
GROUP BY C.FIRSTNAME, C.LASTNAME

--9. Write a query to join Employees and Departments using a LEFT OUTER JOIN and use the WHERE clause to filter employees in the 'HR' department(Human Resources).

SELECT E.Name as EmployeeName, D.DEPARTMENTNAME as Department
FROM EMPLOYEES AS E
LEFT OUTER JOIN DEPARTMENTS AS D
ON E.DEPARTMENTID = D.DEPARTMENTID
WHERE D.DEPARTMENTNAME = 'Human Resources'

------------MEDIUM LEVEL TASKS---------------------
--10. Write a query to perform an INNER JOIN between Employees and Departments, and use the HAVING clause to show employees who belong to departments with more than 10 employees.
SELECT D.DEPARTMENTNAME AS DEPARTMENTNAME, COUNT(EmployeeID) AS NUMBER_OF_EMPLOYEES
FROM EMPLOYEES AS E
JOIN DEPARTMENTS AS D
ON E.DEPARTMENTID = D.DEPARTMENTID
GROUP BY D.DEPARTMENTNAME
HAVING COUNT(EMPLOYEEID) > 10

--11. Write a query to perform a LEFT OUTER JOIN between Products and Sales, and use the WHERE clause to filter only products with no sales.
SELECT P.PRODUCTNAME, S.SALEAMOUNT
FROM PRODUCTS AS P
LEFT OUTER JOIN SALES AS S
ON P.PRODUCTID = S.PRODUCTID
WHERE S.SALEAMOUNT IS NULL

--12. Write a query to perform a RIGHT OUTER JOIN between Customers and Orders, and filter the result using the HAVING clause to show only customers who have placed at least one order.

SELECT C.CUSTOMERID,COUNT(O.ORDERID) AS  NUMBER
FROM CUSTOMERS AS C
RIGHT JOIN ORDERS AS O
ON C.CUSTOMERID = O.CUSTOMERID
GROUP BY C.CUSTOMERID
HAVING COUNT(O.ORDERID)>=1

--13. Write a query that uses a FULL OUTER JOIN between Employees and Departments, and filters out the results where the department is NULL.
SELECT *
FROM EMPLOYEES AS E
FULL OUTER JOIN DEPARTMENTS AS D
ON E.DEPARTMENTID = D.DEPARTMENTID
WHERE D.DEPARTMENTID IS NULL

--14. Write a query to perform a SELF JOIN on the Employees table to show employees who report to the same manager.

SELECT E1.NAME AS EMPLOYEE_NAME, E2.NAME AS MANAGER_NAME
FROM EMPLOYEES AS E1
JOIN EMPLOYEES AS E2
ON E1.MANAGERID = E2.EMPLOYEEID
WHERE E1.MANAGERID IN (SELECT MANAGERID
						FROM EMPLOYEES
						WHERE MANAGERID IS NOT NULL
						GROUP BY MANAGERID
						HAVING COUNT(*)>1)
ORDER BY MANAGER_NAME

--15. Write a query to perform a LEFT OUTER JOIN between Orders and Customers, followed by a WHERE clause to filter orders placed in the year 2022.
SELECT O.ORDERID,YEAR(O.ORDERDATE)
FROM ORDERS AS O
JOIN CUSTOMERS AS C
ON O.CUSTOMERID=C.CUSTOMERID
WHERE YEAR(O.ORDERDATE) ='2022'

--16. Write a query to use the ON clause with INNER JOIN to return only the employees from the 'Sales' department whose salary is greater than 5000.
SELECT E.NAME AS EMPLOYEE_NAME, E.SALARY AS SALARY
FROM EMPLOYEES AS E
JOIN DEPARTMENTS AS D
ON E.DEPARTMENTID = D.DEPARTMENTID
WHERE E.SALARY > 5000 AND D.DEPARTMENTNAME = 'Sales'

--17. Write a query to join Employees and Departments using INNER JOIN, and use WHERE to filter employees whose department''s DepartmentName is 'IT'.
SELECT E.NAME AS EMPLOYEENAME, D.DEPARTMENTNAME AS DEPARTMENT_NAME
FROM EMPLOYEES AS E
JOIN DEPARTMENTS AS D
ON E.DEPARTMENTID = D.DEPARTMENTID
WHERE D.DEPARTMENTNAME = 'IT'

--18. Write a query to join Orders and Payments using a FULL OUTER JOIN, and use the WHERE clause to show only the orders that have corresponding payments.
SELECT O.ORDERID,P.*
FROM ORDERS AS O
FULL OUTER JOIN PAYMENTS AS P
ON O.ORDERID = P.ORDERID
WHERE P.PAYMENTID IS NOT NULL AND O.ORDERID IS NOT NULL


--19. Write a query to perform a LEFT OUTER JOIN between Products and Orders, and use the WHERE clause to show products that have no orders.
SELECT P.PRODUCTNAME
FROM PRODUCTS AS P
LEFT JOIN ORDERS AS O
ON P.PRODUCTID = O.PRODUCTID
WHERE O.ORDERID IS NULL


--------------HARD LEVEL TASKS-----------------------
--20. Write a query using a JOIN between Employees and Departments, followed by a WHERE clause to show employees whose salary is higher than the average salary of all employees.
SELECT E.EmployeeID, E.Salary
FROM EMPLOYEES AS E
JOIN DEPARTMENTS AS D
ON E.DepartmentID = D.DepartmentID
WHERE E.Salary> (SELECT AVG(SALARY) FROM Employees) 

--21. Write a query to perform a LEFT OUTER JOIN between Orders and Payments, and use the WHERE clause to return all orders placed before 2020 that have not been paid yet.
SELECT O.OrderID
FROM ORDERS AS O
LEFT OUTER JOIN Payments AS P
ON O.OrderID = P.OrderID
WHERE YEAR(O.OrderDate) < '2020' AND P.PaymentMethod IS NULL

--22. Write a query to perform a FULL OUTER JOIN between Products and Categories, and use the WHERE clause to filter only products that have no category assigned.
SELECT P.ProductID 
FROM Products AS P
FULL OUTER JOIN Categories AS C
ON P.Category = C.CategoryID
WHERE C.CategoryID IS NULL 

--23. Write a query to perform a SELF JOIN on the Employees table to find employees who report to the same manager and earn more than 5000.
SELECT E1.Name AS EMPLOYEE_NAME, E2.Name AS EMPLOYEE_NAME
FROM Employees AS E1
JOIN Employees AS E2
ON E1.ManagerID = E2.ManagerID
WHERE E1.MANAGERID IN (SELECT MANAGERID
						FROM EMPLOYEES
						WHERE MANAGERID IS NOT NULL AND Salary>5000
						GROUP BY MANAGERID
						HAVING COUNT(*)>1)

--24. Write a query to join Employees and Departments using a RIGHT OUTER JOIN, and use the WHERE clause to show employees from departments where the department name starts with ‘M’.
SELECT E.Name
FROM Employees AS E
RIGHT OUTER JOIN Departments AS D
ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName LIKE 'M%'

--25. Write a query to join Products and Sales, and use WHERE to filter only sales greater than 1000.
SELECT *
FROM Products AS P
JOIN Sales AS S
ON P.ProductID=S.ProductID
WHERE S.SaleAmount > 1000

--26. Write a query to perform a LEFT OUTER JOIN between Students and Courses, and use the WHERE clause to show only students who have not enrolled in 'Math 101'.(USE ENROLLMENTS TABLE AS A BRIDGE TABLE)
SELECT S.StudentID,C.CourseName
FROM Students AS S
LEFT JOIN Enrollments AS E
ON S.StudentID = E.StudentID
LEFT JOIN Courses AS C
ON E.CourseID = C.CourseID
WHERE CourseName <> 'Math 101'

--27. Write a query using a FULL OUTER JOIN between Orders and Payments, followed by a WHERE clause to filter out the orders with no payment.
SELECT O.ORDERID
FROM ORDERS AS O
FULL OUTER JOIN PAYMENTS AS P
ON O.OrderID = P.OrderID
WHERE PaymentID IS NULL

--28. Write a query to join Products and Categories using an INNER JOIN, and use the WHERE clause to filter products that belong to either 'Electronics' or 'Furniture'.
SELECT P.ProductName, C.CategoryName
FROM Products AS P
JOIN Categories AS C
ON P.Category = C.CategoryID 
WHERE C.CategoryName = 'Electronics' or c.CategoryName = 'Furniture'
