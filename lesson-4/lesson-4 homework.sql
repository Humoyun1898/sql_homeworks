----1. From the following table, write a SQL query to find the details of those salespeople who come from the 'Paris' City or 'Rome' City. Return salesman_id, name, city, commission.
select *
from salesman
where city = ' Rome ' or city = ' Paris '

---2. From the following table, write a SQL query to find the details of the salespeople who come from either 'Paris' or 'Rome'. Return salesman_id, name, city, commission. 

select *
from salesman
where city in ( ' Paris ',' Rome ')

---3.From the following table, write a SQL query to find the details of those salespeople who live in cities other than Paris and Rome. Return salesman_id, name, city, commission.  

select *
from salesman
where city not in ( ' Paris ',' Rome ')

---4.From the following table, write a SQL query to retrieve the details of all customers whose ID belongs to any of the values 3007, 3008 or 3009. Return customer_id, cust_name, city, grade, and salesman_id.  

select *
from customer
where customer_id in (3007,3008,3009)

---5.From the following table, write a SQL query to find salespeople who receive commissions between 0.12 and 0.14 (begin and end values are included). Return salesman_id, name, city, and commission.

select *
from salesman
where commission between 0.12 and 0.14

--6.From the following table, write a SQL query to select orders between 500 and 4000 (begin and end values are included). Exclude orders amount 948.50 and 1983.43. Return ord_no, purch_amt, ord_date, customer_id, and salesman_id. 

select *
from orders
where purch_amt between 500 and 4000 and purch_amt not in (948.5,1983.43)

---7. From the following table, write a SQL query to retrieve the details of the salespeople whose names begin with any letter between 'A' and 'L' (not inclusive). Return salesman_id, name, city, commission. 
select *
from salesman
where name like '[a-l]%'

---8.From the following table, write a SQL query to find the details of all salespeople except those whose names begin with any letter between 'A' and 'M'. Return salesman_id, name, city, commission.
select *
from salesman
where name like '[^A-M]%'

--9. From the following table, write a SQL query to retrieve the details of the customers whose names begins with the letter 'B'. Return customer_id, cust_name, city, grade, salesman_id.. 
select *
from customer
where cust_name like 'B%'

--10.From the following table, write a SQL query to find the details of the customers whose names end with the letter 'n'. Return customer_id, cust_name, city, grade, salesman_id.
select *
from customer
where cust_name like '%N'

--11.From the following table, write a SQL query to find the details of those salespeople whose names begin with ‘N’ and the fourth character is 'l'. Rests may be any character. Return salesman_id, name, city, commission. 
select *
from salesman
where name like 'N__L%'

---12.From the following table, write a SQL query to find those rows where col1 contains the escape character underscore ( _ ). Return col1.
SELECT *
FROM TESTTABLE
WHERE COL1 LIKE '%_%'

--13.From the following table, write a SQL query to identify those rows where col1 does not contain the escape character underscore ( _ ). Return col1.
SELECT *
FROM TESTTABLE
WHERE COL1 not LIKE '%[_]%'

---14. From the following table, write a SQL query to find rows in which col1 contains the forward slash character ( / ). Return col1.
SELECT *
FROM TESTTABLE
WHERE COL1 LIKE '%/%'

--15. From the following table, write a SQL query to identify those rows where col1 does not contain the forward slash character ( / ). Return col1.
SELECT *
FROM TESTTABLE
WHERE COL1 NOT LIKE '%/%'

--16.From the following table, write a SQL query to find those rows where col1 contains the string ( _/ ). Return col1.

SELECT *
FROM TESTTABLE
WHERE COL1 LIKE '%[_/]%'

---17.From the following table, write a SQL query to find those rows where col1 does not contain the string ( _/ ). Return col1.

SELECT *
FROM TESTTABLE
WHERE COL1 not LIKE '%[_/]%'

--18 From the following table, write a SQL query to find those rows where col1 contains the character percent ( % ). Return col1.
SELECT *
FROM TESTTABLE
WHERE COL1 like '%[%]%'


----19. From the following table, write a SQL query to find those rows where col1 does not contain the character percent ( % ). Return col1.

SELECT *
FROM TESTTABLE
WHERE COL1 not like '%[%]%'

---20.From the following table, write a SQL query to find all those customers who does not have any grade. Return customer_id, cust_name, city, grade, salesman_id.
select *
from customer
where grade is null

--21. From the following table, write a SQL query to locate all customers with a grade value. Return customer_id, cust_name,city, grade, salesman_id.

select *
from customer
where grade is not null

--22. From the following table, write a SQL query to locate the employees whose last name begins with the letter 'D'. Return emp_idno, emp_fname, emp_lname and emp_dept.
select *
from emp_details
where EMP_LNAME like 'D%'



-------------------------------------------------------------------------------------------------------


--1. From the following table, write a SQL query to find those employees whose salaries are less than 6000. Return full name (first and last name), and salary.
select first_name, last_name, salary
from employees
where salary < 6000

--2. From the following table, write a SQL query to find those employees whose salary is higher than 8000. Return first name, last name and department number and salary.
select first_name, last_name, department_id, salary
from employees
where salary > 8000

--3.From the following table, write a SQL query to find those employees whose last name is "McEwen". Return first name, last name and department ID.
select first_name, last_name, department_id
from employees
where last_name = 'McEwen'

--4.From the following table, write a SQL query to identify employees who do not have a department number. Return employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary,commission_pct, manager_id and department_id.
select *
from employees 
where department_id is null

--5. From the following table, write a SQL query to find the details of 'Marketing' department. Return all fields.
select *
from departments
where DEPARTMENT_NAME = 'Marketing'

--6. From the following table, write a SQL query to find those employees whose first name does not contain the letter ‘M’. Sort the result-set in ascending order by department ID. Return full name (first and last name together), hire_date, salary and department_id.
select CONCAT(first_name, last_name) as full_name,hire_date, salary, department_id
from employees
where first_name not like '%m%'
order by department_id asc

---7. From the following table, write a SQL query to find those employees who earn between 8000 and 12000 (Begin and end values are included.) and get some commission. These employees joined before ‘1987-06-05’ and were not included in the department numbers 40, 120 and 70. Return all fields.
select *
from employees
where SALARY between 8000 and 12000 and COMMISSION_PCT is not null and HIRE_DATE<'1987-06-05' and DEPARTMENT_ID not in (40,120,70)

------8. From the following table, write a SQL query to find those employees who do not earn any commission. Return full name (first and last name), and salary.
select *
from employees
where commission_pct = 0


-----9. From the following table, write a SQL query to find the employees whose salary is in the range 9000,17000 (Begin and end values are included). Return full name, contact details and salary.
select *
from employees
where salary between 9000 and 17000

--10. From the following table, write a SQL query to find the employees whose first name ends with the letter ‘m’. Return the first and last name, and salary.
select first_name, last_name, salary
from employees
where first_name like '%m'


--11. From the following table, write a SQL query to find those employees whose salaries are not between 7000 and 15000 (Begin and end values are included). Sort the result-set in ascending order by the full name (first and last). Return full name and salary.
select first_name, last_name
from employees
where salary not between 7000 and 15000
order by concat (first_name, last_name) asc

-----12. From the following table, write a SQL query to find those employees who were hired between November 5th, 2007 and July 5th, 2009. Return full name (first and last), job id and hire date.
select CONCAT(first_name, last_name) as full_name, hire_date,job_id
from employees
where hire_date between '2007-11-05' and '2009-07-05'

-----13. From the following table, write a SQL query to find those employees who work either in department 70 or 90. Return full name (first and last name), department id.
select CONCAT(first_name, last_name) as full_name, department_id
from employees
where department_id in (70,90) 


---- 15.--From the following table, write a SQL query to find the employees who were hired before June 21st, 2002. Return all fields.
select *
from employees
where hire_date < '2002-06-21'


-----16. From the following table, write a SQL query to find the employees whose managers hold the ID 120, 103, or 145. Return first name, last name, email, salary and manager ID.
select first_name, last_name, email, salary, manager_id
from employees
where manager_id in (145,120,103)

-----17 From the following table, write a SQL query to find employees whose first names contain the letters D, S, or N. Sort the result-set in descending order by salary. Return all fields
select *
from employees
where first_name like '%[dsn]%'
order by salary desc

-----18. From the following table, write a SQL query to find those employees who earn above 11000 or the seventh character in their phone number is 3. Sort the result-set in descending order by first name. Return full name (first name and last name), hire date, commission percentage, email, and telephone separated by '-', and salary.
select concat(first_name, last_name) as full_name, hire_date, commission_pct, email, phone_numbe as telephone
from employees
where salary > 11000 or PHONE_NUMBE like '______3%'
order by first_name desc

----19. From the following table, write a SQL query to find those employees whose first name contains a character 's' in the third position. Return first name, last name and department id.
select first_name, last_name, department_id
from employees
where first_name like '__s%'

-----20. From the following table, write a SQL query to find those employees work in the departments that are not part of the department 50 or 30 or 80. Return employee_id, first_name,job_id, department_id.
select employee_id, first_name,job_id, department_id
from employees
where department_id not in (50, 80,30)


----21. From the following table, write a SQL query to find those employees work in the departments that are not part of the department 50 or 30 or 80. Return employee_id, first_name,job_id, department_id.
select employee_id, first_name,job_id, department_id
from employees
where department_id not in (30, 40,90)

---- 22. From the following table, write a SQL query to find those employees who worked more than two jobs in the past. Return employee id.

select EMPLOYEE_ID, START_DATE,END_DATE, JOB_ID
from job_history
group by EMPLOYEE_ID
having count(employee_id) > 1


---23 From the following table, write a SQL query to count the number of employees, the sum of all salary, and difference between the highest salary and lowest salaries by each job id. Return job_id, count, sum, salary_difference.
select EMPLOYEE_ID, count(employee_id), sum(salary), max(salary) - min(salary)
from employees
group by EMPLOYEE_ID

---25. From the following table, write a SQL query to count the number of cities in each country. Return country ID and number of cities.

select COUNTRY_ID, count(city)
from locations
group by COUNTRY_ID

--26. From the following table, write a SQL query to count the number of employees worked under each manager. Return manager ID and number of employees.
select manager_id, count(employee_id)
from employees
group by MANAGER_ID

-- 27. From the following table, write a SQL query to find all jobs. Sort the result-set in descending order by job title. Return all fields.
select distinct job_title from jobs order by JOB_TITLE

--28. From the following table, write a SQL query to find all those employees who are either Sales Representatives or Salesmen. Return first name, last name and hire date.
select *
from employees
where JOB_ID in (' SA_REP ', ' SA_MAN ')

---29. From the following table, write a SQL query to calculate the average salary of employees who receive a commission percentage for each department. Return department id, average salary.
SELECT DEPARTMENT_ID, AVG(SALARY)
FROM employees
GROUP BY DEPARTMENT_ID

---30. From the following table, write a SQL query to find the departments where any manager manages four or more employees. Return department_id.
SELECT DEPARTMENT_ID
FROM employees
GROUP BY DEPARTMENT_ID 
HAVING COUNT(EMPLOYEE_ID) > 3

----31. From the following table, write a SQL query to find the departments where more than ten employees receive commissions. Return department id.
SELECT DEPARTMENT_ID
FROM employees
WHERE COMMISSION_PCT > 0
GROUP BY DEPARTMENT_ID
HAVING COUNT(EMPLOYEE_ID)>10

---32.  From the following table, write a SQL query to find those employees who have completed their previous jobs. Return employee ID, end_date.
SELECT EMPLOYEE_ID, END_DATE
FROM job_history
WHERE END_DATE IS NOT NULL

---33. From the following table, write a SQL query to find those employees who do not have commission percentage and have salaries between 7000, 12000 (Begin and end values are included.) and who are employed in the department number 50. Return all the fields of employees
SELECT *
FROM employees
WHERE COMMISSION_PCT > 0 AND SALARY BETWEEN 7000 AND 12000 AND DEPARTMENT_ID != 50

---34. From the following table, write a SQL query to compute the average salary of each job ID. Exclude those records where average salary is on or lower than 8000. Return job ID, average salary.
SELECT JOB_ID, AVG(SALARY)
FROM employees
GROUP BY JOB_ID
HAVING AVG(SALARY) >= 7000

