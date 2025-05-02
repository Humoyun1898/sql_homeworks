----EASY TASKS------
--1.You need to write a query that outputs "100-Steven King", meaning emp_id + first_name + last_name in that format using employees table.
select CONCAT(EMPLOYEE_ID,'-',FIRST_NAME,' ',LAST_NAME) as new_column
from Employees

--2.Update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'
 select REPLACE(PHONE_NUMBER,'124','999') AS PHONE_NUMBER
 from Employees

 --3.That displays the first name and the length of the first name for all employees whose name starts with the letters 'A', 'J' or 'M'. Give each column an appropriate label. Sort the results by the employees' first names.(Employees)
  select FIRST_NAME, len(FIRST_NAME) AS NAME_LENGTH
 from Employees
 where FIRST_NAME like '[AJM]%'
 
 --4.Write an SQL query to find the total salary for each manager ID.(Employees table)
 select MANAGER_ID,sum(salary) as Total_salary
 from Employees
 group by MANAGER_ID
 
 --5.Write a query to retrieve the year and the highest value from the columns Max1, Max2, and Max3 for each row in the TestMax table
 select *
 from TestMax

 select year1, case	
				when max1 > max2 and max1>max3 then max1
				when max2> max1 and max2>max3 then max2
				else max3
				end as maximum
from TestMax
 
 --6.Find me odd numbered movies description is not boring.(cinema) 
 select *
 from cinema
 where id%2 !=0 and description != 'boring'


 --7.You have to sort data based on the Id but Id with 0 should always be the last row. Now the question is can you do that with a single order by column.(SingleOrder)
 select *
 from SingleOrder
 order by (case when id=0 then 1 else 0 end), id

 
 --8.Write an SQL query to select the first non-null value from a set of columns. If the first column is null, move to the next, and so on. If all columns are null, return null.(person) 
select id,coalesce(ssn,passportid,itin) as first_null
from person

 --9.Find the employees who have been with the company for more than 10 years, but less than 15 years. Display their Employee ID, First Name, Last Name, Hire Date, and the Years of Service 
 --(calculated as the number of years between the current date and the hire date, rounded to two decimal places).(Employees)
 select EMPLOYEE_ID,FIRST_NAME,LAST_NAME,HIRE_DATE, ROUND (DATEDIFF(day,HIRE_DATE,GETDATE())/365.0,2) AS YEARS_OF_SERVICE
 from Employees
 where DATEDIFF(day,HIRE_DATE,GETDATE())/365.0 > 10 and DATEDIFF(day,HIRE_DATE,GETDATE())/365.0 < 15

 ---MEDIUM TASKS--
--10. Split column FullName into 3 part ( Firstname, Middlename, and Lastname).(Students Table)
select StudentID, 
left(FullName, charindex(' ',FullName) - 1) as First_name,
substring	(FullName,
				charindex(' ',FullName) + 1,
				charindex(' ',FullName, charindex(' ',FullName) + 1)  - charindex(' ',FullName) - 1 )  as second_name ,
right(FullName, len(FullName) - charindex(' ',FullName, charindex(' ',FullName)+1) + 1) as third_name
from Students

--11.For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas. (Orders Table)
select *
from Orders
where DeliveryState = 'TX' and CustomerID in 
(select  distinct CustomerID
from Orders
where DeliveryState = 'CA')

--12.Write an SQL statement that can group concatenate the following values.(DMLTable)
with cte as (select *
from DMLTable
pivot(max(String) for [SequenceNumber] in ([1],[2],[3],[4],[5],[6],[7],[8],[9]) ) as pivottable)
select CONCAT_WS(' ',[1],[2],[3],[4],[5],[6],[7],[8],[9])
from cte

--13.Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. The stages are defined as follows:
--If the employee has worked for less than 1 year → 'New Hire'
--If the employee has worked for 1 to 5 years → 'Junior'
--If the employee has worked for 5 to 10 years → 'Mid-Level'
--If the employee has worked for 10 to 20 years → 'Senior'
--If the employee has worked for more than 20 years → 'Veteran'(Employees)
--Find all employees whose names (concatenated first and last) contain the letter "a" at least 3 times.
select *, case
			when round(DATEDIFF(day,HIRE_DATE,GETDATE())/365,2) < 1 then 'New Hire'
			when round(DATEDIFF(day,HIRE_DATE,GETDATE())/365,2) between 1 and 5 then 'Junior'
			when round(DATEDIFF(day,HIRE_DATE,GETDATE())/365,2) between 5 and 10 then 'Mid-Level'
			when round(DATEDIFF(day,HIRE_DATE,GETDATE())/365,2) between 10 and 20 then 'Senior'
			when round(DATEDIFF(day,HIRE_DATE,GETDATE())/365,2) >20 then 'Veteran'
		end as employee_status
from Employees

--14.The total number of employees in each department and the percentage of those employees who have been with the company for more than 3 years(Employees)
select DEPARTMENT_ID, count(*) ,count (case 
										when datediff(day,hire_date,getdate() ) > 365*3 then 1
										end) as Employee_over_3_years,
										round(100*count (case 
												when datediff(day,hire_date,getdate() ) > 365*3 then 1
												end) / count(*),2) as Percentage_over_3_years
from Employees
group by DEPARTMENT_ID

--15.Write an SQL statement that determines the most and least experienced Spaceman ID by their job description.(Personal)
select *
from Personal
where MissionCount in ((select max(MissionCount) from Personal),(select min(MissionCount) from Personal))

--HARD LEVEL TASKS--
--16.Write an SQL query that separates the uppercase letters, lowercase letters, numbers, and other characters from the given string 'tf56sd#%OqH' into separate columns.
WITH Tally AS (
    SELECT TOP (LEN('tf56sd#%OqH')) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects -- generates a lot of rows
),
Chars AS (
    SELECT 
        SUBSTRING('tf56sd#%OqH', n, 1) AS ch
    FROM Tally
),
Result AS (
    SELECT
        STRING_AGG(CASE WHEN ch LIKE '[A-Z]' THEN ch END, '') AS UppercaseLetters,
        STRING_AGG(CASE WHEN ch LIKE '[a-z]' THEN ch END, '') AS LowercaseLetters,
        STRING_AGG(CASE WHEN ch LIKE '[0-9]' THEN ch END, '') AS Numbers,
        STRING_AGG(CASE WHEN ch LIKE '[^A-Za-z0-9]' THEN ch END, '') AS OtherCharacters
    FROM Chars
)
SELECT * FROM Result;

--17.Write an SQL query that replaces each row with the sum of its value and the previous rows' value. (Students table)
SELECT 
  StudentID,
  FullName,
  Grade + ISNULL(LAG(Grade) OVER (ORDER BY StudentID), 0) AS GradeSum
FROM Students;

--18.You are given the following table, which contains a VARCHAR column that contains mathematical equations. Sum the equations and provide the answers in the output.(Equations)
CREATE FUNCTION dbo.EvaluateExpression (@expr VARCHAR(200))
RETURNS INT
AS
BEGIN
    DECLARE @i INT = 1,
            @len INT = LEN(@expr),
            @num VARCHAR(20) = '',
            @sign CHAR(1) = '+',
            @ch CHAR(1),
            @result INT = 0;

    WHILE @i <= @len
    BEGIN
        SET @ch = SUBSTRING(@expr, @i, 1)

        IF @ch >= '0' AND @ch <= '9'
            SET @num += @ch
        ELSE IF @ch = '+' OR @ch = '-'
        BEGIN
            IF @sign = '+'
                SET @result += CAST(@num AS INT)
            ELSE
                SET @result -= CAST(@num AS INT)

            SET @sign = @ch
            SET @num = ''
        END

        SET @i += 1
    END

    -- Add the last number
    IF @num <> ''
    BEGIN
        IF @sign = '+'
            SET @result += CAST(@num AS INT)
        ELSE
            SET @result -= CAST(@num AS INT)
    END

    RETURN @result
END

--19.Given the following dataset, find the students that share the same birthday.(Student Table)
with cte as (select Birthday, count(StudentName) as Number_of_birthdays
from Student
group by Birthday
having count(StudentName) >1)
select s.StudentName,s.Birthday
from Student as s
join cte
on s.Birthday = cte.Birthday

--20.You have a table with two players (Player A and Player B) and their scores. If a pair of players have multiple entries, aggregate their scores into a single row for each unique pair of players. Write an SQL query to calculate the total score for each unique player pair(PlayerScores)
SELECT 
    CASE 
        WHEN PlayerA < PlayerB THEN PlayerA 
        ELSE PlayerB 
    END AS Player1,
    CASE 
        WHEN PlayerA < PlayerB THEN PlayerB 
        ELSE PlayerA 
    END AS Player2,
    SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY 
    CASE 
        WHEN PlayerA < PlayerB THEN PlayerA 
        ELSE PlayerB 
    END,
    CASE 
        WHEN PlayerA < PlayerB THEN PlayerB 
        ELSE PlayerA 
    END;
select *
from PlayerScores
