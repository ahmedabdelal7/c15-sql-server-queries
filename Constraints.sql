------------------------------------------------
-- Primary Key Constraint
------------------------------------------------

use master ;

create Database DB4

use DB4;

create Table StudentS
(
	ID INT NOT NULL ,
	FirstName varchar(20)NOT NULL,
	LastName varchar(20) NULL,
	Phone Varchar(11) NULL,
	Age smallint NULL

	Constraint PK_Students Primary Key (ID)

);

ALTER TABLE Students
Drop Constraint PK_Students

ALTER TABLE Students
ADD Constraint PK_Students Primary Key (ID,FirstName)

