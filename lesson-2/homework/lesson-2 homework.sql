--create database les2_homework

--Basic-Level Tasks (10)

--1.Create a table Employees with columns: EmpID INT, Name (VARCHAR(50)), and Salary (DECIMAL(10,2)).
create table Employees (EmpID INT, Name VARCHAR(50), Salary DECIMAL(10,2))

--2.Insert three records into the Employees table using different INSERT INTO approaches (single-row insert and multiple-row insert).
insert into Employees values (1,'Johny',50000)
insert into Employees values (2,'Rony',55000), (1,'Samy',60000)

--3.Update the Salary of an employee where EmpID = 1.
update Employees
set Salary = 90000
where EmpID = 1

--4.Delete a record from the Employees table where EmpID = 2.
delete Employees
where EmpID = 2

--5.Demonstrate the difference between DELETE, TRUNCATE, and DROP commands on a test table.
Delete - helps to remove some part of the data in the table
Truncate - removes all rows from table
drop - removes the table from the database

--6.Modify the Name column in the Employees table to VARCHAR(100).
alter table Employees
alter column Name varchar(100)

--7.Add a new column Department (VARCHAR(50)) to the Employees table.
alter table Employees
add Department varchar(50)

--8.Change the data type of the Salary column to FLOAT.
alter table	Employees
alter column Salary float

--9.Create another table Departments with columns DepartmentID (INT, PRIMARY KEY) and DepartmentName (VARCHAR(50)).
create table Departments (DepartmentID INT PRIMARY KEY, DepartmentName varchar(50))

--10.Remove all records from the Employees table without deleting its structure.
truncate table Employees


--Intermediate-Level Tasks (6)

--10.Insert five records into the Departments table using INSERT INTO SELECT from an existing table.
insert into Departments (DepartmentID, DepartmentName)
select DepartmentID, DepartmentName from lesson15_homework.dbo.Departments

--11.Update the Department of all employees where Salary > 5000 to 'Management'.
update Employees
set Department = 'Management'
where Salary > 5000

--12.Write a query that removes all employees but keeps the table structure intact.
truncate table Employees

--13.Drop the Department column from the Employees table.
alter table Employees
drop column Department

--14.Rename the Employees table to StaffMembers using SQL commands.
exec sp_rename 'dbo.Employees','StaffMembers'

--15.Write a query to completely remove the Departments table from the database.
drop table Departments

--Advanced-Level Tasks (9)----

--16.Create a table named Products with at least 5 columns, including: ProductID (Primary Key), ProductName (VARCHAR), Category (VARCHAR), Price (DECIMAL)
create table Products (ProductID int Primary Key, ProductName VARCHAR(30), Category VARCHAR(30), Price DECIMAL)

--17.Add a CHECK constraint to ensure Price is always greater than 0.
alter table Products
add constraint checking check(Price>0)

--18.Modify the table to add a StockQuantity column with a DEFAULT value of 50.
alter table Products
add StockQuantity int 
default (50)

--19.Rename Category to ProductCategory
exec sp_rename 'dbo.products.Category','ProductCategory'

--20.Insert 5 records into the Products table using standard INSERT INTO queries.
insert into Products values (1,'Phone','Electronics', 250, 40),
							(2,'Refrigator','Electronics', 350, 10),
							(3,'mersedes','Cars', 11000, 15),
							(4,'Arbidol','Medecine', 350, 10),
							(5,'Chair','Furniture', 50, 10)

--21.Use SELECT INTO to create a backup table called Products_Backup containing all Products data.
select *
into Products_Backup
from Products

--22. Rename the Products table to Inventory.
exec sp_rename 'dbo.Products','Inventory'

--23.Alter the Inventory table to change the data type of Price from DECIMAL(10,2) to FLOAT.
alter table Inventory
drop constraint checking
alter table Inventory
alter column Price float

--24.Add an IDENTITY column named ProductCode that starts from 1000 and increments by 5.
alter table	Inventory
add ProductCode int identity(1000,5)
