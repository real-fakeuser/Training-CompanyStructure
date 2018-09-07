CREATE PROCEDURE [dbo].[spCreateOrUpdateDepartment]
	@Id		int = -1,
	@ManagerId	int = null,
	@CompanyId	int = null,
	@Name	nvarchar(256) = null
AS
BEGIN
	declare @DBId int
	Set @DBId = (	SELECT Id 
					FROM Department 
					WHERE Id = @Id)

	if(@DBId is null)
		BEGIN			--No dataset found! inserting new dataset
			INSERT INTO [DBO].[Department]	(
										ManagerId,
										CompanyId,
										Name
										)
			VALUES						(
										@ManagerId,
										@CompanyId,
										@Name
										)
			SET @DBId = @@IDENTITY
		END
	else
		BEGIN
			UPDATE [dbo].[Department]
			SET		[ManagerId]	=	CASE WHEN @ManagerId IS NULL		THEN [ManagerId]		ELSE @ManagerId	END,
					[CompanyId]	=	CASE WHEN @CompanyId IS NULL		THEN [CompanyId]		ELSE @CompanyId	END,
					[Name]		=	CASE WHEN @Name IS NULL				THEN [Name]				ELSE @Name	END
			WHERE	Id = @Id
		END
	SELECT @DBId
	RETURN @DBId
END


