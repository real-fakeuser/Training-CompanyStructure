CREATE PROCEDURE [dbo].[spCreateOrUpdateAddress]
	@Id		int = -1,
	@Street	nvarchar(256) = null,
	@CityId	int = -1,
	@City	nvarchar(256) = null,
	@ZipCode	int = -1,
	@CountryCode	nvarchar(5) = null
AS
BEGIN
	declare @DBCity int
	Set		@DBCity = (
					SELECT Id
					FROM City
					WHERE	[City].[Id] = @CityId
					)


	IF(@DBCity IS NULL)			--If null the city has to be created
	BEGIN
		INSERT INTO [dbo].[City]	(
									Name,
									ZipCode,
									CountryCode
									)
		VALUES						(
									@City,
									@ZipCode,
									@CountryCode
									)									
		Set	@DBCity = @@IDENTITY
	END
--Now we have the city's Id

	declare @DBId int
	Set @DBId = (	SELECT Id 
					FROM viAddress 
					WHERE Id = @Id)

	if(@DBId is null)
		BEGIN			--No dataset found! inserting new dataset
			INSERT INTO [DBO].[Address]	(
										Street,
										CityId
										)
			VALUES						(
										@Street,
										@DBCity
										)
			SET @DBId = @@IDENTITY
		END
	else
		BEGIN
			UPDATE [dbo].[Address]
			SET		[Street]	=	CASE WHEN @Street IS NULL		THEN [Street]		ELSE @Street	END,
					[CityId]	=	CASE WHEN @DBCity IS NULL		THEN [CityId]		ELSE @DBCity	END
			WHERE	Id = @Id
		END
	SELECT @DBId
	RETURN @DBId
END


