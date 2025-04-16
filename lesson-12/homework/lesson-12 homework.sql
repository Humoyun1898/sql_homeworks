--1.Write a solution to report the first name, last name, city, and state of each person in the Person table. If the address of a personId is not present in the Address table, report null instead.
select p.firstName,p.lastName,a.city,a.state
from Person as p
left join Address as a
on p.personId = a.personId

--2.Write a solution to find the employees who earn more than their managers.

select e1.name as Employee_name, e1.salary as Employee_salary, e2.name as Manager_name, e2.salary as Manager_salary
from Employee as e1
join Employee as e2
on e1.managerId = e2.id
where e1.salary > e2.salary


--3. Create table If Not Exists Person (id int, email varchar(255)) Truncate table Person insert into Person (id, email) values ('1', 'a@b.com') insert into Person (id, email) values ('2', 'c@d.com') insert into Person (id, email) values ('3', 'a@b.com')


SELECT distinct p1.email
FROM Person1 p1
JOIN Person1 p2
    ON p1.email = p2.email AND p1.id <> p2.id;


--4.Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.Please note that you are supposed to write a DELETE statement and not a SELECT one.
DELETE FROM Person1
WHERE id NOT IN (select dt.min_id
	from 
    (SELECT email, MIN(id) as min_id
    FROM Person1
    GROUP BY email) as dt)

--5.Find those parents who has only girls.


select g.name as Child_NAME,g.ParentName 
from boys as b
full outer join girls as g
on b.ParentName = g.ParentName
where b.Id is null


--6.Find total Sales amount for the orders which weights more than 50 for each customer along with their least weight. (from TSQL2012 database, Sales.Orders Table)
select custid, sum(freight) as Total_sales, min(freight) as least_weight
from TSQL2012.Sales.Orders
where freight > 50
group by custid

--7.


select c1.Item, c2.Item, case
							when c1.Item is not null and c2.Item is not null then 1
							when c2.Item is null then 2
							when c1.Item is null then 3
						end as order_
from Cart1 as c1
full outer join Cart2 as c2
on c1.Item = c2.Item
order by order_

--8.
create table match1 (MatchID int, Match varchar(30), Score varchar(5)) insert into match1 values (1,'Italy-Spain','2:0'), (2,'Spain-France','2:1'), (3,'France-Belgium','0:0'), (4,'Belgium-Spain','2:2'), (5,'Belgium-Italy','0:3'), (6,'Italy-France','2:0');
select *,
case
  when left(Score, CHARINDEX(':',Score) - 1) > right(Score, len(Score)-CHARINDEX(':',Score)) then left(Match, CHARINDEX('-',Match) - 1)
  when left(Score, CHARINDEX(':',Score) - 1) < right(Score, len(Score)-CHARINDEX(':',Score)) then right(Match, len(Match) - charindex('-',Match))
  else 'Draw'
end as Result
from match1

--9.

select c.id,c.name
from Customers as c
left join Orders as o
on c.id = o.customerId
where o.id is null


--10.Write a solution to find the number of times each student attended each exam.


select s1.student_id, count(e1.subject_name) as Number_of_visits
from Students1 as s1
join Examinations1 as e1
on s1.student_id = e1.student_id
group by s1.student_id

