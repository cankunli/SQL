/*
1.	What is an object in SQL?
An object is any SQL Server resource, such as a SQL Server lock or Windows process.

2.	What is Index? What are the advantages and disadvantages of using Indexes?
Index: a key built from one or more columns in the database that speeds up fetching rows from the table or view.

Advantages
Speed up SELECT query
Helps to make a row unique or without duplicates(primary,unique) 
If index is set to fill-text index, then we can search against large string values. for example to find a word from a sentence etc.

Disadvantages
Indexes take additional disk space.
indexes slow down INSERT,UPDATE and DELETE, but will speed up UPDATE if the WHERE condition has an indexed field.  INSERT, UPDATE and DELETE becomes slower because on each operation the indexes must also be updated. 

3.	What are the types of Indexes?
clustered and non-clustered

4.	Does SQL Server automatically create indexes when a table is created? If yes, under which constraints?
Yes, unique constraints

5.	Can a table have multiple clustered index? Why?
No, because the data rows themselves can be stored in only one order. 

6.	Can an index be created on multiple columns? Is yes, is the order of columns matter?
Indexes can be composites - composed of multiple columns - and the order is important because of the leftmost principle.

7.	Can indexes be created on views?
Yes

8.	What is normalization? What are the steps (normal forms) to achieve normalization?
Normalization is the process of reducing the redundancy of data in the table and also improving the data integrity.

9.	What is denormalization and under which scenarios can it be preferable?
Denormalization is used to combine multiple table data into one so that it can be queried quickly.

10.	How do you achieve Data Integrity in SQL Server?
Entity Integrity, Referential Integrity, Domain Integrity, User Defined Integrity

11.	What are the different kinds of constraint do SQL Server have?
Not Null Constraint.
Check Constraint.
Default Constraint.
Unique Constraint.
Primary Constraint.
Foreign Constraint.

12.	What is the difference between Primary Key and Unique Key?
Primary Key is a column that is used to uniquely identify each tuple of the table.
Unique key is a constraint that is used to uniquely identify a tuple in a table.

13.	What is foreign key?
A FOREIGN KEY is a field (or collection of fields) in one table, that refers to the PRIMARY KEY in another table.

14.	Can a table have multiple foreign keys?
Yes

15.	Does a foreign key have to be unique? Can it be null?
Maybe, but it can be NULL.

16.	Can we create indexes on Table Variables or Temporary Tables?
No

17.	What is Transaction? What types of transaction levels are there in SQL Server?
A transaction is a logical unit of work that contains one or more SQL statements. A transaction is an atomic unit. The effects of all the SQL statements in a transaction can be either all committed (applied to the database) or all rolled back (undone from the database).

1.  Read Committed (The Default Isolation Level of MS SQL Server)
2.  Read Uncommitted
3.  Repeatable Read
4.  Serializable
5.  Snapshot
*/

Create table person(person_id int primary key, manager_id int null, name varchar(100)not null) 

1.
select c.iname from customer c
join [order] o
on c.cust_id = o.cust_id
where o.order_date = 2002

2.
select * from person
where lastname like 'A%'

3.
select s.name, count(1) from person p
join (select * from person p
where manager_id is null) s
on p.person_id = s.manager_id
group by s.name

4.
insert, delete, update

5.
create table Company(c_id int primary key, c_name varchar(50) not null)
create table Division(d_id int primary key, d_name varchar(50) not null)
create table Location(l_id int primary key, d_id int foreign key, l_name varchar(50) not null)
create table Contact(c_id int foreign key, d_id int foreign key, l_id int foreign key)