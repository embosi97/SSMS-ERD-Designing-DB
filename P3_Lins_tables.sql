/**** Department Table *****/
GO
CREATE SCHEMA Department
GO
DROP PROCEDURE IF EXISTS DepartmentTable
GO
CREATE PROCEDURE DepartmentTable
AS
BEGIN

DROP TABLE IF EXISTS [Project3].[Department]
CREATE TABLE [Project3].[Department] (
		[DepartmentId] INT PRIMARY KEY NOT NULL IDENTITY(1, 1)
		,[DepartmentName] VARCHAR(50) NOT NULL
		,[ClassTime] CHAR(5) NULL DEFAULT('9:15')
		,[LastName] VARCHAR(30) NOT NULL DEFAULT('Chen')
		,[FirstName] VARCHAR(30) NOT NULL DEFAULT('Lin')
		,[QmailEmailAdress] VARCHAR(50) NOT NULL DEFAULT('lin.chen22@qmail.cuny.edu')
		,[DateAdded] DATETIME2(7) NOT NULL DEFAULT sysdatetime()
		,[DateOfLastUpdate] DATETIME2(7) NOT NULL DEFAULT sysdatetime()
		,[AuthorizedUserId] INT NULL DEFAULT(22)
		);
END
GO

EXEC DepartmentTable;

--truncate table [Project3].[Department];
	INSERT INTO [Project3].[Department]
	(DepartmentName)
	SELECT DISTINCT
		SUBSTRING([Course (hr, crd)],1,CHARINDEX(' ', [Course (hr, crd)])-1) AS DepartmentName
	FROM [Uploadfile].[CoursesSpring2019]
	WHERE [Course (hr, crd)] >='A'

--SELECT * FROM [Project3].[Department];

EXEC usp_TrackWorkFlow @StartTime = @Start
 ,@WorkFlowDescription = 'Load Department Table'
 ,@WorkFlowStepTableRowCount = @@ROWCOUNT;
GO


/******InstructorsDepartment******/
DROP PROCEDURE IF EXISTS InstructorsDepartmentTable
GO
CREATE PROCEDURE InstructorsDepartmentTable
AS
BEGIN
-- 567

DROP TABLE IF EXISTS [Project3].[InstructorsDepartment]
CREATE TABLE [Project3].[InstructorsDepartment] (
		[InstructorDeptId] INT PRIMARY KEY NOT NULL IDENTITY(1, 1)
		,[InstructorId] INT NOT NULL
		,[DepartmentId] INT NOT NULL
		,[ClassTime] CHAR(5) NULL DEFAULT('9:15')
		,[LastName] VARCHAR(30) NOT NULL DEFAULT('Chen')
		,[FirstName] VARCHAR(30) NOT NULL DEFAULT('Lin')
		,[QmailEmailAdress] VARCHAR(50) NOT NULL DEFAULT('lin.chen22@qmail.cuny.edu')
		,[DateAdded] DATETIME2(7) NOT NULL DEFAULT sysdatetime()
		,[DateOfLastUpdate] DATETIME2(7) NOT NULL DEFAULT sysdatetime()
		,[AuthorizedUserId] INT NULL DEFAULT(22)
		,CONSTRAINT [FK_InstructorId] FOREIGN KEY ([InstructorId]) REFERENCES [Project3].[Instructor]([InstructorId])
		,CONSTRAINT [FK_DepartmentId] FOREIGN KEY ([DepartmentId]) REFERENCES [Project3].[Department]([DepartmentId])
		);

END
GO
--EXEC InstructorsDepartmentTable

-- truncate table [Project3].[InstructorsDepartment]
INSERT INTO [Project3].[InstructorsDepartment]
	(InstructorId, DepartmentId)
SELECT DISTINCT
	VAL.InstructorId AS InstructorId
    , VAL.DepartmentId AS DepartmentId
FROM 
    (SELECT DISTINCT 
        INS.InstructorId
        , DEPT.DepartmentId
    FROM Project3.Instructor AS INS
        INNER JOIN uploadfile.CoursesSpring2019 AS ORIG ON INS.InstructorFullName = ORIG.Instructor
        INNER JOIN Project3.Department AS DEPT ON SUBSTRING(ORIG.[Course (hr, crd)],1,CHARINDEX(' ', ORIG.[Course (hr, crd)])) = DEPT.DepartmentName
        ) AS VAL

--SELECT * FROM [Project3].[InstructorsDepartment];

EXEC usp_TrackWorkFlow @StartTime = @Start
 ,@WorkFlowDescription = 'Load InstructorDepartment Table'
 ,@WorkFlowStepTableRowCount = @@ROWCOUNT;
GO

/***** ClassRoomLocation ******/
DROP TABLE IF EXISTS [Project3].[ClassRoomLocation]
	CREATE TABLE [Project3].[ClassRoomLocation] (
		[ClassRoomLocationId] INT PRIMARY KEY NOT NULL IDENTITY(1, 1)
		,[BuildingLocationId] INT NOT NULL
		,[RoomLocation] VARCHAR(50) NOT NULL
		,[ClassTime] CHAR(5) NULL DEFAULT('9:15')
		,[LastName] VARCHAR(30) NOT NULL DEFAULT('Chen')
		,[FirstName] VARCHAR(30) NOT NULL DEFAULT('Lin')
		,[QmailEmailAdress] VARCHAR(50) NOT NULL DEFAULT('lin.chen22@qmail.cuny.edu')
		,[DateAdded] DATETIME2(7) NOT NULL DEFAULT sysdatetime()
		,[DateOfLastUpdate] DATETIME2(7) NOT NULL DEFAULT sysdatetime()
		,[AuthorizedUserId] INT NULL DEFAULT(22)
		,CONSTRAINT [FK_BuildingID] FOREIGN KEY ([BuildingLocationId]) REFERENCES [Project3].[BuildingLocation]([BuildingLocationId])
		);


--truncate table [Project3].[ClassRoomLocation];
	INSERT INTO [Project3].[ClassRoomLocation]
	(BuildingLocationId, RoomLocation)
	SELECT DISTINCT
		BUD.BuildingLocationId AS BuildingLocationId
		, ORIG.Location AS RoomLocation
	FROM [Uploadfile].[CoursesSpring2019] AS ORIG 
		INNER JOIN [Project3].[BuildingLocation] AS BUD ON SUBSTRING(ORIG.[Location],1,CHARINDEX(' ', ORIG.[Location])) = BUD.BuildingName

--SELECT * FROM [Project3].[ClassRoomLocation];

EXEC usp_TrackWorkFlow @StartTime = @Start
 ,@WorkFlowDescription = 'Load ClassRoomLocation Table'
 ,@WorkFlowStepTableRowCount = @@ROWCOUNT;
GO


-- update the table work
UPDATE Process.TableWork
--SET WorkedBy = 'Lin'
SET IsFinished = 'Yes'
WHERE TNum = 3

select * from uploadfile.CoursesSpring2019
select * from [Process].[TableWork]
select * from [Project3].[buildinglocation]
select * from Project3.ModeOfInstruction
select * from [Project3].[courses]
select * from Project3.Instructor
select * from Project3.Department
select * from Project3.Class
select * from Project3.CourseToMode
