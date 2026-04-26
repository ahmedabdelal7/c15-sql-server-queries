
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





















































