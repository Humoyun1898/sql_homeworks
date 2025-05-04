--1.Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname.(TestMultipleColumns)
select *, left(name,charindex(',',name)-1) as Name,	right(name, charindex(',', reverse(name))-1 ) as Surname
from TestMultipleColumns

--2.Write a SQL query to find strings from a table where the string itself contains the % character.(TestPercent)
select *
from TestPercent
where CHARINDEX('%',strs) != 0

--3.In this puzzle you will have to split a string based on dot(.).(Splitter)
SELECT value AS SplitPart
FROM Splitter
CROSS APPLY STRING_SPLIT(Vals, '.');

--5.Write a SQL query to replace all integers (digits) in the string with 'X'.(1234ABC123456XYZ1234567890ADS)
select replace(replace(replace(replace(replace(replace(replace(replace(replace(replace('1234ABC123456XYZ1234567890ADS',1,'X'),2,'X'),3,'X'),4,'X'),5,'X'),6,'X'),7,'X'),8,'X'),9,'X'),0,'X')

--6.Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.).(testDots)
select *
from testDots
where len(vals) - len(replace(vals,'.','')) > 2

--7.Write a SQL query to count the spaces present in the string.(CountSpaces)
select *, len(texts) - len(replace(texts,' ','')) as number_of_spaces
from CountSpaces

--8.write a SQL query that finds out employees who earn more than their managers.(Employee)
select e1.Name as Employee_name,e1.Salary as Employee_salary,isnull(e2.Name,'No manager') as Manager_name,e2.Salary as Manager_salary
from Employee as e1
left join Employee as e2
on e1.ManagerId = e2.Id
where e1.Salary>e2.Salary

--9.Find the employees who have been with the company for more than 10 years, but less than 15 years. Display their Employee ID, First Name, Last Name, Hire Date, and the Years of Service (calculated as the number of years between the current date and the hire date).(Employees)
select FIRST_NAME,LAST_NAME,HIRE_DATE,DATEDIFF(YEAR, HIRE_DATE, GETDATE() ) as [Years of Service]
from Employees
where DATEDIFF(YEAR, HIRE_DATE, GETDATE() ) between 10 and 15

----MEDIUM LEVEL TASKS----
--1.Write a SQL query to separate the integer values and the character values into two different columns.(rtcfvty34redt)
WITH Numbers AS (
    SELECT TOP 100 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects
),
Split AS (
    SELECT 
        SUBSTRING(r.Col, n.n, 1) AS CharVal,
        n.n AS Pos,
        r.Col
    FROM (SELECT 'rtcfvty34redt' AS Col) r
    JOIN Numbers n ON n.n <= LEN(r.Col)
),
Separated AS (
    SELECT 
        Col,
        STRING_AGG(CASE WHEN CharVal LIKE '[0-9]' THEN CharVal END, '') AS Numbers,
        STRING_AGG(CASE WHEN CharVal LIKE '[a-zA-Z]' THEN CharVal END, '') AS Letters
    FROM Split
    GROUP BY Col
)
SELECT Col AS OriginalString, Numbers AS DigitsOnly, Letters AS LettersOnly
FROM Separated;

--2.write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.(weather)
select w.RecordDate as Current_day_temp, w.temperature as Currentday_temp, w2.temperature as Previous_day_temp
from weather as w
left join weather as w2
on w.RecordDate = DATEADD(day,1,w2.RecordDate)
where w.Temperature>w2.Temperature

--3.Write an SQL query that reports the first login date for each player.(Activity)
select player_id, min(event_date) as first_login_date
from Activity
group by player_id

--4.Your task is to return the third item from that list.(fruits)
select SUBSTRING(fruit_list,
				charindex(',',fruit_list,CHARINDEX(',',fruit_list) + 1) + 1,
				CHARINDEX(',',fruit_list,charindex(',',fruit_list,CHARINDEX(',',fruit_list) + 1) +1) - charindex(',',fruit_list,CHARINDEX(',',fruit_list) + 1) - 1 ) as third_item
from fruits

--5.Write a SQL query to create a table where each character from the string will be converted into a row.(sdgfhsdgfhs@121313131)
DECLARE @str NVARCHAR(MAX) = 'sdgfhsdgfhs@121313131';

WITH Numbers AS (
    SELECT TOP (LEN(@str))
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects
),
Split AS (
    SELECT 
        n AS Position,
        SUBSTRING(@str, n, 1) AS Character
    FROM Numbers
)
SELECT *
FROM Split;

--6.You are given two tables: p1 and p2. Join these tables on the id column. The catch is: when the value of p1.code is 0, replace it with the value of p2.code.(p1,p2)
select p1.id as p1_id, case
						when p1.code = 0 then p2.code
						else p1.code
						end as p1_code, p2.id as p2_id,p2.code as p2_code
from p1
join p2
on p1.id = p2.id

--7.Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. The stages are defined as follows:
--If the employee has worked for less than 1 year → 'New Hire'
--If the employee has worked for 1 to 5 years → 'Junior'
--If the employee has worked for 5 to 10 years → 'Mid-Level'
--If the employee has worked for 10 to 20 years → 'Senior'
--If the employee has worked for more than 20 years → 'Veteran'(Employees)
select FIRST_NAME,LAST_NAME,DATEDIFF(year,HIRE_DATE,GETDATE()) as Years_of_service, case
																					when DATEDIFF(year,HIRE_DATE,GETDATE()) < 1 then 'New_Hire'
																					when DATEDIFF(year,HIRE_DATE,GETDATE()) >= 1 and DATEDIFF(year,HIRE_DATE,GETDATE())<5 then 'Junior'
																					when DATEDIFF(year,HIRE_DATE,GETDATE()) >= 5 and DATEDIFF(year,HIRE_DATE,GETDATE()) < 10 then 'Mid-Level'
																					when DATEDIFF(year,HIRE_DATE,GETDATE()) >= 10 and DATEDIFF(year,HIRE_DATE,GETDATE()) < 20 then 'Senior'
																					else 'Veteran' 
																					end as Employee_status
from Employees 

--8.Write a SQL query to extract the integer value that appears at the start of the string in a column named Vals.(GetIntegers)
SELECT 
    Vals,
    LEFT(Vals, PATINDEX('%[^0-9]%', Vals + 'X') - 1) AS StartingInteger
FROM GetIntegers
WHERE Vals LIKE '[0-9]%'

-----DIFFICULT TASKS-----
--1.In this puzzle you have to swap the first two letters of the comma separated string.(MultipleVals)
SELECT 
    Vals,
    CONCAT(
        second, ',', first, 
        CASE 
            WHEN rest IS NOT NULL THEN CONCAT(',', rest) 
            ELSE '' 
        END
    ) AS SwappedVals
FROM (
    SELECT 
        Vals,
        CHARINDEX(',', Vals) AS pos1,
        CHARINDEX(',', Vals, CHARINDEX(',', Vals) + 1) AS pos2,
        
        SUBSTRING(Vals, 1, CHARINDEX(',', Vals) - 1) AS first,
        SUBSTRING(
            Vals,
            CHARINDEX(',', Vals) + 1,
            CHARINDEX(',', Vals, CHARINDEX(',', Vals) + 1) - CHARINDEX(',', Vals) - 1
        ) AS second,
        SUBSTRING(Vals, CHARINDEX(',', Vals, CHARINDEX(',', Vals) + 1) + 1, LEN(Vals)) AS rest
    FROM MultipleVals
) AS Parsed;

--2.Write a SQL query that reports the device that is first logged in for each player.(Activity)
with cte as(select player_id,device_id,event_date,games_played, DENSE_RANK() over (partition by player_id order by event_date) as dr
			from Activity)
select player_id,device_id,event_date
from cte
where dr = 1

--3.You are given a sales table. Calculate the week-on-week percentage of sales per area for each financial week.
--For each week, the total sales will be considered 100%, and the percentage sales for each day of the week should be calculated based on the area sales for that week.(WeekPercentagePuzzle)
WITH WeekSales AS (
    SELECT 
        Area,
        DATEPART(YEAR, Date) AS YearNum,
        DATEPART(WEEK, Date) AS WeekNum,
        SUM(SalesLocal) AS WeeklyTotal
    FROM WeekPercentagePuzzle
    GROUP BY Area, DATEPART(YEAR, Date), DATEPART(WEEK, Date)
)
SELECT 
    wpp.Date,
    wpp.Area,
    DATEPART(YEAR, wpp.Date) AS YearNum,
    DATEPART(WEEK, wpp.Date) AS WeekNum,
    wpp.SalesLocal,
    ws.WeeklyTotal,
    ROUND(CAST(wpp.SalesLocal AS FLOAT) / NULLIF(ws.WeeklyTotal, 0) * 100, 2) AS DailyPercentage
FROM WeekPercentagePuzzle wpp
JOIN WeekSales ws
  ON wpp.Area = ws.Area
 AND DATEPART(YEAR, wpp.Date) = ws.YearNum
 AND DATEPART(WEEK, wpp.Date) = ws.WeekNum
ORDER BY Area, YearNum, WeekNum, Date;
