
CREATE SCHEMA Project3


-----------Department---------------------------------------------------------------------------------
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

--EXEC DepartmentTable;
-----------InstructorsDepartment---------------------------------------------------------------------------------
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
----------Instructor----------------------------------------------------------------------------------

DROP PROCEDURE IF EXISTS InstructorTable
GO
CREATE PROCEDURE InstructorTable
AS
BEGIN

DROP TABLE IF EXISTS [Project3].[Instructor]
CREATE TABLE [Project3].[Instructor] (
		[InstructorId] INT PRIMARY KEY NOT NULL IDENTITY(1, 1)
		,[InstructorFullName] VARCHAR(80) NOT NULL
		,[InstructorFirstName] VARCHAR(40) NOT NULL
		,[InstructorLastName] VARCHAR(40) NOT NULL
		,[ClassTime] CHAR(5) NULL DEFAULT('9:15')
		,[LastName] VARCHAR(30) NOT NULL DEFAULT('Ahmed')
		,[FirstName] VARCHAR(30) NOT NULL DEFAULT('Nabila')
		,[QmailEmailAdress] VARCHAR(50) NOT NULL DEFAULT('nabila.ahmed12@qmail.cuny.edu')
		,[DateAdded] DATETIME2(7) NOT NULL DEFAULT sysdatetime()
		,[DateOfLastUpdate] DATETIME2(7) NOT NULL DEFAULT sysdatetime()
		,[AuthorizedUserId] INT NULL DEFAULT(12)
		);
END
GO


------------Courses--------------------------------------------------------------------------------

DROP TABLE IF EXISTS [Project3].[Courses]

CREATE TABLE [Project3].[Courses]
([CourseId] INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
 [DepartmentId] INT NOT NULL,
 [CourseName]     varchar(50) NOT NULL ,
 [CourseCode]   varchar(50) NOT NULL ,
 [(hr, crd)]   varchar(50) NOT NULL ,
 [Description]    varchar(50) NOT NULL ,
 [Day] [varchar](50) NULL,
 [Time] [varchar](50) NULL,
 [Sec] [varchar](50) NULL,
 [ClassTime] char(5) Null Default ('9:15'),
 [LastName] varchar(30) NULL DEFAULT ('Mancheno'),
 [FirstName] varchar(30) NULL DEFAULT ('Danny'),
 [QmailEmailAddress] varchar(30) NULL DEFAULT ('Danny.mancheno24@qmail.cuny.edu'),
 [DateAdded] datetime2 default sysdatetime(),
 [DateOfLastUpdate] datetime2 default sysdatetime(),
 [AuthorizedUserId] int null default (24),
 CONSTRAINT [FK_Courses_Department] FOREIGN KEY ([DepartmentId])  REFERENCES [Project3].[Department]([DepartmentId])
);
End
GO

----------Class----------------------------------------------------------------------------------
DROP TABLE IF EXISTS [Project3].[Class]

CREATE TABLE [Project3].[Class]
([ClassId] INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
 [CourseId] INT NOT NULL,
 [Enrolled]       int NOT NULL ,
 [Limit]          int NOT NULL ,
 [InstructorId] INT NOT NULL,
 [ClassRoomLocationId]     INT NOT NULL , 
 [ModeId] INT NOT NULL,
 [ClassTime] char(5) Null Default ('9:15'),
 [LastName] varchar(30) NULL DEFAULT ('Mancheno'),
 [FirstName] varchar(30) NULL DEFAULT ('Danny'),
 [QmailEmailAddress] varchar(30) NULL DEFAULT ('Danny.mancheno24@qmail.cuny.edu'),
 [DateAdded] datetime2 default sysdatetime(),
 [DateOfLastUpdate] datetime2 default sysdatetime(),
 [AuthorizedUserId] int null default (24),

 CONSTRAINT [FK_Class_Courses] FOREIGN KEY ([CourseId])  REFERENCES [Project3].[Courses]([CourseId]),
 CONSTRAINT [FK_Class_Instructor] FOREIGN KEY  ([InstructorId])  REFERENCES [Project3].[Instructor]([InstructorId]),
 CONSTRAINT [FK_Class_ClassRoomLocation] FOREIGN KEY ([ClassRoomLocationId])  REFERENCES [Project3].[ClassRoomLocation]([ClassRoomLocationId]),
 CONSTRAINT [FK_Class_ModeOfInstructor] FOREIGN KEY ([ModeID])  REFERENCES [Project3].[ModeOfInstruction]([ModeId])
);
GO




----------BuildingLocation----------------------------------------------------------------------------------

DROP PROC IF EXISTS BuildingLocation
GO
CREATE PROC BuildingLocation
AS 
BEGIN
DROP TABLE IF EXISTS [Project3].[BuildingLocation]
CREATE TABLE [Project3].[BuildingLocation] (
		[BuildingLocationId] INT PRIMARY KEY NOT NULL IDENTITY(1, 1)
		,[BuildingName] VARCHAR(30) NOT NULL
		,[ClassTime] CHAR(5) NULL DEFAULT('9:15')
		,[LastName] VARCHAR(30) NOT NULL DEFAULT('Brandwein')
		,[FirstName] VARCHAR(30) NOT NULL DEFAULT('Jason')
		,[QmailEmailAdress] VARCHAR(50) NOT NULL DEFAULT('jason.bradnwein11@qmail.cuny.edu')
		,[DateAdded] DATETIME2(7) NOT NULL DEFAULT sysdatetime()
		,[DateOfLastUpdate] DATETIME2(7) NOT NULL DEFAULT sysdatetime()
		,[AuthorizedUserId] INT NULL DEFAULT(11)
		);
END
GO


-----------ClassRoomLocation---------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS ClassRoomLocation
GO

CREATE PROC ClassRoomLocation
AS
BEGIN
DROP TABLE IF EXISTS [Project3].[ClassRoomLocation]
	CREATE TABLE [Project3].[ClassRoomLocation] (
		[ClassRoomLocationId] INT PRIMARY KEY NOT NULL IDENTITY(1, 1)
		,[RoomLocation] VARCHAR(50) NOT NULL
		,[RoomLocationId] INT NOT NULL
		,[BuildingLocationId] INT NOT NULL
		,[ClassTime] CHAR(5) NULL DEFAULT('9:15')
		,[LastName] VARCHAR(30) NOT NULL DEFAULT('Chen')
		,[FirstName] VARCHAR(30) NOT NULL DEFAULT('Lin')
		,[QmailEmailAdress] VARCHAR(50) NOT NULL DEFAULT('lin.chen22@qmail.cuny.edu')
		,[DateAdded] DATETIME2(7) NOT NULL DEFAULT sysdatetime()
		,[DateOfLastUpdate] DATETIME2(7) NOT NULL DEFAULT sysdatetime()
		,[AuthorizedUserId] INT NULL DEFAULT(22)
		,CONSTRAINT [FK_BuildingID] FOREIGN KEY ([BuildingLocationId]) REFERENCES [Project3].[BuildingLocation]([BuildingLocationId])
		);


--------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS [Project3].[ModeOfInstruction]

CREATE TABLE [Project3].[ModeOfInstruction]
([ModeId] INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
 [Mode] varchar(50) NOT NULL ,
 [ClassTime] char(5) Null Default ('9:15'),
 [LastName] varchar(30) NULL DEFAULT ('Brandwein'),
 [FirstName] varchar(30) NULL DEFAULT ('Jason'),
 [QmailEmailAddress] varchar(30) NULL DEFAULT ('jason.bradnwein11@qmail.cuny.edu'),
 [DateAdded] datetime2 default sysdatetime(),
 [DateOfLastUpdate] datetime2 default sysdatetime(),
 [AuthorizedUserId] int null default (11),
 );

DROP TABLE IF EXISTS [Project3].[CourseToMode]

CREATE TABLE [Project3].[CourseToMode]
([CourseToModeId] INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
 [ModeId] INT NOT NULL,
 [CourseId] INT NOT NULL,
 [ClassTime] char(5) Null Default ('9:15'),
 [LastName] varchar(30) NULL DEFAULT ('Ahmed'),
 [FirstName] varchar(30) NULL DEFAULT ('Nabila'),
 [QmailEmailAddress] varchar(30) NULL DEFAULT ('nabila.ahmed12@qmail.cuny.edu'),
 [DateAdded] datetime2 default sysdatetime(),
 [DateOfLastUpdate] datetime2 default sysdatetime(),
 [AuthorizedUserId] int null default (12),
 CONSTRAINT [FK_ModeId] FOREIGN KEY ([ModeId])  REFERENCES [Project3].[ModeOfInstruction]([ModeId]),
 CONSTRAINT [FK_CourseId] FOREIGN KEY ([CourseId])  REFERENCES [Project3].[Courses]([CourseId])
);
END



-- ============================================= 
-- Author:  Nabila Ahmed
-- Procedure:  AddForeignKeys	
-- Create date:  5/10/2020
-- Description: Adding ForeignKey
-- =============================================
DROP PROCEDURE IF EXISTS AddForeignKeys
GO
CREATE PROCEDURE AddForeignKeys
AS
DECLARE @Start AS DATETIME2 = SYSDATETIME();

ALTER TABLE [Project3].[ClassRoomLocation]
	WITH CHECK ADD CONSTRAINT [FK_BuildingID] FOREIGN KEY ([BuildingLocationId]) REFERENCES [Project3].[BuildingLocation]([BuildingLocationId])

ALTER TABLE [Project3].[Class]
	WITH CHECK ADD CONSTRAINT [FK_Class_ModeOfInstructor] FOREIGN KEY ([ModeID])  REFERENCES [Project3].[ModeOfInstruction]([ModeId])

ALTER TABLE [Project3].[Class]
	WITH CHECK ADD CONSTRAINT  [FK_Class_ClassRoomLocation] FOREIGN KEY ([ClassRoomLocationId])  REFERENCES [Project3].[ClassRoomLocation]([ClassRoomLocationId])

ALTER TABLE [Project3].[Class]
	WITH CHECK ADD CONSTRAINT [FK_Class_Instructor] FOREIGN KEY  ([InstructorId])  REFERENCES [Project3].[Instructor]([InstructorId])

ALTER TABLE [Project3].[Class]
	WITH CHECK ADD CONSTRAINT [FK_Class_Courses] FOREIGN KEY ([CourseId])  REFERENCES [Project3].[Courses]([CourseId])

ALTER TABLE [Project3].[InstructorsDepartment]
	WITH CHECK ADD CONSTRAINT [FK_InstructorId] FOREIGN KEY ([InstructorId]) REFERENCES [Project3].[Instructor]([InstructorId])


ALTER TABLE [Project3].[InstructorsDepartment]
	WITH CHECK ADD CONSTRAINT [FK_DepartmentId] FOREIGN KEY ([DepartmentId]) REFERENCES [Project3].[Department]([DepartmentId])

ALTER TABLE [Project3].[Courses]
	WITH CHECK ADD CONSTRAINT [FK_Courses_Department] FOREIGN KEY ([DepartmentId]) REFERENCES [Project3].[Department]([DepartmentId])

ALTER TABLE [Project3].[CourseToMode]
	WITH CHECK ADD CONSTRAINT [FK_CourseId] FOREIGN KEY ([CourseId])  REFERENCES [Project3].[Courses]([CourseId])

ALTER TABLE [Project3].[CourseToMode]
	WITH CHECK ADD CONSTRAINT [FK_ModeId] FOREIGN KEY ([ModeId])  REFERENCES [Project3].[ModeOfInstruction]([ModeId])
 EXEC [Project3].[usp_TrackWorkFlow]@WorkFlowStepKey = @Index,
								@QmailEmailAddress = 'Enter Email', 
                                @WorkFlowStepDescription = 'AddForeignKeys',
                                @StartingDateTime = @StartingDateTime;
GO


-- ============================================= 
-- Author:  Nabila Ahmed
-- Procedure:  Dropping all the constraints  
-- Create date:  5/10/2020
-- Description: Drop All the Foreign key in db
-- =============================================
DROP PROCEDURE IF EXISTS ConstraintDrop
GO
CREATE PROCEDURE ConstraintDrop
AS
DECLARE @Start AS DATETIME2 = SYSDATETIME();

ALTER TABLE [Project3].[ClassRoomLocation]
DROP CONSTRAINT FK_BuildingID

ALTER TABLE [Project3].[Courses]
DROP CONSTRAINT FK_Courses_Department

ALTER TABLE [Project3].[InstructorsDepartment]
DROP CONSTRAINT FK_InstructorId
	,FK_DepartmentId

ALTER TABLE [Project3].[CourseToMode]
DROP CONSTRAINT FK_CourseId
	,FK_ModeId

ALTER TABLE [Project3].[Class]
DROP CONSTRAINT FK_Class_ModeOfInstructor
	,FK_Class_ClassRoomLocation
	,FK_Class_Instructor
	,FK_Class_Courses
    
 EXEC [Project3].[usp_TrackWorkFlow]@WorkFlowStepKey = @Index,
								@QmailEmailAddress = 'Enter Email', 
                                @WorkFlowStepDescription = 'ConstraintDrop',
                                @StartingDateTime = @StartingDateTime;
GO


-- ============================================= 
-- Author:  Nabila Ahmed
-- Procedure:  TruncateTables 
-- Create date:  5/8/2020
-- Description: Truncate all the table in the database
-- =============================================
DROP PROCEDURE IF EXISTS TruncateTables
GO
CREATE PROCEDURE TruncateTables
AS
DECLARE @Start AS DATETIME2 = SYSDATETIME();

TRUNCATE TABLE [Project3].[Department]
TRUNCATE TABLE [Project3].[Instructor]
TRUNCATE TABLE [Project3].[InstructorsDepartment]
TRUNCATE TABLE [Project3].[BuildingLocation]
TRUNCATE TABLE [Project3].[ClassRoomLocation]
TRUNCATE TABLE [Project3].[Class]
TRUNCATE TABLE [Project3].[Courses]
TRUNCATE TABLE [Project3].[CourseToMode]
TRUNCATE TABLE [Project3].[ModeOfInstruction]

DECLARE @Index INT, @StartingDateTime DateTime2
        SET @Index = NEXT VALUE FOR [Project3].WorkFlowStepTableRowCount
        SET @StartingDateTime = Sysdatetime()
    EXEC [Project3].[usp_TrackWorkFlow] @WorkFlowStepKey = @Index, 
                                    @QmailEmailAddress = 'nabila.ahmed12@qmail.cuny.edu', 
                                    @WorkFlowStepDescription = 'Create InstructorDepartment procedure',
                                    @StartingDateTime = @StartingDateTime

SELECT *
FROM [Project3].[WorkFlowSteps]

EXEC TruncateTables;