create database les3_homework

--1.Define and explain the purpose of BULK INSERT in SQL Server.
Bulk insert helps to import data from csv and txt files to table that is in SQL Server
The main purpose of bulk insert is to save time and efficiently insert data to table. For example if we have thousand rows to insert, it will take hours to do it manually one by one.
Bulk insert helps to automatically insert if you show the place where the file, from which you want to import, is located, by showing fieldterminators, rowterminators and the firstrow from which to start importing the data

--2.List four file formats that can be imported into SQL Server.
.xlsx, .xls, .csv, .txt, .xml, and .json. are the files that can be imported to sql server

--3.Create a table Products with columns: ProductID (INT, PRIMARY KEY), ProductName (VARCHAR(50)), Price (DECIMAL(10,2)).
create table Products (ProductID int primary key, ProductName varchar(50), price decimal(10,2))

--4.Insert three records into the Products table using INSERT INTO.
insert into Products values (1, 'Iphone', 1500.00),(2, 'Tab', 500.00),(3, 'Earphones', 200.00)

--5.Explain the difference between NULL and NOT NULL with examples.
When the value does not exist or not inserted, null value will be shown
NOT NULL is used when you want so that the data must be inserted. if you put null or do not insert data, the error will be given. if not null constraint is given, you can put just number 0 if it is integer or insert any data in case of other data type

--6.Add a UNIQUE constraint to the ProductName column in the Products table.
alter table Products
add constraint only unique (ProductName)

--7Write a comment in a SQL query explaining its purpose.
Unique constraint is used so that not to insert the same value to the particular column. For example,if there is a name 'Adam' in the name column, you cannot insert the same name to the column. It is the sort of primary key

--8.Create a table Categories with a CategoryID as PRIMARY KEY and a CategoryName as UNIQUE.
create table Categories (CategoryID int PRIMARY KEY, CategoryName varchar(40) unique)

--9.Explain the purpose of the IDENTITY column in SQL Server.
Identity is used if you dont want to insert numeric data one by one if you know the patern. For example, if you know id and it will increase by one, you can write identity(1,1). First parameter is starting point and second is increasing by that number


---MEDIUM LEVEL TASKS
--10. Use BULK INSERT to import data from a text file into the Products table.
bulk insert customers
from 'C:\Users\Asus\OneDrive\Desktop\LESSON3\TXT.txt'
with (
		fieldterminator = '\t',
		rowterminator = '\n',
		firstrow = 2
		)

--11.Create a FOREIGN KEY in the Products table that references the Categories table.
alter table Products
add constraint foreign_key foreign key(ProductID) references Categories(Categoryid)


--12.Explain the differences between PRIMARY KEY and UNIQUE KEY with examples.
-Primary key Identifies each record uniquely but Unique key Ensures values are unique in a column
-Only one primary key allowed in table but Multiple UNIQUE keys allowed in one table
-in the case of primary key, null is not allowed, but null is allowed in the case of foreign key

--13.Add a CHECK constraint to the Products table ensuring Price > 0.
alter table Products
add constraint checking check(price>0)

--14.Modify the Products table to add a column Stock (INT, NOT NULL).
alter table Products
add Stock int not null default 0

--15.Use the ISNULL function to replace NULL values in a column with a default value.
select Product, ProductName, isnull(Price, 0)
from Products

--16.Describe the purpose and usage of FOREIGN KEY constraints in SQL Server.
The purpose:
-Prevents invalid data from entering the database.
-Automatically maintains relationships between tables.
-Helps in understanding how tables are connected.

--- HARD LEVEL TASKS-----
--17.Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.
Create a table with an IDENTITY column starting at 100 and incrementing by 10.

--18Write a query to create a composite PRIMARY KEY in a new table OrderDetails.
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    PRIMARY KEY (OrderID, ProductID)
);

--19.Explain with examples the use of COALESCE and ISNULL functions for handling NULL values.
COALESCE and ISNULL are used to replace the NULL value that appear in the column with the value that you want.
For example: select isnull(Manager,'did not come') 

--20.Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.
create table Employees (Empid int primary key, Name varchar(50), Departments(50), Email varchar(30) unique)

--21.Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.
create table orders (orderid int, Name varchar(50), empid int, constraint c1 foreign key(empid) references Employees(Empid) on delete cascade)
create table orders (orderid int, Name varchar(50), empid int, constraint c1 foreign key(empid) references Employees(Empid) ON UPDATE CASCADE)





