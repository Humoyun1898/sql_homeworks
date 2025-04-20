create database les1_homework
--Easy--
--1.Define the following terms: data, database, relational database, and table.
Data is the information, figure or facts that does not mean anything and then can be processed and recorded

--2.List five key features of SQL Server.
-1.Organized Data Storage - SQL Server helps you store data in a clean and structured way, using tables.
-2. Smart Query Language (T-SQL)-It uses a special language called T-SQL, which lets you do more than just basic data tasks. You can write code with logic, loops, and conditions to handle complex operations smoothly.
-3. Strong Security Tools - SQL Server takes data protection seriously. It has built-in features like password protection, permission control, and encryption to keep your data safe from unauthorized access.
-4.Reliable Backup System - It can automatically save backups and restore your database to a previous point if something goes wrong.
-5.Built-in Data Tools - It comes with handy tools for moving data, creating reports, and analyzing information. 

--3. What are the different authentication modes available when connecting to SQL Server? (Give at least 2)
1. Windows Authentication
This type of login lets you use your regular Windows account to access SQL Server. Since it works with the same security settings as your operating system (like passwords and permissions), 
it's generally more secure and easier to manage—especially in workplaces where everyone already has a Windows login.

2. SQL Server Authentication
Here, you sign in with a specific username and password created directly in SQL Server. 
It doesn't depend on your Windows account, which makes it handy when you need to connect from outside a Windows environment or allow access to someone who doesn’t have a Windows login.

---Medium---
--4.Create a new database in SSMS named SchoolDB.
create database SchoolDB

--5. Write and execute a query to create a table called Students with columns: StudentID (INT, PRIMARY KEY), Name (VARCHAR(50)), Age (INT).
create table students (StudentID INT, PRIMARY KEY, Name VARCHAR(50), Age INT)

--6.Describe the differences between SQL Server, SSMS, and SQL.
SQL Server
This is the actual database system built by Microsoft.
SSMS is a tool you use to interact with SQL Server. 
SQL is the language you use to communicate with the database.

---Hard-----
--7.Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.
DQL – Data Query Language 
Purpose: To fetch data from the database
Main command: SELECT

DML – Data Manipulation Language
Purpose: To work with the actual data in the database (insert, update, delete).
Commands: INSERT, UPDATE, DELETE

DDL – Data Definition Language
Purpose: To define or change the structure of the database objects like tables or schemas.
Commands: CREATE, ALTER, DROP, TRUNCATE

DCL – Data Control Language
Purpose: To control access to the data in the database (permissions).
Commands: GRANT, REVOKE

TCL – Transaction Control Language
Purpose: To manage transactions, which are groups of operations that should be completed together.
Commands: COMMIT, ROLLBACK, SAVEPOINT

--8.Write a query to insert three records into the Students table.
insert into Students values ( 1 ,'John', 25),(2, 'Adam',34),(3,'Ray',44)

--9.Create a backup of your SchoolDB database and restore it. (write its steps to submit)
-Open SQL Server Management Studio (SSMS) and connect to your SQL Server instance.

-In the Object Explorer, expand the Databases folder.

-Right-click on SchoolDB, go to Tasks → Back Up...

-In the Back Up Database window:

-Backup type: Choose Full

-Backup component: Select Database

-Destination: Choose a backup location (click Remove to clear old path and Add to specify a new one, like:C:\Backups\SchoolDB.bak)

-Click OK to start the backup process.

-A message will appear: "The backup of database 'SchoolDB' completed successfully."

-Right-click SchoolDB → Delete → Check Close existing connections → Click OK

-Now go to Databases → Right-click → Restore Database...

-In the Restore Database window:

-Select Device, then click the ... button.

-Click Add, then browse and select the .bak file you created earlier (e.g., C:\Backups\SchoolDB.bak)

-Click OK

-In the Restore Database window:

-Under Destination, rename the database if needed

-Under Restore options, check Overwrite the existing database (WITH REPLACE) if restoring over an existing one

-Click OK to begin the restore process.

-A message will appear: "Database 'SchoolDB' restored successfully."






