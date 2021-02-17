
---- ============================================= 
-- Author:  Danny Mancheno
-- Procedure: Create functions
-- Create date:  5/10/2020
-- Description: Area below creates functions used to fill cols.
-- =============================================
-- Note * Could not figure how to store functions within a procedure.
	-- GET HOUR NUMBER

	GO
	CREATE OR ALTER FUNCTION func.GetHour (@param VARCHAR(MAX))
	RETURNS VARCHAR(MAX)
	AS
	BEGIN
		DECLARE @GetHourIndex AS INT;
		SET @GetHourIndex = CHARINDEX('(',@param)+1
		
		DECLARE @Ans AS VARCHAR(MAX);
		SET @Ans = SUBSTRING(@param, @GetHourIndex, 1) ;
		RETURN @Ans;
	END;
	GO
	-- GET CREDIT NUMBER
	GO
	CREATE OR ALTER FUNCTION func.GetCred (@param VARCHAR(MAX))
	RETURNS VARCHAR(MAX)
	AS
	BEGIN
	DECLARE @GetCredIndex AS INT;
	SET @GetCredIndex = CHARINDEX(')',@param)-1
		
	DECLARE @Ans AS VARCHAR(MAX);
	SET @Ans = SUBSTRING(@param, @GetCredIndex, 1);
	RETURN @Ans;
	END
	GO
	 -- GET COURSE NAME
	GO
	CREATE OR ALTER FUNCTION func.GetName (@param VARCHAR(MAX))
	RETURNS VARCHAR(MAX)
	AS
	BEGIN
	
		DECLARE @answer AS VARCHAR(max) = TRIM('(' FROM SUBSTRING( @param, 1, CHARINDEX('(',@param)))
		return @answer;
	END
	GO
	-- GET DEP NAME FOR DEP referencing
	GO
	CREATE OR ALTER FUNCTION func.GetDepName (@param VARCHAR(MAX))
	RETURNS VARCHAR(MAX)
	AS
	BEGIN
	
		DECLARE @answer AS VARCHAR(max) = SUBSTRING( @param, 1, CHARINDEX(' ',@param));
		return @answer;
	END
	GO
