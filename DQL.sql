
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




























