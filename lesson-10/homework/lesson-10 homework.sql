-------EASY LEVEL TASKS------------
--1. Write a query to perform an INNER JOIN between Orders and Customers using AND in the ON clause to filter orders placed after 2022.
SELECT O.*
FROM Orders AS O
JOIN Customers AS C
ON O.CustomerID = C.CustomerID and YEAR(OrderDate)>2022

--2. Write a query to join Employees and Departments using OR in the ON clause to show employees in either the 'Sales' or 'Marketing' department.
SELECT E.Name, D.DepartmentName
FROM Employees AS E
JOIN Departments AS D
ON E.DepartmentID = D.DepartmentID AND (DepartmentName = 'Sales' or DepartmentName = 'Marketing')

--3. Write a query to demonstrate a CROSS APPLY between Departments and a derived table that shows their Employees, top-performing employee (e.g., top 1 Employee who gets the most salary).
SELECT *
FROM Departments AS D
CROSS APPLY
(SELECT TOP 1 Name,Salary
FROM Employees 
WHERE DepartmentID = D.DepartmentID
ORDER BY SALARY DESC) AS A

--4. Write a query to join Customers and Orders using AND in the ON clause to filter customers who have placed orders in 2023 and who lives in the USA.
SELECT C.FirstName,C.LastName,C.Country,O.OrderDate
FROM Customers AS C
JOIN Orders AS O
ON C.CustomerID = O.CustomerID AND (YEAR(O.OrderDate) = '2023' AND C.Country = 'USA')

--5. Write a query to join a derived table (SELECT CustomerID, COUNT(*) FROM Orders GROUP BY CustomerID) with the Customers table to show the number of orders per customer.
SELECT C.CustomerID, ISNULL(O.NUMBER_OF_ORDERS,0)
FROM CUSTOMERS AS C
LEFT JOIN
(SELECT CustomerID, COUNT(*) AS NUMBER_OF_ORDERS
FROM Orders 
GROUP BY CustomerID) AS O
ON C.CustomerID = O.CustomerID
ORDER BY NUMBER_OF_ORDERS

--6. Write a query to join Products and Suppliers using OR in the ON clause to show products supplied by either 'Gadget Supplies' or 'Clothing Mart'.
SELECT P.ProductName,S.SupplierName
FROM Products AS P
JOIN Suppliers AS S 
ON P.SupplierID = S.SupplierID AND (S.SupplierName = 'Gadget Supplies' OR S.SupplierName = 'Clothing Mart')

--7. Write a query to demonstrate the use of OUTER APPLY between Customers and a derived table that returns each Customers''s most recent order.
SELECT C.CustomerID,O.OrderDate,O.OrderID,O.TotalAmount
FROM Customers AS C
OUTER APPLY 
(SELECT TOP 1 OrderDate,OrderID,TotalAmount
FROM Orders
WHERE CustomerID = C.CustomerID
ORDER BY OrderDate DESC) AS O

-------MEDIUM LEVEL TASKS------------

--8. Write a query that uses the AND logical operator in the ON clause to join Orders and Customers, and filter customers who placed an order with a total amount greater than 500.
SELECT C.CustomerID, C.FirstName,C.LastName,O.TotalAmount
FROM Orders AS O
JOIN Customers AS C
ON O.CustomerID = C.CustomerID AND O.TotalAmount > 500

--9. Write a query that uses the OR logical operator in the ON clause to join Products and Sales to filter products that were either sold in 2022 or the SaleAmount is more than 400.
SELECT P.ProductID,P.ProductName, S.SaleDate,S.SaleAmount
FROM Products AS P
JOIN Sales AS S
ON P.Price = S.ProductID AND (YEAR(S.SaleDate) ='2022' OR S.SaleAmount>400)
ORDER BY P.ProductName

--10. Write a query to join a derived table that calculates the total sales (SELECT ProductID, SUM(Amount) FROM Sales GROUP BY ProductID) with the Products table to show total sales for each product.
SELECT P.ProductID, S.SaleAmount
FROM Products AS P 
JOIN (SELECT ProductID, SUM(SaleAmount) as SaleAmount
FROM Sales 
GROUP BY ProductID) AS S
ON P.ProductID = S.ProductID

--11. Write a query to join Employees and Departments using AND in the ON clause to filter employees who belong to the 'HR' department and whose salary is greater than 50000.
SELECT E.EmployeeID, E.Name, D.DepartmentName, E.Salary
FROM Employees AS E
JOIN Departments AS D
ON E.DepartmentID = D.DepartmentID AND (D.DepartmentName = 'Human Resources' and E.Salary > 50000)

--12. Write a query to use OUTER APPLY to return all customers along with their most recent orders, including customers who have not placed any orders.
SELECT C.CustomerID,O.OrderID,O.OrderDate,O.Quantity,O.TotalAmount
FROM Customers AS C
OUTER APPLY
(SELECT TOP 1 OrderID,OrderDate,Quantity,TotalAmount
FROM Orders 
WHERE CustomerID = C.CustomerID
ORDER BY OrderDate DESC) AS O

--13. Write a query to join Products and Sales using AND in the ON clause to filter products that were sold in 2023 and StockQuantity is more than 50.
SELECT P.ProductID, P.ProductName,S.SaleDate,P.StockQuantity
FROM Products AS P
JOIN Sales AS S
ON P.ProductID = S.ProductID AND (YEAR(SaleDate) = '2023' AND StockQuantity >50)
ORDER BY P.ProductID

--14. Write a query to join Employees and Departments using OR in the ON clause to show employees who either belong to the 'Sales' department or hired after 2020.
SELECT E.EmployeeID, E.Name, D.DepartmentName, E.HireDate
FROM Employees AS E
JOIN Departments AS D
ON E.DepartmentID = D.DepartmentID AND (D.DepartmentName = 'Sales' and YEAR(HireDate) > 2020)

---------------HARD LEVEL TASKS------------------
--15. Write a query to demonstrate the use of the AND logical operator in the ON clause between Orders and Customers, and filter orders made by customers who are located in 'USA' and lives in an address that starts with 4 digits.
SELECT *
FROM Orders AS O
JOIN Customers AS C
ON O.CustomerID = C.CustomerID AND (C.Country = 'USA' AND C.Address LIKE '[0-9][0-9][0-9][0-9]%')

--16. Write a query to demonstrate the use of OR in the ON clause when joining Products and Sales to show products that are either part of the 'Electronics' category or Sale amount is greater than 350.
SELECT P.ProductID, P.ProductName, C.CategoryName, S.SaleAmount
FROM Products AS P
JOIN Categories AS C
ON P.Category = C.CategoryID
JOIN Sales AS S
ON P.ProductID = S.ProductID AND (C.CategoryName = 'Electronics' OR S.SaleAmount > 350)

--17. Write a query to join a derived table that returns a count of products per category (SELECT CategoryID, COUNT(*) FROM Products GROUP BY CategoryID) with the Categories table to show the count of products in each category.
SELECT C.CategoryID,C.CategoryName,P.Number_Of_Products
FROM Categories AS C
LEFT JOIN (SELECT Category, COUNT(*) AS Number_Of_Products
FROM Products 
GROUP BY Category) AS P
ON C.CategoryID = P.Category

--18. Write a query to join Orders and Customers using AND in the ON clause to show orders where the customer is from 'Los Angeles' and the order amount is greater than 300.
SELECT C.*,O.OrderID
FROM Orders AS O
JOIN Customers AS C
ON O.CustomerID = C.CustomerID AND (C.City = 'Los Angeles' AND O.TotalAmount > 300)  

--19. Write a query to join Employees and Departments using a complex OR condition in the ON clause to show employees who are in the 'HR' or 'Finance' department, or have at least 4 wowels in their name.
SELECT E.EmployeeID,E.Name,D.DepartmentName
FROM Employees AS E
JOIN Departments AS D
ON E.DepartmentID = D.DepartmentID 
   AND (
        D.DepartmentName IN ('HR', 'Finance') 
        OR (
            LEN(E.Name) 
            - LEN(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER(E.Name), 'a', ''), 'e', ''), 'i', ''), 'o', ''), 'u', ''))
        ) >= 4
    );

--20. Write a query to join Sales and Products using AND in the ON clause to filter products that have both a sales quantity greater than 100 and a price above 500.
SELECT P.ProductID, P.ProductName,S.SaleAmount, P.Price
FROM Sales AS S
JOIN Products AS P
ON S.ProductID = P.ProductID AND (S.SaleAmount > 100 AND P.Price > 500)

--21. Write a query to join Employees and Departments using OR in the ON clause to show employees in either the 'Sales' or 'Marketing' department, and with a salary greater than 60000.
SELECT E.EmployeeID, E.Name, D.DepartmentName,E.Salary
FROM Employees AS E
JOIN Departments AS D
ON E.DepartmentID = D.DepartmentID AND (D.DepartmentName IN ('Sales','Marketing') and E.Salary > 60000)
