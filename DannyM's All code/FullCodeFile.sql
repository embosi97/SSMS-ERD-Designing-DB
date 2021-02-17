

USE QueensCollegeSchedulSpring2019;
-- ### SEQUENCE OBJECT

-- ============================================= 
-- Author:  Danny Mancheno
-- Procedure:  	
-- Create date:  5/10/2020
-- Description:
-- =============================================



-- ============================================= 
-- Author:  Danny Mancheno
-- Procedure:  	Make increment sequence
-- Create date:  5/10/2020
-- Description: Using a 
-- =============================================

GO
CREATE OR ALTER PROC MakeIncrementProc
AS
BEGIN

DROP SEQUENCE [Process].[CoursesPKIncrement]
	CREATE SEQUENCE [Process].[CoursesPKIncrement]
	START WITH 1 INCREMENT BY 1
	MINVALUE 1;
	
	-- reset

	ALTER SEQUENCE [Process].[CoursesPKIncrement] RESTART WITH 1;

END;


---- ============================================= 
-- Author:  Danny Mancheno
-- Procedure: Create functions
-- Create date:  5/10/2020
-- Description: Area below creates functions used to fill cols.
-- =============================================
	-- GET HOUR NUMBER

	GO
	CREATE OR ALTER FUNCTION func.GetHour (@param VARCHAR(MAX))
	RETURNS VARCHAR(MAX)
	AS
	BEGIN
		DECLARE @GetHourIndex AS INT;
		SET @GetHourIndex = CHARINDEX('(',@param)+1
		
		DECLARE @Ans AS VARCHAR(MAX);
		SET @Ans = SUBSTRING(@param, @GetHourIndex, 1) ;
		RETURN @Ans;
	END;
	GO
	-- GET CREDIT NUMBER
	GO
	CREATE OR ALTER FUNCTION func.GetCred (@param VARCHAR(MAX))
	RETURNS VARCHAR(MAX)
	AS
	BEGIN
	DECLARE @GetCredIndex AS INT;
	SET @GetCredIndex = CHARINDEX(')',@param)-1
		
	DECLARE @Ans AS VARCHAR(MAX);
	SET @Ans = SUBSTRING(@param, @GetCredIndex, 1);
	RETURN @Ans;
	END
	GO
	 -- GET COURSE NAME
	GO
	CREATE OR ALTER FUNCTION func.GetName (@param VARCHAR(MAX))
	RETURNS VARCHAR(MAX)
	AS
	BEGIN
	
		DECLARE @answer AS VARCHAR(max) = TRIM('(' FROM SUBSTRING( @param, 1, CHARINDEX('(',@param)))
		return @answer;
	END
	GO
	-- GET DEP NAME FOR DEP referencing
	GO
	CREATE OR ALTER FUNCTION func.GetDepName (@param VARCHAR(MAX))
	RETURNS VARCHAR(MAX)
	AS
	BEGIN
	
		DECLARE @answer AS VARCHAR(max) = SUBSTRING( @param, 1, CHARINDEX(' ',@param));
		return @answer;
	END
	GO

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


-- ### TRUNCATE DATA
ALTER TABLE Project3.CourseToMode NOCHECK CONSTRAINT ALL
DELETE FROM Project3.Courses
ALTER TABLE Project3.CouseToMode CHECK CONSTRAINT ALL
SELECT * FROM project3.courses;

---- ============================================= 
-- Author:  Danny Mancheno
-- Procedure: Process.InsertCourseData
-- Create date: 5/10/2020
-- Description: Insert data into courses table
-- =============================================
GO
CREATE OR ALTER PROC process.InsertCourseData
AS
BEGIN

	INSERT INTO Project3.Courses
	(

		CourseName, 
		CourseCode,
		HR,
		CR,
		CourseDay,
		CourseTime,
		Section,
		Description
	)
	SELECT
		func.getName([Course (hr, crd)]),
		Code,
		func.getHour([Course (hr, crd)]),
		func.GetCred([Course (hr, crd)]),
		Day,
		Time,
		Sec,
		Description
	FROM
		UploadFile.CoursesSpring2019 AS original;

	 -- INSERT INTO FK
	MERGE INTO
	Project3.Courses
	USING
	Project3.Department
	ON DepartmentName = TRIM(SUBSTRING(courseName,1,CHARINDEX(' ',courseName,-1)))
	WHEN MATCHED THEN
	UPDATE SET Courses.DepartmentId = Department.DepartmentId;

	-- Fix anomolys
	-- FIX 

	UPDATE Project3.Courses
	SET courseDay = 'N/A' WHERE CourseDay = ' ';

	UPDATE Project3.Courses
	SET CourseTime = 'N/A' WHERE CourseTime = '-';

	UPDATE Project3.Courses
	SET HR = 'N/A' WHERE HR NOT LIKE N'[0-9]';

	UPDATE Project3.Courses
	SET CourseName = 'N/A',
		CourseCode = 'N/A',
		CourseTime = 'N/A'
	WHERE CourseName = '';
END 
	-- UPDATE WORKFLOWSTEPS

select * from Project3.Courses;



-- ########################################################################################
-- ########################################################################################
-- ##########################	  	PLAYGROUND AREA BELOW	  	   ########################
-- ########################################################################################
-- ########################################################################################



SELECT * FROM Project3.Department WHERE DepartmentName = 'Math'
SELECT COUNT(*) AS Departments FROM Project3.Department GROUP BY DepartmentName;



-- Test

UPDATE Project3.Courses
SET DepartmentId = 1000
WHERE CourseId = 4257;


select * from Project3.Department;

UPDATE Project3.Department
SET DepartmentId = 1000
WHERE DepartmentId = 1;


---- =========================================== 
-- Author:  Danny Mancheno
-- Procedure: Query1
-- Create date: 5/10/2020
-- Description: Show how many Courses are the departments
-- =============================================
	
	-- Query
	GO
	SELECT 
		COUNT(CourseName) AS Courses_Under, DepartmentId AS Department
	FROM Project3.Courses 
	GROUP BY DepartmentId
	ORDER BY Courses_Under DESC,DepartmentId
	GO


---- =========================================== 
-- Author:  Danny Mancheno
-- Procedure: Query2
-- Create date: 5/10/2020
-- Description: Finding the annoying classes with many hours and no credit!
-- =============================================
	WITH MyCTE AS
	(
		SELECT CourseName AS cName, Hr AS WeeklyHours, CR as TotalCredits FROM Project3.Courses  
		WHERE DepartmentID NOT LIKE 'N/A'
	)
	SELECT DISTINCT * from MyCTE
	WHERE WeeklyHours > '5' AND TotalCredits = '0';

---- =========================================== 
-- Author:  Danny Mancheno
-- Procedure: Query3
-- Create date: 5/10/2020
-- Description: Showing data between the two tables
-- =============================================

	SELECT 
		L.DepartmentId, L.DepartmentName, C.CourseName, C.CourseDay
	FROM
		Project3.Courses AS C
	INNER JOIN 
		Project3.Department AS L 
		ON L.DepartmentId = C.DepartmentId; 



