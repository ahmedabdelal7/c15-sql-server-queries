
--=====================================================================
--				    	SQL - Queries
--=====================================================================

-----------------------------------------------------
--Preparing HR_Database
-----------------------------------------------------

--FIRST QUERY:

USE MASTER;

RESTORE DATABASE HR_Database FROM DISK = 'C:\HR_Database.bak';

--SECOND QUERY:

use HR_Database;

EXEC sp_changedbowner 'sa';

SELECT * FROM Employees;


--DONE RESTORING..

-----------------------------------------------------
--Select Statement
-----------------------------------------------------

SELECT * FROM Employees;

SELECT Employees.* FROM Employees;

SELECT ID, FirstName FROM Employees;

SELECT ID, FirstName, DateOfBirth FROM Employees;

SELECT * FROM Departments;

SELECT * FROM Countries;

-----------------------------------------------------
--Select Distinct Statement
-----------------------------------------------------

SELECT DISTINCT FirstName FROM Employees;

SELECT DISTINCT FirstName, CountryId FROM Employees;

SELECT DISTINCT FirstName, LastName FROM Employees;

-----------------------------------------------------
--Where Statement + AND , OR, NOT
-----------------------------------------------------

SELECT * FROM Employees;

SELECT * FROM Employees 
WHERE DepartmentID =1 OR DepartmentID = 2;

SELECT * FROM Employees 
WHERE DepartmentID =1 AND DepartmentID = 2;


SELECT * FROM Employees 
WHERE DepartmentID <>1; -- <> means not equal

SELECT * FROM Employees 
WHERE ExitDate IS NULL AND Gendor = 'M';


SELECT * FROM Employees 
WHERE ExitDate IS NOT NULL;

SELECT * FROM Employees
WHERE (MonthlySalary < 500 ) OR ( Gendor = 'F' AND BonusPerc > 0) ;


-----------------------------------------------------
--"In" Operator
-----------------------------------------------------

SELECT * FROM Employees
WHERE DepartmentID = 1 OR DepartmentID = 2 OR DepartmentID = 5;

--WE USE (IN OPERATOR) INSTEAD OF REPEATING OR
SELECT * FROM Employees
WHERE DepartmentID IN (1,2,5);

SELECT * FROM Employees
WHERE FirstName IN('Kai','Harper','Leah');

SELECT Departments.Name FROM Departments
WHERE ID IN (SELECT DepartmentID FROM Employees WHERE MonthlySalary <= 210)


SELECT Departments.Name FROM Departments
WHERE ID NOT IN (SELECT DepartmentID FROM Employees WHERE MonthlySalary <= 210)

-----------------------------------------------------
--Sorting : Order By
-----------------------------------------------------

SELECT * FROM Employees
WHERE (DepartmentID = 1 AND Gendor = 'F')
ORDER BY MonthlySalary; -- BY DEFUALT THE ORDER IS ASC


select ID, FirstName,MonthlySalary from Employees
where DepartmentID=1


select ID, FirstName,MonthlySalary from Employees
where DepartmentID=1
Order By FirstName ;

select ID, FirstName,MonthlySalary from Employees
where DepartmentID=1
Order By FirstName ASC;

select ID, FirstName,MonthlySalary from Employees
where DepartmentID=1
Order By FirstName desc;

select ID, FirstName,MonthlySalary from Employees
where DepartmentID=1
Order By MonthlySalary ;


select ID, FirstName,MonthlySalary from Employees
where DepartmentID=1
Order By MonthlySalary Desc;

select ID, FirstName,MonthlySalary from Employees
where DepartmentID=1
Order By FirstName , MonthlySalary ;


-----------------------------------------------------
--Select Top Statement
-----------------------------------------------------

SELECT TOP 10 * FROM Employees;


SELECT TOP 10 FirstName,DepartmentID FROM Employees;

SELECT TOP 10 PERCENT FirstName,MonthlySalary FROM Employees;


SELECT FirstName, MonthlySalary FROM Employees WHERE MonthlySalary IN
(
	SELECT DISTINCT TOP 3 MonthlySalary FROM Employees
	ORDER BY MonthlySalary DESC
)
ORDER BY MonthlySalary DESC


SELECT FirstName, MonthlySalary FROM Employees WHERE MonthlySalary IN
(
	SELECT DISTINCT TOP 3 MonthlySalary FROM Employees
	ORDER BY MonthlySalary ASC
)
ORDER BY MonthlySalary

-----------------------------------------------------
--Select As Statement
-----------------------------------------------------

SELECT A = 5*4, B = 10/2
FROM Employees;

SELECT ID, FullName = FirstName + ' ' + LastName FROM Employees;


SELECT ID, FirstName + ' ' + LastName AS FullName FROM Employees;

SELECT ID, FirstName + ' ' + LastName AS FullName,  Age = DATEDIFF(YEAR,DateOfBirth,getDate())  FROM Employees

SELECT ID, FirstName + ' ' + LastName AS FullName, MonthlySalary, 
	BounusAmount = MonthlySalary * BonusPerc FROM Employees  ;

SELECT ID, FirstName + ' ' + LastName AS FullName, MonthlySalary, 
	YearlySalary = MonthlySalary * 12 FROM Employees;

SELECT ID, FirstName + ' ' + LastName AS FullName, MonthlySalary,
	BonusAmount = MonthlySalary * BonusPerc,
	YearlySalary = MonthlySalary * 12 FROM Employees;


-----------------------------------------------------
--Between Operator
-----------------------------------------------------

USE HR_Database
SELECT * FROM Employees
WHERE (MonthlySalary >= 500) AND (MonthlySalary <= 1000);


SELECT * FROM Employees
WHERE MonthlySalary BETWEEN 500 AND 1000;

-----------------------------------------------------
--Count, Sum, Avg, Min, Max Functions
-----------------------------------------------------

SELECT TotalCountSalary = COUNT(MonthlySalary),
		TotalSalary = SUM(MonthlySalary),
		AverageSalary = AVG(MonthlySalary),
		MinSalary = MIN(MonthlySalary),
		MaxSalary = Max(MonthlySalary)
FROM Employees;

SELECT TotalCountSalary = COUNT(MonthlySalary),
		TotalSalary = SUM(MonthlySalary),
		AverageSalary = AVG(MonthlySalary),
		MinSalary = MIN(MonthlySalary),
		MaxSalary = Max(MonthlySalary)
FROM Employees WHERE DepartmentID = 5;

SELECT * FROM Employees;

SELECT TotalCount =  COUNT(ID) FROM Employees;

SELECT ResignedEmployees =  COUNT(ExitDate) FROM Employees; --Count Only Not NULL.

-----------------------------------------------------
--Group By Statement
-----------------------------------------------------

SELECT  DepartmentID, TotalCountSalary = COUNT(MonthlySalary),
		TotalSalary = SUM(MonthlySalary),
		AverageSalary = AVG(MonthlySalary),
		MinSalary = MIN(MonthlySalary),
		MaxSalary = Max(MonthlySalary)
		FROM Employees; -- ERROR

SELECT Gendor, TotalCountSalary = COUNT(MonthlySalary),
		TotalSumSalary = SUM(MonthlySalary),
		AverageSalary = AVG(MonthlySalary),
		MinSalary = MIN(MonthlySalary),
		MaxSalary = Max(MonthlySalary)
		FROM Employees
		GROUP BY Gendor
		ORDER BY Gendor;

-----------------------------------------------------
--Important Questions on Group By Statement
-----------------------------------------------------

--1--Number of employees in each department
select DepartmentID, CountTotalEmployees = Count(ID)
		from Employees
		group by DepartmentID
		order by DepartmentID;

--2--Sum of salaries on each department
select
	DepartmentID,
	TotalSalaries = Sum(MonthlySalary)
from Employees
group by DepartmentID
order by DepartmentID;

--3--Lowest salary in each department
select 
	DepartmentID,
	MinMonthlySalary = Min(MonthlySalary)
from Employees
group by DepartmentID
order by DepartmentID;

--4--Highest salary in each department
select 
    DepartmentID, 
    Max(MonthlySalary) as HighestSalary
from Employees
group by DepartmentID
order by DepartmentID;

--5--Most recent hire date in each depratment
select
	DepartmentID,
	Max(HireDate)
from Employees
group by DepartmentID
order by DepartmentID;

--6--Oldest hire date in each depratment
select 
	DepartmentID,
	Min(HireDate)
from Employees
group by DepartmentID
order by DepartmentID;

--7--Number of employees who got hired each year
select 
	distinct Year = Year(HireDate),
	EmpHiredCount = Count(ID)
from Employees
group by Year(HireDate)
order by Year(HireDate)

 

--7--Number of employees who got In Specific Year(1994)
select Year = Year(HireDate),--In Specific Year
	ID, FirstName, HireDate
from Employees
where Year(HireDate) = 1994;

--9--Number of employees and average salary for each in every department 
select 
	DepartmentID,
	NumberOfEmployees = Count(ID),
	AverageSalary = Avg(MonthlySalary)	
from Employees
group by DepartmentID
order by DepartmentID;

--10--Lowest and highest salary in each department
select 
	DepartmentID,
	DepartmentName = 
	(select Departments.Name from Departments where Departments.ID in (Employees.DepartmentID)),
	Min(MonthlySalary) as MinSalary ,
	Max(MonthlySalary) as MaxSalary 
from Employees
group by DepartmentID
order by DepartmentID;

--11--Number of employees from each country
select 
	CountryID,
	CountryName = 
	(select Countries.Name from Countries where Countries.ID = CountryID) ,
	EmployeesCount = Count(ID)
from Employees
group by CountryID
order by CountryID

--12--Sum of Bonus percentage for each depratment
select 
	DepartmentID,
	Sum(BonusPerc) as TotalBounusCount 
from Employees
group by DepartmentID
order by DepartmentID


-----------------------------------------------------
--Having Statement
-----------------------------------------------------

--The HAVING clause was added to SQL because
--the WHERE keyword cannot be used with aggregate functions in a direct way.

--Having is a filteration for the out result of group by agregate function. 

select DepartmentID, TotalCount=Count(MonthlySalary), 
	   TotalSum=Sum(MonthlySalary),
	   Average=Avg(MonthlySalary),
	   MinSalary=Min(MonthlySalary),
	   MaxSalary=Max(MonthlySalary) 
from Employees
Group By DepartmentID
having Count(MonthlySalary)> 100
order by DepartmentID

--Same Statement Using Where Satement
select * from (
	select DepartmentID, TotalCount=Count(MonthlySalary), 
		   TotalSum=Sum(MonthlySalary),
		   Average=Avg(MonthlySalary),
		   MinSalary=Min(MonthlySalary),
		   MaxSalary=Max(MonthlySalary) 
	from Employees
	Group By DepartmentID
)T1 -- Make name for the result table
where T1.TotalCount >= 100
order by T1.DepartmentID;


-----------------------------------------------------
--Like Operator
-----------------------------------------------------

Select FirstName from Employees
where FirstName LIKE 'a%';


Select FirstName from Employees
where FirstName LIKE '%a';

Select FirstName from Employees
where FirstName LIKE '%ella%';

--the second letter is a
Select FirstName from Employees
where FirstName LIKE '_a%';

--the third letter from the end is a
Select FirstName from Employees
where FirstName LIKE '%a__';

--start with a and name is 3 letters only
Select FirstName from Employees
where FirstName LIKE 'a__';

--start with a and name is atleast 2 letters
Select FirstName from Employees
where FirstName LIKE 'a_%';

--start with a and name is atleast 5 letters
Select FirstName from Employees
where FirstName LIKE 'a____%';

select 
	DepartmentID,
	count(*) as EmpCount
from Employees
where FirstName like 'a%' and BonusPerc > 0 
group by DepartmentID
having count(*) > 2

-----------------------------------------------------
-- WildCards
-----------------------------------------------------

--Execute these satatements to update data
Update Employees 
set FirstName ='Mohammed' , LastName='Abu-Hadhoud'
where ID= 285;


Update Employees 
set FirstName ='Mohammad' , LastName='Maher'
where ID= 286;

--------------------------------

-- will search form Mohammed or Mohammad
select ID, FirstName, LastName from Employees
Where firstName like 'Mohamm[ae]d';

-------------------------------------

--You can use Not 
select ID, FirstName, LastName from Employees
Where firstName Not like 'Mohamm[ae]d';

--------------------

select ID, FirstName, LastName from Employees
Where firstName like 'a%' or firstName like 'b%' or firstName like 'c%';


-- search for all employees that their first name start with a or b or c
select ID, FirstName, LastName from Employees
Where firstName like '[abc]%';


---------------------------------
-- search for all employees that their first name start with any letter from a to l
select ID, FirstName, LastName from Employees
Where firstName like '[a-l]%';
---------------------------------

--=====================================================================
--								Joins
--=====================================================================


-----------------------------------------------------
-- Restore Shop Database
-----------------------------------------------------

Restore Database Shop_Database From Disk = 'C:\Shop_Database.bak'
use Shop_Database;
EXEC sp_changedbowner 'sa';


-----------------------------------------------------
-- Inner Join
-----------------------------------------------------

select 
	Customers.CustomerID , Customers.Name,
	Orders.Amount as OrderAmount
	from Customers inner join Orders 
	On Customers.CustomerID = Orders.CustomerID

-- Join Same As Inner Join
select 
	Customers.CustomerID , Customers.Name,
	Orders.Amount as OrderAmount
	from Customers join Orders 
	On Customers.CustomerID = Orders.CustomerID;

Use HR_Database;

select 
	Employees.FirstName + ' ' + Employees.LastName as FullName,
	Countries.Name AS CountryName,
	Employees.MonthlySalary,
	Departments.Name AS DepName
from Employees Inner Join Departments
	On Employees.DepartmentID = Departments.ID 
	inner join Countries
	On Employees.CountryID = Countries.ID	
where Departments.Name = 'Finance' and MonthlySalary > 1000

-----------------------------------------------------
-- Left Outer Join
-----------------------------------------------------

Use Shop_Database;
SELECT Customers.CustomerID, Customers.Name, Orders.Amount
FROM     Customers LEFT OUTER JOIN
                  Orders ON Customers.CustomerID = Orders.CustomerID


Use Shop_Database;
SELECT Customers.CustomerID, Customers.Name, Orders.Amount
FROM     Customers LEFT JOIN
                  Orders ON Customers.CustomerID = Orders.CustomerID

-----------------------------------------------------
-- Right Join & Full Join
-----------------------------------------------------

SELECT Customers.CustomerID, Customers.Name, Orders.Amount
FROM     Customers RIGHT OUTER JOIN
                  Orders ON Customers.CustomerID = Orders.CustomerID


SELECT Customers.CustomerID, Customers.Name, Orders.Amount
FROM     Customers FULL OUTER JOIN
                  Orders ON Customers.CustomerID = Orders.CustomerID


-----------------------------------------------------
-- Exersises
-----------------------------------------------------

--Get customer names and their order amounts
select 
	Customers.Name,
	Orders.Amount
from Customers Inner Join Orders ON Customers.CustomerID = Orders.CustomerID; 

--Get each customer’s total order amount and number of orders
select 
	c.CustomerID,
	c.Name,
	sum(o.Amount) as TotalAmount,
	Count(o.Amount) as OrdersCount
from Customers c
inner join Orders o
on c.CustomerID = o.CustomerID
group by c.CustomerID, c.Name;

--Get customers whose total order amount is greater than 300
Select		
	c.CustomerID,
	c.Name,
	Sum(o.Amount) as TotalOrdersAmount,
	Count(o.Amount) as OrdersCount
from Customers c 
inner join Orders o
ON c.CustomerID = o.CustomerID
Group by c.CustomerID , c.Name
having Sum(o.Amount) > 300;

--Get customers who have no orders
select 
	c.CustomerID,
	c.Name,
	o.Amount
from Customers c
left join Orders o 
On c.CustomerID = o.CustomerID
where o.Amount is null
group by o.Amount
having o.Amount is null

--Get customers who have at least one order
select 
	c.CustomerID,
	c.Name,
	count(o.OrderID) as TotalOrdersCount
from Customers c
left join Orders o
on c.CustomerID = o.CustomerID
group by c.CustomerID, c.Name
having count(o.OrderID) >= 1;



--Get customer Name and highest order amount (Max) for each customer
select c.CustomerID, c.Name, Max(o.Amount) as "Max Amount"
from Customers c Join Orders o
On c.CustomerID = o.CustomerID
group by c.CustomerID, c.Name


--Get the customer who has the highest total order amount
Select Top 1
	C.CustomerID, c.Name, Sum(O.Amount) as TotalOrdersSum
from Customers c inner join Orders o
on c.CustomerID = O.CustomerID
group by c.CustomerID ,c.Name
order by TotalOrdersSum desc

-----------------------------------------------------
--  Views
-----------------------------------------------------

Use HR_Database;

--Without using View
--select * from Employees Where ExitDate Is Null;

CREATE VIEW ActiveEmployees AS
SELECT *
FROM Employees
WHERE ExitDate is null;





create view ResignedEmployees as
select * from Employees
Where ExitDate is not Null










select ID, FirstName + ' ' + LastName AS FullName, MonthlySalary
from ActiveEmployees

--Question 1 – IT Employees
--Create a view called IT_Employees that shows FirstName, LastName,
--and Departments.Name as DeptName for all employees who work in the IT department.

create view IT_Employees as 
select 
	FirstName,
	LastName,
	Departments.Name as DeptName
from Employees inner join  Departments
On Employees.DepartmentID = Departments.ID
where Departments.Name = 'IT'


--Question 2 – Employees with Country

--Create a view called Employee_Countries that shows FirstName, LastName, 
--and the country name (Countries.Name) for each employee.

create view Employee_Countries as 
select 
	e.FirstName, 
	e.LastName,
	c.Name as CountryName
from Employees e inner join Countries c
on e.CountryID = c.ID


--Question 3 – High Salary Employees

--Create a view called HighSalaryEmployees that shows FirstName, LastName,MonthlySalary, 
--and department name (Departments.Name as DeptName) for all employees whose monthly salary is greater than 2700.

create view HighSalaryEmployees as
select 
	Employees.FirstName,
	Employees.LastName,
	Employees.MonthlySalary,
	Departments.Name as DepName
from Employees join Departments
On Employees.DepartmentID = Departments.ID
where MonthlySalary > 2700;



--Question 4 – Recent Hires

--Create a view called RecentHires that shows FirstName, LastName, HireDate, and department name (Departments.Name as DeptName) 
--for all employees who were hired after January 1, 2022.

create view RecentHires as 
select 
	Employees.FirstName,
	Employees.LastName,
	Employees.HireDate,
	Departments.Name as DepName
from Employees inner join Departments
on Employees.DepartmentID = Departments.ID
where HireDate >= '2022-01-01';


--Question 5 – Employee Salary with Bonus

--Create a view called EmployeeSalaryWithBonus that shows FirstName, LastName, MonthlySalary, BonusPerc, 
--and a calculated column TotalSalary which is MonthlySalary + (MonthlySalary * BonusPerc / 100).


create view EmployeeSalaryWithBonus as 
select 
	Employees.FirstName, 
	Employees.LastName,
	Employees.MonthlySalary,
	Employees.BonusPerc,
	TotalSalary = MonthlySalary + (MonthlySalary * BonusPerc / 100)
from Employees 


-----------------------------------------------------
-- Exists
-----------------------------------------------------

use Shop_Database;

select X='yes'
where  exists 
( 
	select * from Orders
	where customerID= 3 and Amount < 600
)


select * from Customers T1
where exists 
( 
	select * from Orders
	where Orders.customerID = T1.CustomerID and Orders.Amount < 600
)

--More optimized and faster
select * from Customers T1
where exists 
( 
	select top 1 * from Orders
	where customerID= T1.CustomerID and Amount < 600
)


--More optimized and faster
select * from Customers T1
where exists 
(
   	select top 1 R='Y'  from Orders
	where customerID= T1.CustomerID and Amount < 600
)


use HR_Database;
--1️ Employees in a specific department

--List all employees who belong to the “IT” department.
--Use EXISTS to check the department.

select 
	e.ID,
	e.FirstName,
	d.Name as DepName
from Employees e
inner join Departments d
on e.DepartmentID = d.ID
where exists (
	select R = 'y'
	from Departments
	where DepartmentID = Departments.ID 
	and Departments.Name = 'IT'
);


--2️ Employees with high bonus

--List all employees who have a BonusPerc greater than 20%.
--Use EXISTS to filter employees.

select 
	e.FirstName,
	e.BonusPerc
from Employees e
where Exists
(
	select 1
	from Employees 
	where Employees.ID = e.ID  
	and Employees.BonusPerc > 0.20
)


--3️ Employees working in certain countries

--List all employees who work in countries whose name starts with “U”.
--Use EXISTS to check the country.

select
	e.ID,
	e.FirstName,
	e.LastName,
	c.Name
from Employees e inner join Countries c
on e.CountryID = c.ID
where exists 
(
	select 1
	from Countries
	where e.CountryID = Countries.ID 
	and Countries.Name Like 'U%'
)order by e.FirstName;

select * from employees



select 
	e.ID,
	e.FirstName,
	e.LastName
from Employees e
where exists (
	select 1
	from Countries c
	where c.ID = e.CountryID
	and c.Name like 'U%'
)
order by e.FirstName;


-----------------------------------------------------
--  Union
-----------------------------------------------------

select * from ActiveEmployees
Union 
select * from  ResignedEmployees

select * from Departments
union -- Defult is Distinct
select * from departments

select * from Departments
union ALL -- Without Distinct
select * from departments








































































































































