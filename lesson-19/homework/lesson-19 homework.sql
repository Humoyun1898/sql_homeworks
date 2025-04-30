--1.Find Employees with Minimum Salary.Task: Retrieve employees who earn the minimum salary in the company.Tables: employees (columns: id, name, salary)
select *
from employees
where salary = (select min(salary) from employees)

--2.Find Products Above Average Price.Task: Retrieve products priced above the average price.Tables: products (columns: id, product_name, price)
select *
from products
where price > (select avg(price) from products)

--3.Find Employees in Sales Department.Task: Retrieve employees who work in the "Sales" department.Tables: employees (columns: id, name, department_id), departments (columns: id, department_name)
select *
from employees as e
join departments as d
on e.id = d.id
where d.department_name = 'Sales'

--4.Find Customers with No Orders.Task: Retrieve customers who have not placed any orders.Tables: customers (columns: customer_id, name), orders (columns: order_id, customer_id)
select c.customer_id,c.name
from customers as c
left join orders as o
on c.customer_id = o.customer_id
where o.order_id is null


--5.Find Products with Max Price in Each Category.Task: Retrieve products with the highest price in each category.Tables: products (columns: id, product_name, price, category_id)
--1st solution
select p.id as product_id,p.category_id,p.product_name,p.price
from products as p
join (select category_id, max(price) as max_price
from products
group by category_id) as dt
on p.category_id = dt.category_id and p.price = dt.max_price

--2nd solution
with cte as (select id, product_name,price,category_id, (select max(price) from products as p2 where p2.category_id = p1.category_id) as max_price
from products as p1)
select *
from cte
where cte.price = cte.max_price

--6.Find Employees in Department with Highest Average Salary.Task: Retrieve employees working in the department with the highest average salary.Tables: employees (columns: id, name, salary, department_id), departments (columns: id, department_name)
with cte as (select *, (select avg(salary) from employees as e2 where e2.department_id = e1.department_id) as department_average_salary
from employees as e1)
select cte.id as Employee_id,cte.name,cte.department_average_salary
from cte
join departments as d
on cte.department_id = d.id
where cte.department_average_salary = (select max(dt.average_salary)
										from
										(select department_id, avg(salary) as average_salary
										from employees
										group by department_id) as dt)


--7.Find Employees Earning Above Department Average.Task: Retrieve employees earning more than the average salary in their department.Tables: employees (columns: id, name, salary, department_id)
with cte as (select *,(select avg(salary) from employees as e2 where e1.department_id = e2.department_id) as Department_average_salary
from employees as e1)
select *
from cte
where salary > Department_average_salary

--8.Find Students with Highest Grade per CourseTask: Retrieve students who received the highest grade in each course.Tables: students (columns: student_id, name), grades (columns: student_id, course_id, grade)
with cte1 as (select student_id,course_id,grade,(select max(grade) from grades as g2 where g2.course_id = g1.course_id) as Course_max_grade
from grades as g1)
select s.student_id,g.course_id, g.grade,cte1.Course_max_grade
from grades as g
join students as s
on g.student_id = s.student_id
join cte1
on g.grade = cte1.Course_max_grade and s.student_id = cte1.student_id

--9.Find Third-Highest Price per Category.Task: Retrieve products with the third-highest price in each category.Tables: products (columns: id, product_name, price, category_id)
--1st solution
select *
from products as p1
where price in (select top 1 price
				from (  select distinct top 3 price
						from products
						where category_id = p1.category_id
						order by price desc ) as top3
				order by price asc
				)

--2nd solution
with cte as (select *, (ROW_NUMBER() over (partition by category_id order by price desc)) as ranking
from products)
select *
from cte
where ranking = 3

--10.Find Employees Between Company Average and Department Max Salary.Task: Retrieve employees with salaries above the company average but below the maximum in their department.Tables: employees (columns: id, name, salary, department_id)
with cte as (select id,name,salary,department_id,(select max(salary) from employees as e2 where e2.department_id = e1.department_id) as department_max_salary, (select avg(salary) from employees) as company_average_salary
from employees as e1)
select *
from cte
where cte.salary > cte.company_average_salary and cte.salary < cte.department_max_salary
