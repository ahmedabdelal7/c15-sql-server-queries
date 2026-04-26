
--=====================================================================
----				    	SQL - Queries
--=====================================================================

-------------------------------------------------------
----Preparing HR_Database
-------------------------------------------------------

----FIRST QUERY:

--USE MASTER;

--RESTORE DATABASE HR_Database FROM DISK = 'C:\HR_Database.bak';

----SECOND QUERY:

--use HR_Database;

--EXEC sp_changedbowner 'sa';

--SELECT * FROM Employees;


----DONE RESTORING..

-------------------------------------------------------
----Select Statement
-------------------------------------------------------

--SELECT * FROM Employees;

--SELECT Employees.* FROM Employees;

--SELECT ID, FirstName FROM Employees;

--SELECT ID, FirstName, DateOfBirth FROM Employees;

--SELECT * FROM Departments;

--SELECT * FROM Countries;

-------------------------------------------------------
----Select Statement
-------------------------------------------------------