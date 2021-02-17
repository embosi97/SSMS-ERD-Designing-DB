
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

