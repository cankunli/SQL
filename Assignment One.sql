use AdventureWorks2019

--1
select ProductID, Name, Color, ListPrice
from Production.Product

--2
select ProductID, Name, Color, ListPrice
from Production.Product
where ListPrice = 0

--3
select ProductID, Name, Color, ListPrice
from Production.Product
where Color is null

--4
select ProductID, Name, Color, ListPrice
from Production.Product
where Color is not null

--5
select ProductID, Name, Color, ListPrice
from Production.Product
where Color is not null and ListPrice > 0

--6
select 'Name: ' + Name + ' -- Color:' + Color as 'Name And Color'
from Production.Product
where Color is not null

--7
select 'Name: ' + Name + ' -- COLOR:' + Color as 'Name And Color'
from Production.Product
where Name like '%Crankarm%' or Name like '%Chainring%'
order by ProductID

--8
select ProductID, Name
from Production.Product
where ProductID between 400 and 500

--9
select ProductID, Name, Color
from Production.Product
where Color in ('Black', 'Blue')

--10
select ProductID, Name, Color
from Production.Product
where Name like 's%'

--11
select Name, ListPrice
from Production.Product
where Name like 's%'
order by Name

--12
select Name, ListPrice
from Production.Product
where Name like '[a, s]%'
order by Name

--13
select Name, ListPrice
from Production.Product
where Name like 'spo[^k]%'
order by Name

--14
select distinct Color
from Production.Product
order by Color

--15
select distinct ProductSubcategoryID, Color
from Production.Product
where ProductSubcategoryID is not null and Color is not null

--16
SELECT ProductSubCategoryID, LEFT([Name],35) AS [Name], Color, ListPrice 
FROM Production.Product
WHERE Color not in ('Red','Black') 
      or ListPrice BETWEEN 1000 AND 2000 
      AND ProductSubCategoryID = 1
ORDER BY ProductID

--17
select ProductSubCategoryID, Name, Color, ListPrice
from Production.Product
where ProductSubCategoryID < 15
order by ProductSubCategoryID DESC