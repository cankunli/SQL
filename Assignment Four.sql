/*
1.	What is View? What are the benefits of using views?
Views in SQL are defined as those result sets that work as a stored query on data, and acts as a pre-established query command which is stored by the SQL server in the database dictionary.
Benefits: It simplifies calls and provides a layer of indirection.

2.	Can data be modified through views?
No.

3.	What is stored procedure and what are the benefits of using it?
A stored procedure is a prepared SQL code that you can save, so the code can be reused over and over again.
Stored procedure allows them to be executed with a single call. 
This minimizes the use of slow networks, reduces network traffic, and improves round-trip response time. OLTP applications, in particular, benefit because result set processing eliminates network bottlenecks.

4.	What is the difference between view and stored procedure?
Views should be used to store commonly-used JOIN queries and specific columns to build virtual tables of an exact set of data we want to see. 
Stored procedures hold the more complex logic, such as INSERT, DELETE, and UPDATE statements to automate large SQL workflows.


5.	What is the difference between stored procedure and functions?
A function has a return type and returns a value. A procedure does not have a return type. But it returns values using the OUT parameters.

6.	Can stored procedure return multiple result sets?
Stored procedures contain IN and OUT parameters or both. They may return result sets in case you use SELECT statements. Stored procedures can return multiple result sets.

7.	Can stored procedure be executed as part of SELECT Statement? Why?
Stored procedures are typically executed with an EXEC statement. However, you can execute a stored procedure implicitly from within a SELECT statement, provided that the stored procedure returns a result set.

8.	What is Trigger? What types of Triggers are there?
The SQL Server trigger is a special type of stored procedures that is automatically executed when an event occurs in a specific database server. 
SQL Server provides us with two main types of triggers: the DML Triggers and the DDL triggers

9.	What are the scenarios to use Triggers?
Log table modifications. Some tables have sensitive data such as customer email, employee salary, etc., that you want to log all the changes. In this case, you can create the UPDATE trigger to insert the changes into a separate table.
Enforce complex integrity of data. In this scenario, you may define triggers to validate the data and reformat the data if necessary. For example, you can transform the data before insert or update using a BEFORE INSERT or BEFORE UPDATE trigger.

10.	What is the difference between Trigger and Stored Procedure?
Basic:
trigger is a stored procedure that runs automatically when various events happen (eg update, insert, delete)
Stored procedures are a pieces of the code in written in PL/SQL to do some specific task

Running Methodology:
It can execute automatically based on the events 
It can be invoked explicitly by the user

Parameter:
It can not take input as parameter 
It can take input as a parameter 

Transaction statements:
we can't use transaction statements inside a trigger
We can use transaction statements like begin transaction, commit transaction, and rollback inside a stored procedure

Return:
Triggers can not return values 
Stored procedures can return values 

*/

select * from Region
select * from Territories
select * from Employees
select * from EmployeeTerritories
select * from [Order Details]

1a.
insert into Region values(5, 'Middle Earth')

1b.
insert into Territories values(98666, 'Gondor', 5)

1c.
insert into Employees(LastName, FirstName, Region) values ('King', 'Aragorn', 5)
insert into EmployeeTerritories values(10, 98666)

2.
update Territories set TerritoryDescription = 'Arnor' where TerritoryDescription = 'Gondor'

3.
delete from EmployeeTerritories where TerritoryID = 98666
delete from Territories where RegionID = 5
delete from Region where RegionDescription = 'Middle Earth'

4.
create view view_product_order_li as
select p.ProductID, p.ProductName, sum(od.Quantity) 'Total ordered' from Products p
join [Order Details] od
on p.ProductID = od.ProductID
group by p.ProductName, p.ProductID

5.
create proc sp_product_order_quantity_li (@product_id int, @total_quantity float output) as
select @product_id = p.ProductID from Products p
join [Order Details] od
on p.ProductID = od.ProductID
where sum(od.Quantity) = @total_quantity
group by p.ProductID

6.
create proc sp_product_order_city_li (@product_name varchar(50), @order_city varchar(50) output) as
select @product_name=ss.productname from (select top 5 d.ProductID, d.ProductName from 
(select p.ProductID,p.ProductName,sum(od.quantity) t from Products p
inner join [Order Details] od
on p.ProductID = od.ProductID
group by p.ProductID, p.ProductName) as [d] Order by d.t desc) ss
left join(
select * from (select dd.productid, dd.city, rank() over(partition by
productid order by q desc) [rk] from
(select p.ProductID, c.city, sum(od.quantity) q from Customers c
join orders o on c.CustomerID= o.CustomerID
left join [Order Details] od on o.OrderID=od.OrderID
left join Products p on od.ProductID=p.ProductID
group by p.ProductID, c.City ) dd ) cc where cc.rk=1) x
on ss.productid= x.productid
where x.city =@order_city

7.
create proc sp_move_employees_li @terroity_name char(50) = 'tory' as
if exists(select e.EmployeeID,count(t.TerritoryDescription) c from Territories t
join employeeterritories et on t.TerritoryID=et.TerritoryID
join Employees e on et.EmployeeID=e.EmployeeID
where TerritoryDescription=@terroity_name and count(t.TerritoryDescription)>0)
insert into Territories(TerritoryID,TerritoryDescription,RegionID) values
(98666,'Stevens Point',11)
insert into Region(RegionID,RegionDescription) values(10,'North')

8.
create trigger trigger_li on territories for update as
if exists(select e.employeeid, count(t.TerritoryDescription)from Territories t
join employeeterritories et on t.TerritoryID=et.TerritoryID
join Employees e on et.EmployeeID=e.EmployeeID
where t.TerritoryDescription= 'Stevens Point'
group by e.EmployeeID
having count(t.TerritoryDescription)>100)

update Territories set TerritoryDescription= 'Tory' where
TerritoryDescription='Stevens Point'

drop trigger trigger_li

9.
create table people_li (id int, name char(20), cityid int)
create table city_li (cityid int, city char(20))
insert into people_li (id, name, cityid) values(1, 'Aaron Rodgers', 2)
insert into people_li (id, name, cityid) values(2, 'Russell Wilson', 1)
insert into people_li (id, name, cityid) values(3, 'Jody Nelson', 2)
insert into city_li (cityid, city) values(1, 'Settle')
insert into city_li (cityid, city) values(2, 'Green Bay')

create view Packers_cankun_li as
select * from people_li p 
join city_li c 
on p.cityid = c.cityid 
where c.city= 'Green Bay'

begin tran
rollback
drop table people_li
drop table city_li
drop view Packers_cankun_li

10.
create proc sp_birthday_employees_li as
select employeeid, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Photo into birthday_employees_li from Employees
where month(BirthDate)=2

drop table birthday_employees_li

11.
create proc sp_li_1 as
select c.city, count(c.CustomerID) from Customers c
inner join (
select x.CustomerID, count(x.CustomerID) xx from (select distinct c.CustomerID, p.ProductID from Products p
join [Order Details] od on p.ProductID=od.ProductID
join Orders o on od.OrderID=o.OrderID
join Customers c on o.CustomerID=c.CustomerID) x
group by x.CustomerID
having count(x.CustomerID)<2) s
on c.CustomerID= s.CustomerID
group by city
having count(c.CustomerID) >1

12.
1. An inner join to pick up the rows where the primary key exists in both tables, but there is a difference in the value of one or more of the other columns. This would pick up changed rows in original.
2. A left outer join to pick up the rows that are in the original tables, but not in the backup table (i.e. a row in original has a primary key that does not exist in backup). This would return rows inserted into the original.
3. A right outer join to pick up the rows in backup which no longer exist in the original. This would return rows that have been deleted from the original.

14.
declare @fullname varchar(20)
select @fullname = FirstName + LastName + MiddleName + '.' from list
print @fullname

select FirstName + '' + LastName + MiddleName + '.' as fullname from t1 --table

15.
declare @student varchar(20)
declare @marks int
set @student
set @marks= (select max(marks) from student where sex='F')
print @student

16.
declare @student varchar(20)
declare @marks int
set @student
set @marks= (select max(marks) from student order by sex)
print @student