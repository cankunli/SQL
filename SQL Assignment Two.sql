--Answer following questions
--1.	What is a result set?
--output of a query

--2.	What is the difference between Union and Union All?
--Union combines the result set from multiple tables and returns distinct records into a single result set.
--Union all combines the result set from multiple tables and returns all records into a single result set.

--3.	What are the other Set Operators SQL Server has?
--union, union all, intersect and except

--4.	What is the difference between Union and Join?
--JOIN combines attributes of the tuples present in the two different relations that share some common fields or attributes.
--UNION combines tuples of the relations that are present in the query.

--5.	What is the difference between INNER JOIN and FULL JOIN?
--Inner join returns only the matching rows between both the tables, non matching rows are eliminated.
 --Full Join or Full Outer Join returns all rows from both the tables (left & right tables), including non-matching rows from both the tables.

--6.	What is difference between left join and outer join
--Left join is part of outer join. Outer join has left join, right join, and full join. 

--7.	What is cross join?
--Cross join returns the Cartesian product of the sets of records from the two joined tables. 

--8.	What is the difference between WHERE clause and HAVING clause?
--WHERE Clause is used to filter the records from the table or used while joining more than one table.Only those records will be extracted who are satisfying the specified condition in WHERE clause. It can be used with SELECT, UPDATE, DELETE statements.
--HAVING Clause is used to filter the records from the groups based on the given condition in the HAVING Clause. Those groups who will satisfy the given condition will appear in the final result. HAVING Clause can only be used with SELECT statement.

--9.	Can there be multiple group by columns?
--A WHERE clause is used is filter records from a result.  The filter occurs before any groupings are made.
--A HAVING clause is used to filter values from a group.

--10.	Can there be multiple group by columns?
--A GROUP BY clause can contain two or more columns¡ªor, in other words, a grouping can consist of two or more columns. 


use AdventureWorks2019

--Write queries for following scenarios
--1
select count(ProductID) as "Number of Products"
from Production.Product

--2
select count(ProductID) as "Number of Products in A Category"
from Production.Product
where ProductSubcategoryID is not null

--3
select ProductSubCategoryID, count(ProductSubCategoryID) as CountedProducts
from Production.Product
where ProductSubCategoryID is not null
group by ProductSubCategoryID

--4
select count(*)
from Production.Product
where ProductSubcategoryID is null

--5
select *
from Production.ProductInventory

--6
select ProductID, sum(Quantity) as TheSum
from Production.ProductInventory
where LocationID = 40
group by ProductID
having sum(Quantity) < 100

--7
select Shelf, ProductID, SUM(Quantity) as TheSum
from Production.ProductInventory 
where LocationID = 40
group by ProductID, Shelf
having sum(Quantity) < 100

--8
select avg(Quantity) as TheAvg
from Production.ProductInventory 
where LocationID = 10

--9
select ProductID, Shelf, avg(Quantity) as TheAvg
from Production.ProductInventory
group by ProductID, Shelf

--10
select ProductID, Shelf, avg(Quantity) as TheAvg
from Production.ProductInventory
where Shelf is not null
group by ProductID, Shelf

--11
select Color, Class, count(*) as TheCount, avg(ListPrice) as AvgPrice
from Production.Product
where Color is not null and Class is not null
group by Color, Class


--12
select c.name as Country, p.name as Province 
from Person.CountryRegion c
inner join Person.StateProvince p
on c.CountryRegionCode = p.CountryRegionCode

--13
select distinct c.name as Country, p.name as Province 
from Person.CountryRegion c
inner join Person.StateProvince p
on c.CountryRegionCode = p.CountryRegionCode
where c.Name in ('Germany', 'Canada')

use Northwind
--14
select p.ProductName
from Products p
inner join [Order Details] o
on p.ProductID = o.ProductID
inner join Orders r
on r.OrderID = o.OrderID
where r.OrderDate between '1996-07-04' and '1998-05-06'

--15
select top 5 ShipPostalCode
from Orders
group by ShipPostalCode
order by count(ShipPostalCode) desc

--16 
select top 5 shipPostalCode
from Orders
where OrderDate between '1996-07-04' and '1998-05-06'
group by ShipPostalCode
order by count(ShipPostalCode) desc

--17
select City, count(ContactName) as 'Customers for the city'
from Customers
group by City

--18
select City, count(ContactName) as 'Customers for the city'
from Customers
group by City
having count(ContactName) > 10

--19
select c.ContactName
from Orders o
inner join Customers c
on o.CustomerID = c.CustomerID
where OrderDate between '1998-01-01' and '1998-05-06'

--20
select CustomerID, OrderDate from
(select distinct CustomerID, OrderDate ,dense_rank() over (partition by CustomerID order by orderDate desc) rnk from Orders) dt
where dt.rnk = 1

--21
select c.ContactName, count(c.ContactName)  
from Orders o 
inner join Customers c
on o.CustomerID = c.CustomerID
group by c.ContactName
order by count(c.ContactName) desc

--22
select c.ContactName, sum(r.Quantity) 
from Orders o inner join Customers c
on o.CustomerID = c.CustomerID
inner join [Order Details] r
on r.OrderID = o.OrderID
group by c.ContactName 
having  sum(r.Quantity) > 100
order by sum(r.Quantity) desc

--23
select s.CompanyName as 'Supplier Company Name' , v.CompanyName as 'Shipping Company Name'
from Shippers v
cross join Suppliers s

--24
select distinct r.OrderDate, p.ProductName 
from Products p inner join [Order Details] o 
on p.ProductID = o.ProductID
inner join Orders r
on r.OrderID = o.OrderID

--25
SELECT Title, LastName + ' ' + FirstName AS Name 
FROM Employees
ORDER BY Title;

--26
SELECT * FROM (SELECT * FROM Employees) AS T1
INNER JOIN
(SELECT ReportsTo, COUNT(ReportsTo) AS Subordinate  FROM Employees
WHERE ReportsTo IS NOT NULL
GROUP BY ReportsTo
HAVING COUNT(ReportsTo) > 2) T2
ON T2.ReportsTo= T1.EmployeeID;

--27
SELECT c.City, c.CompanyName, c.ContactName, 'Customer' as Type
FROM Customers c
UNION
SELECT s.City, s.CompanyName, s.ContactName, 'Supplier' as Type
FROM Suppliers s;

--28
SELECT * FROM F1 INNER JOIN F2;
ON F1.T1 = F2.T2

--29
SELECT * FROM F1 LEFT JOIN F2;
ON F1.T1 = F2.T2