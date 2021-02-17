
--- ============================================= 
-- Author:  Danny Mancheno
-- Procedure: Create functions
-- Create date:  5/10/2020
-- Description: Create the coursetable 
-- =============================================



CREATE OR ALTER PROC process.CreateCourseTable
AS
BEGIN
	DROP TABLE Project3.Courses;
	CREATE TABLE [Project3].[Courses](
		CourseId			INT				NOT NULL DEFAULT( NEXT VALUE FOR Process.CoursesPKIncrement) PRIMARY KEY,
		DepartmentId		INT				NULL
		CONSTRAINT FK_Courses_Department FOREIGN KEY (DepartmentId) REFERENCES [Project3].[Department](DepartmentId),
		CourseName			VARCHAR(100)		NOT NULL DEFAULT('TBD'),
		CourseCode			VARCHAR(100)		NOT NULL DEFAULT('TBD'),
	
		HR					VARCHAR(100)		NOT NULL DEFAULT('TBD'),
		CR					VARCHAR(100)		NOT NULL DEFAULT('TBD'),
		CourseDay			VARCHAR(100)		NULL DEFAULT('TBD'),
		CourseTime			VARCHAR(MAX)		NULL DEFAULT('TBD'),
		Section				VARCHAR(MAX)		NULL DEFAULT('TBD'),
		Description			VARCHAR(100)		NOT NULL DEFAULT('TBD'),
		ClassTime			CHAR(5)			NULL DEFAULT('9:15'),
		LastName			VARCHAR(30)		NULL DEFAULT('Mancheno'),
		FirstName			VARCHAR(30)		NULL DEFAULT('Danny'),
		QmailEmailAddress	VARCHAR(100)		NULL DEFAULT('Danny.mancheno24@qmail.cuny.edu'),
		DateAdded			Datetime2		Default(SysDatetime()),
		DateOfLastUpdate	Datetime2		Default(SysDateTime()),
		AuthorizedUserId	INT				NULL Default(24),
	);
END
