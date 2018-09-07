CREATE PROCEDURE [dbo].[spCreateOrUpdateEmployee]
	@Id		int = -1,
	@Name	nvarchar(256) = null,
	@Department int = -1,
	@Gender	int = -1,
	@DateOfBirth Datetime2(7) = null
AS
BEGIN
	
	declare @DBId int
	Set @DBId = (	SELECT Id 
					FROM Employee
					WHERE Id = @Id)

	if(@DBId is null)
		BEGIN			--No dataset found! inserting new dataset
			INSERT INTO [DBO].[Employee]	(
										DepartmentId,
										Name,
										Gender,
										DateOfBirth
										)
			VALUES						(
										@Department,
										@Name,
										@Gender,
										@DateOfBirth
										)
			SET @DBId = @@IDENTITY
		END
	else
		BEGIN
			UPDATE [dbo].[Employee]
			SET		[DepartmentId]	=	CASE WHEN @Department IS NULL		THEN [DepartmentId]		ELSE @Department	END,
					[Gender]	=	CASE WHEN @Gender IS NULL		THEN [Gender]		ELSE @Gender	END,
					[DateOfBirth]	=	CASE WHEN @DateOfBirth IS NULL		THEN [DateOfBirth]		ELSE @DateOfBirth	END
			WHERE	Id = @Id
		END
	SELECT @DBId
	RETURN @DBId
END


