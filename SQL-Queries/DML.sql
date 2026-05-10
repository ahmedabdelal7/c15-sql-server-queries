

create database DB2;
use DB2;
create table Employees(
	ID int not null,
	Name varchar(20) not null,
	Phone varchar(10) null,
	Salary smallmoney null
PRIMARY KEY (ID)
)

--=========================================================================
------------------Data Manipulation Language - DML-----------------------
--=========================================================================

----------------------------------------------
--Insert Into Statement
----------------------------------------------

SELECT * FROM Employees;

INSERT INTO Employees
	VALUES	
		(1,'Ahmed','0102033',800),
		(2,'Mohamed','0122544',500),
		(3,'Hasan',NULL,400);

INSERT INTO Employees
	VALUES
		(4,'Menna',NULL,NULL);

INSERT INTO Employees (ID,NAME) 
	VALUES	
		(5,'Ali');
		
TRUNCATE TABLE Employees;

----------------------------------------------
--Update Statement
----------------------------------------------

UPDATE Employees
SET Name = 'Khaled', Salary = 1200
WHERE ID = 5;


UPDATE Employees
SET Salary *=  1.10
WHERE Salary < 1000;

SELECT * FROM Employees;

----------------------------------------------
--Delete Statement
----------------------------------------------

SELECT * FROM Employees;

DELETE FROM Employees
WHERE Salary IS NULL;

----------------------------------------------
--Select Into Statement
----------------------------------------------

SELECT * 
INTO EmployeesCopy1 FROM Employees 
WHERE Salary < 1000;

SELECT * FROM EmployeesCopy1;


SELECT ID,Name,Salary
INTO EmployeesCopy2 FROM Employees;

SELECT * FROM EmployeesCopy2;


---DONT TAKE THE PRIMARY KEY EXP:
INSERT INTO EmployeesCopy2 (ID,Name) 
VALUES 
(1,'ALI');

----------------------------------------------
--Insert Into ..Select From Statement
----------------------------------------------

-----CREARE Persons & OldPersons TABLES-------
--CREATE TABLE Persons(

--	ID INT NOT NULL PRIMARY KEY,
--	"Name" VARCHAR(20) NOT NULL,
--	Age INT NULL,
--);

--INSERT INTO Persons
--VALUES
--(1,'Ahmed',30),
--(2,'Ali',25),
--(3,'Sayed',45),
--(4,'Omar',22),
--(5,'Mona',19);

--SELECT * FROM Persons;

--CREATE TABLE OldPersons(

--	ID INT NOT NULL PRIMARY KEY,
--	"Name" VARCHAR(20) NOT NULL,
--	Age INT NULL,
--);

--Insert Into ..Select From Statement-----

INSERT INTO OldPersons
SELECT * FROM Persons;

DELETE  FROM OldPersons;

INSERT INTO OldPersons
SELECT * FROM Persons
WHERE Age >=30;

SELECT * FROM OldPersons;


----------------------------------------------
--Identity Field (Auto Increment)
----------------------------------------------

identity(StartNumber,Seed)

create table Departments(
	ID INT NOT NULL identity(1,1) primary key,
	Name VARCHAR(20) NOT NULL
)

insert into Departments 
values ('CS'),('IT'),('OS'),('Networks');

select * from Departments;

----------------------------------------------
--Delete vs Truncate statement
----------------------------------------------

--delete all rows but not resete identity
delete from Departments;


insert into Departments 
values ('CS'),('IT'),('OS'),('Networks');

select * from Departments;

--delete all rows but and resete identity
truncate table Departments;

----------------------------------------------
--Foreign Key Constraint
----------------------------------------------

-- This table doesn't have a foreign key
use DB3;
CREATE TABLE Customers (
  id INT IDENTITY(1,1) primary key ,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  age INT,
  country VARCHAR(10),
  --PRIMARY KEY (id)
);

-- Adding foreign key to the customer_id field
-- The foreign key references to the id field of the Customers table
CREATE TABLE Orders (
  order_id INT IDENTITY(1,1) primary key,
  item VARCHAR(40),
  amount INT,
  customer_id INT References Customers(id) 
);


--WE CAN ADD  FOREIGN KEY TO ORDERS TABLE USING ALTER 

CREATE TABLE Orders (
  order_id INT IDENTITY(1,1) primary key,
  item VARCHAR(40),
  amount INT,
  customer_id INT
);

ALTER TABLE Orders
ADD FOREIGN KEY (Customer_id) References Customers(id) 

----------------------------------------------
--              School_DB
----------------------------------------------

USE MASTER;
DROP DATABASE School_DB;


CREATE DATABASE School_DB;
USE School_DB;

CREATE TABLE Persons
(
	id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	first_name VARCHAR(15) NOT NULL,
	last_name VARCHAR(15) NULL,
	birth_date DATE NULL
)

CREATE TABLE Employees
(
	id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	salary SMALLMONEY NULL,
	person_id INT REFERENCES Persons(id)
)


CREATE TABLE Students
(
	id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	level VARCHAR(10) NULL, 
	person_id INT REFERENCES Persons(id) NOT NULL
)

CREATE TABLE Students_Phones
(
	id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	student_id INT REFERENCES Students(id) NOT NULL,
	phone_number VARCHAR(12) NULL
)

CREATE TABLE Professors 
(
	id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	email VARCHAR(20) NULL,
	employee_id INT NOT NULL REFERENCES Employees(id)
)

CREATE TABLE Courses
(
	id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	name VARCHAR(20) NOT NULL,
	credit_hours SMALLINT NULL	
)

CREATE TABLE Enrollments
(
	id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	student_id INT NOT NULL REFERENCES Students(id),
	course_id INT NOT NULL REFERENCES Courses(id),
	enroll_date date NULL,
	grade CHAR(1) NULL,
	professor_id INT NOT NULL REFERENCES Professors(id)
)