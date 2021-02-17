-- ============================================= 
-- Author:  Jason Brandwein 
-- Procedure:  [Project3].[loadbuildinglocation]
-- Create date:  5/08/2020
-- Description: storing building location and info
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   procedure [Project3].[LoadBuildingLocation]
as
begin
	set nocount on;
	declare @CurrentTime datetime2 = SYSDATETIME();

	INSERT INTO [Project3].[BuildingLocation]
	([BuildingName])
	SELECT distinct LEFT(orig.[location], charindex(' ', orig.[location])) as [Building Abbreviation]
	FROM [Uploadfile].[CoursesSpring2019] as orig

	exec Process.usp_TrackWorkFlow @StartTime = @CurrentTime, @WorkFlowDescription = 'Load Building Location Table', @WorkFlowStepTableRowCount = @@RowCount;
end;
GO