-- ============================================= 
-- Author:  Jason Brandwein 
-- Procedure:  [Project3].[loadmodeofinstruction]
-- Create date:  5/08/2020
-- Description: storing mode
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   procedure [Project3].[LoadModeOfInstruction]
as
begin
	set nocount on;
	declare @CurrentTime datetime2 = SYSDATETIME();

	INSERT INTO [Project3].[ModeOfInstruction]
	([Mode])
	SELECT distinct

	[Mode of Instruction]

		FROM [QueensCollegeSchedulSpring2019].[Uploadfile].[CoursesSpring2019]

	exec Process.usp_TrackWorkFlow @StartTime = @CurrentTime, @WorkFlowDescription = 'Load Mode of Instruction Table', @WorkFlowStepTableRowCount = @@RowCount;
end;
GO