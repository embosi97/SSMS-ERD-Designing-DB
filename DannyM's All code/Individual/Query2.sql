
---- =========================================== 
-- Author:  Danny Mancheno
-- Procedure: Query5
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
