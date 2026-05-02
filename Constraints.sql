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

