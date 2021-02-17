GO

DROP SEQUENCE IF EXISTS Project3.WorkFlowStepTableRowCount;         -- WorkFlowStepTableRowCount
CREATE SEQUENCE Project3.WorkFlowStepTableRowCount
START WITH 1
INCREMENT BY 1

GO
DROP PROC IF EXISTS Project3.WorkFlowStepsTracker
GO
CREATE PROC Project3.WorkFlowStepsTracker 
        @GroupMemberEmail varchar(70)
AS
BEGIN
    DROP TABLE IF EXISTS Project3.WorkFlowSteps;

    DECLARE @Index INT
    SET @Index = NEXT VALUE FOR [Project3].WorkFlowStepTableRowCount

CREATE TABLE Project3.WorkFlowSteps
(
    WorkFlowStepKey              INT NOT NULL,
    WorkFlowStepDescription      NVARCHAR(100)       NOT NULL,
    WorkFlowStepTableRowCount    INT                 NULL DEFAULT (0),
    StartingDateTime             DATETIME2(7)        NULL DEFAULT (SYSDATETIME()) ,
    EndingDateTime               DATETIME2(7)        NULL DEFAULT (SYSDATETIME()) ,
    ClassTime                    CHAR(5)             NULL DEFAULT ('09:15'),
    QmailEmailAddress varchar(30) NULL DEFAULT ('Your Qmail Email
   Address')
)

INSERT INTO Project3.WorkFlowSteps 
        (WorkFlowStepKey, WorkFlowStepTableRowCount, WorkFlowStepDescription, QmailEmailAddress)
VALUES
        (@Index, @Index, 'WorkFlowSteps table created', @GroupMemberEmail) 
END
GO

-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

DROP PROC IF EXISTS Project3.usp_TrackWorkFlow;             
 
GO
CREATE PROC Project3.usp_TrackWorkFlow    ----------- USP_TRACKWORKFLOW
   @WorkFlowStepKey                        INT,
   @QmailEmailAddress                      NVARCHAR(70),
   @WorkFlowStepDescription                NVARCHAR(100),
   @StartingDateTime                       DATETIME2   
AS
BEGIN
 
   SET NOCOUNT ON;

   SET @StartingDateTime = SYSDATETIME();
  
   INSERT INTO Project3.WorkFlowSteps (WorkFlowStepKey, QmailEmailAddress, WorkFlowStepDescription, StartingDateTime)
   VALUES(@WorkFlowStepKey, @QmailEmailAddress, @WorkFlowStepDescription, @StartingDateTime)

END

---- PUT THIS AT THE END OF YOUR PROCEDURES 

   --DECLARE @Index INT, @StartingDateTime DateTime2
   --     SET @Index = NEXT VALUE FOR [Project3].WorkFlowStepTableRowCount
   --     SET @StartingDateTime = Sysdatetime()
   -- EXEC [Project3].[usp_TrackWorkFlow]@WorkFlowStepKey = @Index,
			--						@QmailEmailAddress = 'Enter Email', 
   --                                 @WorkFlowStepDescription = 'Enter Action',
   --                                 @StartingDateTime = @StartingDateTime