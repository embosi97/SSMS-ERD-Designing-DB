
---- =========================================== 
-- Author:  Danny Mancheno
-- Procedure: Query4
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
