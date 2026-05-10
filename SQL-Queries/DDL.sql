
--==============================================================
-------------SQL - Data Definition Language - DDL-------------
--==============================================================

------------------------------------------
--CREATE DATABASE IF NOT EXISTS
------------------------------------------

if not Exists (select * from sys.databases where name = 'DB1')
	begin
		create database DB1;
	end

------------------------------------------
--Switch Database
------------------------------------------

USE master;
USE DB1;

------------------------------------------
--Drop Database
------------------------------------------

USE master;
DROP DATABASE DB2;

------------------------------------------
--Drop Database IF EXISTS
------------------------------------------

USE MASTER;
IF EXISTS(SELECT * FROM sys.databases WHERE NAME = 'DB1')
	BEGIN
		DROP DATABASE DB1;
	END

------------------------------------------
--Create Table
------------------------------------------

CREATE TABLE Students(
	ID INT NOT NULL,
	"FName" NVARCHAR(20) NOT NULL,--[] or "" means that column may have spaces 
	"LName" NVARCHAR(20) NULL,--but "" general in all aql langs, and [] just in SQL Server
	UserName VARCHAR(50) NOT NULL,
	Phone CHAR(10) NULL
	PRIMARY KEY (ID)
)

------------------------------------------
--Drop Table
------------------------------------------

USE DB1;
DROP TABLE Students;
DROP TABLE IF EXISTS Students;

--==============================================================
-----------------DDL - Alter Table Statement------------------
--==============================================================

------------------------------------------
--Add Column
------------------------------------------

ALTER TABLE Students -- EDIT THE STRUCTURE OF THE TABLE NOT DATA
ADD Gender CHAR(1) NOT NULL

--OR ADD MULTIBLE COLUMNS
USE DB1;

ALTER TABLE Students
	ADD 
		Gender CHAR(1) NOT NULL,
		Phone CHAR(10) NULL,
		SSN CHAR(24) NOT NULL

------------------------------------------
--Rename Column
------------------------------------------

--exec sp_rename 'table_name.old_column_name', 'new_column_name', 'COLUMN';

EXEC sp_rename 'Students.Phono', 'Phone', 'COLUMN';--IN SQL SERVER ONLY

ALTER TABLE Students
RENAME COLUMN Phono TO Phone--IN ALL SQL LANGS

------------------------------------------
--Rename Table
------------------------------------------

--USING STORED PROCEDURE SP_RENAME
--exec sp_rename 'old_table_name', 'new_table_name';

EXEC SP_RENAME 'Stodents', 'Students';--IN SQL SERVER ONLY

ALTER TABLE Stodents
RENAME TO Students; --IN ALL SQL LAGS

------------------------------------------
--Modify a column
------------------------------------------

--IN OTHER SQL LANGS:
ALTER TABLE Students
MODIFY COLUMN Phone CHAR(12) NULL;

--IN SQL SERVER LANG:
ALTER TABLE Students
ALTER COLUMN Phone CHAR(12) NULL;

------------------------------------------
--Delete a column
------------------------------------------

ALTER TABLE Students
DROP COLUMN SSN;

--==============================================================
------------------Backup & Restore Database-------------------
--==============================================================

------------------------------------------
--Backup Database FULL
------------------------------------------

BACKUP DATABASE DB1
TO DISK = 'C:\DB1.bak';

------------------------------------------
--Differential Backup
------------------------------------------

BACKUP DATABASE DB1
TO DISK = 'C:\DB1.bak'
WITH DIFFERENTIAL;


------------------------------------------
--Restore Database
------------------------------------------

USE MASTER
RESTORE DATABASE DB1
FROM DISK = 'C:\DB1.bak';



--See You In DML .......
