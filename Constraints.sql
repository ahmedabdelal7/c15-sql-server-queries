------------------------------------------------
-- Primary Key Constraint
------------------------------------------------

use master ;

create Database DB4;

use DB4;

create Table Students
(
	ID INT NOT NULL ,
	FirstName varchar(20)NOT NULL,
	LastName varchar(20) NULL,
	Phone Varchar(11) NULL,
	Age smallint NULL

	Constraint PK_Students Primary Key (ID)

);

ALTER TABLE Students
Drop Constraint PK_Students;

ALTER TABLE Students
ADD Constraint PK_Students Primary Key (ID,FirstName);

------------------------------------------------
-- Forign Key Constraint
------------------------------------------------

use master;

Create Database DB5;
use DB5;

Create Table Customers
(
	ID	int Not Null ,
	Name varchar(20) Not Null,
	
	Constraint PK_Customers Primary Key (ID)

);

Create Table Orders
(
	ID int Not Null,
	Amount int,
	CustomerID int 

	Constraint PK_Orders Primary Key (ID)

	Constraint FK_CustomerOrder Foreign Key (CustomerID)
	References Customers(ID)

);

--Drop Forign Key Constraint
Alter Table Orders
Drop Constraint FK_CustomerOrder;

--ADD Forign Key Constraint
Alter Table Orders 
ADD Constraint FK_CustomerOrder Foreign Key (CustomerID)
References Customers(ID);


------------------------------------------------
-- Not Null Constraint
------------------------------------------------

--Edit Not Null Contraint
Alter Table Orders
Alter Column Amount int NOT NULL

------------------------------------------------
-- DEFAULT Constraint
------------------------------------------------

ALter Table Orders
Add OrderDate Date DEFAULT GetDate();


CREATE TABLE Persons (
   ID int NOT NULL,
   LastName varchar(255) NOT NULL,
   FirstName varchar(255),
   Age int,
   --City varchar(255) Default 'Aman'
   City varchar(255) 

   Constraint DF_City DEFAULT 'Amman'
);


Alter Table Persons
Drop Constraint DF_City;

Alter Table Persons
Add Constraint df_City Default 'Amman' For City

------------------------------------------------
-- CHECK Constraint
------------------------------------------------

create table Persons
(
	ID  int Not Null,
	Name varchar(20),
	City varchar(200),
	Age int Check (Age > 18)

);

drop table Persons;

create table Persons
(
	ID  int Not Null,
	Name varchar(20),
	City varchar(200),
	Age int,

	Constraint CHK_Person Check (Age >= 18 and City = 'Amman')
)

Alter table Persons
drop constraint CHK_Person

------------------------------------------------
-- UNIQUE Constraint
------------------------------------------------

--Unique Key DIff of primary key , because it allows  null (just one null-not redundunt)
drop table Persons;

create table Persons
(
	ID int Not Null,
	Name varchar(20) UNIQUE ,
	City varchar(200),
	Age int Check (Age > 18)

);

alter table Persons
add  UNIQUE(City);


alter table Persons
add Constraint UQ_Age Unique(Age);

alter table Persons
drop Constraint UQ_Age ;