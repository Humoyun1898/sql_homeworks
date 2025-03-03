create database lesson2_homework

create table table_1 (salesman_id int, name varchar(50), city varchar(25), commission decimal(10,2))
insert into table_1 values 
(5001, 'James Hoog', 'New York', 0.15), 
(5002, 'Nail Knite', 'Paris', 0.13), 
(5005, 'Pit Alex', 'London', 0.11), 
(5006, 'Mc Lyon', 'Paris', 0.14),
(5007,'Paul Adam', 'Rome', 0.13),  
(5003, 'Lauson Hen', 'San Jose', 0.12)

exec sp_rename 'table_1', 'salesman';

select *
from salesman

--Write a SQL statement to display specific columns such as names and commissions for all salespeople
select name
from salesman


create table orders (ord_no int, purchase_amount decimal(10,2), order_date date, customer_id int, salesman_id int)

select *
from orders 

insert into orders values 
(70001,       150.5,    '2012-10-05',  3005,     5002),
(70009,       270.65,      '2012-09-10',  3001,         5005),
(70002,      65.26,       '2012-10-05',  3002,         5001),
(70004,       110.5,       '2012-08-17',  3009,         5003),
(70007,       948.5,       '2012-09-10',  3005,         5002),
(70005,       2400.6,      '2012-07-27',  3007,         5001),
(70008,       5760,        '2012-09-10',  3002,         5001),
(70010,       1983.43,     '2012-10-10',  3004,         5006),
(70003,       2480.4,      '2012-10-10',  3009,         5003),
(70012,       250.45,      '2012-06-27',  3008,         5002)

alter table orders
alter column purchase_amount float

--From the following table, write a SQL query to identify the unique salespeople ID. Return salesman_id.
select distinct salesman_id
from orders

--Write a query to display the columns in a specific order, such as order date, salesman ID, order number, and purchase amount for all orders.  
select *
from orders
order by order_date

--From the following table, write a SQL query to locate salespeople who live in the city of 'Paris'. Return salesperson's name, city. 
select name, city
from salesman
where city = 'Paris'

create table customer (customer_id int, customer_name varchar(50), city varchar(20), grade int, salesmain_id int)
insert into customer values 
(3002, 'Nick Rimando',    'New York',   100,        5001),
(3007, 'Brad Davis',      'New York',      200,         5001),
(3005,  'Graham Zusi',     'California',   200,         5002),
(3008, 'Julian Green',    'London',        300,         5002),
(3004,  'Fabian Johnson',  'Paris',        300,         5006),
(3009,  'Geoff Cameron',   'Berlin',       100,         5003),
(3003,  'Jozy Altidor',    'Moscow',        200,         5007),
(3001,  'Brad Guzan',      'London',    null       ,        5005)

select *
from customer

update customer
set grade = ''
where grade = 0

alter table customer
alter column grade varchar(10)


-- From the following table, write a SQL query to find customers whose grade is 200. Return customer_id, cust_name, city, grade, salesman_id. 
select customer_id,customer_name, grade, salesmain_id
from customer
where grade = 200

--From the following table, write a SQL query to find orders that are delivered by a salesperson with ID. 5001. Return ord_no, ord_date, purch_amt.  

select *
from orders
where salesman_id = 5001


create table nobel_win (year int, subject varchar(30), winner varchar(50), country varchar(20))

alter table nobel_win
add category varchar(20)

select *
from nobel_win

insert into nobel_win values 
(1970, 'Physics', 'Hannes Alfven', 'Sweden', 'Scientist'),
(1970, 'Physics','Louis Neel', 'France', 'Scientist'),
(1970, 'Physiology', 'Ulf von Euler', 'Sweden', 'Scientist'),
(1970, 'Physiology','Bernard Katz', 'Germany', 'Scientist'),
(1970, 'Economics ', 'Paul Samuelson ', 'USA', 'Economist'),
(1971, 'Physics','Dennis Gabor', 'Hungary', '')

insert into nobel_win values 
(1971, 'Literature', 'Aleksandr Usik', 'Russia', 'Linguist')
insert into nobel_win values 
(1971, 'Chemistry', 'John Canady', 'USA', 'Peace')
insert into nobel_win values 
(1978, 'Peace', 'Menachem Begin', 'Israel', 'Prime Minister')
insert into nobel_win values 
(1994, 'Peace', 'Yitzhak Rabin', 'Israel', 'Prime Minister')
                               
              
--From the following table, write a SQL query to find the Nobel Prize winner(s) for the year 1970. Return year, subject and winner. 
select year, subject, winner 
from nobel_win
where year = 1970


--From the following table, write a SQL query to find the Nobel Prize winner in ‘Literature’ for 1971. Return winner. 
select winner
from nobel_win
where subject = 'Literature' and year = 1971

--From the following table, write a SQL query to locate the Nobel Prize winner ‘Dennis Gabor'. Return year, subject
select year,subject
from nobel_win
where winner = 'Dennis Gabor'

--From the following table, write a SQL query to find the Nobel Prize winners in the field of ‘Physics’ since 1950. Return winner. 
select winner
from nobel_win
where subject = 'Physics' and year > =1950

--From the following table, write a  SQL query to find the Nobel Prize winners in ‘Chemistry’ between the years 1965 and 1975. Begin and end values are included. Return year, subject, winner, and country.  
select *
from nobel_win
where subject = 'Chemistry' and year>1970 and year <1975

--Write a SQL query to display all details of the Prime Ministerial winners after 1972 of Menachem Begin and Yitzhak Rabin.  
select *
from nobel_win
where category = 'Prime Minister' and year>1972

--From the following table, write a SQL query to retrieve the details of the winners whose first names match with the string ‘Louis’. Return year, subject, winner, country, and category.  
select *
from nobel_win
where winner like'%Louis%'

--From the following table, write a SQL query that combines the winners in Physics, 1970 and in Economics, 1971. Return year, subject, winner, country, and category.
select *
from nobel_win
where (subject = 'Physics' and year = 1970) or (subject = 'Economics' and year=1970)

--From the following table, write a SQL query to find the Nobel Prize winners in 1970 excluding the subjects of Physiology and Economics. Return year, subject, winner, country, and category. 
select *
from nobel_win
where year = 1970 and subject <> 'Physics' and subject <>'Economics'

--From the following table, write a SQL query to combine the winners in 'Physiology' before 1971 and winners in 'Peace' on or after 1974. Return year, subject, winner, country, and category. 
select*
from nobel_win
where (year <1971 and subject = 'Physiology') or (year >1974 and subject ='Peace')

--From the following table, write a SQL query to find the details of the Nobel Prize winner 'Bernard Katz'. Return year, subject, winner, country, and category.  
select*
from nobel_win
where winner = 'Bernard Katz'

--From the following table, write a SQL query to find Nobel Prize winners for the subject that does not begin with the letter 'P'. Return year, subject, winner, country, and category. Order the result by year, descending and winner in ascending.  
select*
from nobel_win
where subject not like '%P%'
order by year desc, winner asc

--From the following table, write a SQL query to find the details of 1970 Nobel Prize winners. Order the results by subject, ascending except for 'Physics' and ‘Economics’ which will come at the end of the result set. Return year, subject, winner, country, and category.  
select *
from nobel_win
where year =1970
order by
	case
		when subject = 'Physics' or subject = 'Economics' then 1
		else 0
	end,
	subject asc

create table item_past (pro_id int, pro_name varchar(50), pro_price decimal(10,2), pro_com int)
insert into item_past values 
    (101, 'Mother Board',                    3200.00,         15),
    (102, 'Key Board',                        450.00,         16),
    (103, 'ZIP drive',                        250.00,         14),
    (104, 'Speaker',                          550.00,         16),
    (105, 'Monitor',                         5000.00,         11),
    (106, 'DVD drive',                        900.00,         12),
    (107, 'CD drive',                         800.00,         12),
    (108, 'Printer',                         2600.00,         13),
    (109, 'Refill cartridge',                 350.00,         13),
    (110, 'Mouse',                            250.00,         12)

select *
from item_past

--From the following table, write a SQL query to calculate the average price for a manufacturer code of 16. Return avg. 

select avg(pro_price) as avg
from item_past
where pro_com = 16

--From the following table, write a SQL query to display the pro_name as 'Item Name' and pro_priceas 'Price in Rs.'  
select pro_name as 'Item_name', pro_price as 'Price in Rs'
from item_past
	

--From the following table, write a  SQL query to find the items whose prices are higher than or equal to $250. Order the result by product price in descending, then product name in ascending. Return pro_name and pro_price.
select pro_name, pro_price
from item_past 
where pro_price >= 250
order by pro_price desc, pro_name asc

--From the following table, write a SQL query to calculate average price of the items for each company. Return average price and company code
select pro_com as 'company_code', avg(pro_price) as 'average_price' 
from item_past
group by pro_com

select pro_com as 'company_code', sum(pro_price) as 'sum_price' 
from item_past
group by pro_com

--From the following table, write a SQL query to find the cheapest item(s). Return pro_name and, pro_price.  
select pro_name, pro_price
from item_past
where pro_price = (select min(pro_price) from item_past)

create table emp_details (emp_idno int,emp_fname varchar(20), emp_lname varchar(20), emp_dept int)
select *
from emp_details

insert into emp_details values
(  127323, 'Michale',         'Robbin',                  57),
   (526689, 'Carlos',          'Snares',                  63),
   (843795, 'Enric',           'Dosio',                   57),
   (328717, 'Jhon',            'Snares',                  63),
   (444527, 'Joseph',          'Dosni',                   47),
   (659831, 'Zanifer',         'Emily',                   47),
   (847674, 'Kuleswar',        'Sitaraman',               57),
   (748681, 'Henrey',          'Gabriel',                 47),
   (555935, 'Alex',            'Manuel',                  57),
   (539569, 'George',         'Mardy',                   27),
   (733843, 'Mario',           'Saule',                   63),
   (631548, 'Alan',            'Snappy',                  27),
   (839139, 'Maria',           'Foster',                  57)

--From the following table, write a SQL query to find the unique last name of all employees. Return emp_lname.
select distinct emp_lname
from emp_details


--From the following table, write a SQL query to find the details of employees whose last name is 'Snares'. Return emp_idno, emp_fname, emp_lname, and emp_dept.  
select *
from emp_details
where emp_lname = 'Snare'

--From the following table, write a SQL query to retrieve the details of the employees who work in the department 57. Return emp_idno, emp_fname, emp_lname and emp_dept..  

select *
from emp_details
where emp_dept = 57


create table employees (employee_id int, first_name varchar(20), last_name varchar(20), email varchar(20),phone_number varchar(20), hire_date date, job_id varchar(20), salary decimal(10,2), commission_pct decimal(5,2), manager_id int, department_id int)

insert into employees values
(100, 'Steven',       'King',         'SKING',     '515.123.4567',        '2003-06-17',  'AD_PRES',     24000.00,            0.00,           0,             90), 
(101, 'Neena',        'Kochhar',      'NKOCHHAR',  '515.123.4568',        '2005-09-21',  'AD_VP',       17000.00,            0.00,         100,             90),  
(102,  'Lex',          'De Haan',      'LDEHAAN',   '515.123.4569',        '2001-01-13',  'AD_VP',      17000.00,            0.00,         100,             90),  
(103,  'Alexander',    'Hunold',       'AHUNOLD',   '590.423.4567',        '2006-01-03',  'IT_PROG',      9000.00,            0.00,         102,             60),  
(104,  'Bruce',        'Ernst',        'BERNST',    '590.423.4568',        '2007-05-21',  'IT_PROG',      6000.00,            0.00,         103,             60),  
(105,  'David',        'Austin',       'DAUSTIN',   '590.423.4569',        '2005-06-25',  'IT_PROG',      4800.00,            0.00,         103,             60),  
(106,  'Valli',        'Pataballa',    'VPATABAL',  '590.423.4560',        '2006-02-05',  'IT_PROG',      4800.00,            0.00,         103,             60),  
(107,  'Diana',        'Lorentz',      'DLORENTZ',  '590.423.5567',        '2007-02-07',  'IT_PROG',      4200.00,            0.00,         103,             60),  
(108,  'Nancy',        'Greenberg',    'NGREENBE',  '515.124.4569',        '2002-08-17',  'FI_MGR',      12008.00,            0.00,         101,            100),  
(109,  'Daniel',       'Faviet',       'DFAVIET',   '515.124.4169',        '2002-08-16',  'FI_ACCOUNT',   9000.00,            0.00,         108,            100 ) 

select *
from employees

--1. From the following table, write a SQL query to find those employees whose salaries are less than 6000. Return full name (first and last name), and salary.
select first_name, last_name, salary
from employees
where salary < 6000

--2. From the following table, write a SQL query to find those employees whose salary is higher than 8000. Return first name, last name and department number and salary.
select first_name, last_name, department_id, salary
from employees
where salary > 8000

--From the following table, write a SQL query to find those employees whose last name is "McEwen". Return first name, last name and department ID.
select first_name, last_name, department_id
from employees
where last_name = 'McEwen'

--From the following table, write a SQL query to identify employees who do not have a department number. Return employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary,commission_pct, manager_id and department_id.
select *
from employees 
where department_id =0

--6. From the following table, write a SQL query to find those employees whose first name does not contain the letter ‘M’. Sort the result-set in ascending order by department ID. Return full name (first and last name together), hire_date, salary and department_id.
select CONCAT(first_name, last_name) as full_name,hire_date, salary, department_id
from employees
where first_name not like '%m%'
order by department_id asc

--7. From the following table, write a SQL query to find those employees who earn between 8000 and 12000 (Begin and end values are included.) and get some commission. These employees joined before ‘1987-06-05’ and were not included in the department numbers 40, 120 and 70. Return all fields
select *
from employees
where salary >=5000 and salary <=8000 and commission_pct >0 and hire_date < '1987-06-05' and department_id <> 40 and department_id <> 70 and department_id <> 120

--8. From the following table, write a SQL query to find those employees who do not earn any commission. Return full name (first and last name), and salary.
select *
from employees
where commission_pct = 0

--9. From the following table, write a SQL query to find the employees whose salary is in the range 9000,17000 (Begin and end values are included). Return full name, contact details and salary.
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
where salary > 7000 and salary < 15000
order by concat (first_name, last_name) asc


--12. From the following table, write a SQL query to find those employees who were hired between November 5th, 2007 and July 5th, 2009. Return full name (first and last), job id and hire date.
select CONCAT(first_name, last_name) as full_name, hire_date,job_id
from employees
where hire_date between '2007-11-05' and '2009-07-05'

--13. From the following table, write a SQL query to find those employees who work either in department 70 or 90. Return full name (first and last name), department id.
select CONCAT(first_name, last_name) as full_name, department_id
from employees
where department_id = 70 or department_id = 90

--From the following table, write a SQL query to find the employees who were hired before June 21st, 2002. Return all fields.
select *
from employees
where hire_date < '2002-06-21'

--From the following table, write a SQL query to find the employees whose managers hold the ID 120, 103, or 145. Return first name, last name, email, salary and manager ID.
select first_name, last_name, email, salary, manager_id
from employees
where manager_id = 120 or manager_id = 103 or manager_id = 145

-- From the following table, write a SQL query to find employees whose first names contain the letters D, S, or N. Sort the result-set in descending order by salary. Return all fields
select *
from employees
where first_name like 'D%' or first_name like 'S%' or first_name like 'N%'
order by salary desc

--From the following table, write a SQL query to find those employees who earn above 11000 or the seventh character in their phone number is 3. Sort the result-set in descending order by first name. Return full name (first name and last name), hire date, commission percentage, email, and telephone separated by '-', and salary.
select concat(first_name, last_name) as full_name, hire_date, commission_pct, email, replace(phone_number, '.', '-') as telephone
from employees
where salary > 11000 or SUBSTRING(phone_number,7,1)=7
order by first_name desc

-- From the following table, write a SQL query to find those employees whose first name contains a character 's' in the third position. Return first name, last name and department id
select first_name, last_name, department_id
from employees
where SUBSTRING(first_name, 3,1) = 's'

--From the following table, write a SQL query to find those employees work in the departments that are not part of the department 50 or 30 or 80. Return employee_id, first_name,job_id, department_id.
select employee_id, first_name,job_id, department_id
from employees
where department_id <>50 and department_id <>80 and department_id <>30




