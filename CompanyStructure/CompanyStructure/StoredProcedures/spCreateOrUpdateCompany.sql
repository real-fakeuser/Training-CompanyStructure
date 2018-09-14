CREATE PROCEDURE [dbo].[spCreateOrUpdateCompany]
	@Id		int = -1,
	@Name nvarchar(256) = null,
	@Delete Bit = 0
AS
BEGIN
	declare @DBId int
	Set @DBId = (	SELECT Id 
					FROM Company 
					WHERE Id = @Id)

	if(@DBId is null)
		BEGIN			--No dataset found! inserting new dataset
			INSERT INTO [DBO].[Company]	(
										Name
										)
			VALUES						(
										@Name
										)
			SET @DBId = @@IDENTITY
		END
	else
		BEGIN
			if (@Delete != 1)
			BEGIN
				UPDATE [dbo].[Company]
				SET		[Name]	=	CASE WHEN @Name IS NULL		THEN [Name]		ELSE @Name	END
				WHERE	Id = @Id
			END
			else
			BEGIN
				UPDATE [dbo].[Company]
				SET		[DeletedTime]	=	CURRENT_TIMESTAMP
				WHERE	Id = @Id
			END
		END
	SELECT @DBId
	RETURN @DBId
END

