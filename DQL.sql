
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




























