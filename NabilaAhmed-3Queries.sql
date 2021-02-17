
-- Use CourseToMode and ModeOfInstruction table and Retrive CourseToModeId, ModeId and Mode where the  modes is not 'TBA' which represent the missing data.  
SELECT  C.CourseToModeId, M.ModeId, M.Mode 
FROM [Project3].[CourseToMode] AS C
Inner JOIN [Project3].ModeOfInstruction as M
on  C.CourseToModeId = M.ModeId
WHERE  Mode NOT like N'TBA';

-- Retrive all the classes that are being taught for that course and order by CourseName
SELECT CourseName, COUNT(Section) as NumberOfSections
FROM [Project3].Courses
GROUP BY CourseName
Order By CourseName

SELECT * FROM [Project3].Courses

-- Retrive all the professors where department name = 'CSCI'
SELECT I.InstructorFirstName,I.InstructorLastName
FROM [Project3].[Instructor] AS I
inner JOIN [Project3].[InstructorsDepartment] as ID
ON I.InstructorId = ID.InstructorId
inner join [Project3].[Department] AS D
ON ID.DepartmentId = d.DepartmentId
WHERE d.DepartmentName LIKE  N'CSCI'
