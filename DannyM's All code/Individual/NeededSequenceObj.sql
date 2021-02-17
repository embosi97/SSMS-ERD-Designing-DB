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

