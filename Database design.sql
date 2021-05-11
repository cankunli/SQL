1.
create database Management
create table Offices(country varchar(30) not null)
create table Addresses(Name varchar(30) not null, Addy1 varchar(50) not null, Addy2 varchar(50), 
						City varchar(30) not null, State char(2) not null, Country char(2) not null, 
						PostalCode varchar(16) not null)
create table Operations(ProjectCode int not null, Title varchar(30) not null, ProjectDuration DATE, Budget int, InCharge varchar(30) not null)
create table Detatils(Name varchar(30), Country char(2) not null, Inhabitants int)

2.
create database Lending
create table Lenders(ID int, Name varchar(30) not null, amount int not null)
create table Borrowers(ID int, CompanyName varchar(30) not null, Risk int not null)
create table Loan(Code int not null, Amount int not null, Deadline DATE not null, Interest int not null, Purpose varchar(120))
create table LendersInterest(Amount int not null, LoanToInvest varchar(120) not null)

3.
create database Menu
create table Course(Name varchar(120), Description varchar(120), Photo varbinary(max), Price int)
create table Categories(Name varchar(120), Description varchar(120), PersonInCharge varchar(50))
create table Recipes(Ingredients varchar(120), Amount int, Units varchar(30), StoredAmount int)