CREATE PROCEDURE [dbo].[spCreateOrUpdateAddress]
	@AddressId int = -1,
	@Street	nvarchar(256) = null,
	@City	nvarchar(256) = null,
	@ZipCode	int = -1,
	@CountryCode	nvarchar(5) = null
AS
BEGIN
	declare @DBCity int
	Set		@DBCity = (
					SELECT ZipCode
					FROM City
					WHERE	[City].[ZipCode] = @ZipCode
					)


	IF(@DBCity IS NULL)			--If null the city has to be created
	BEGIN
		INSERT INTO [dbo].[City]	(
									ZipCode,
									Name,
									CountryCode
									)
		VALUES						(
									@ZipCode,
									@City,
									@CountryCode
									)									
		Set	@DBCity = @ZipCode
	END
--Now we have the city's Id

	declare @DBId int
	Set @DBId = (	SELECT Id 
					FROM viAddress 
					WHERE Id = @AddressId)

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
			WHERE	Id = @AddressId
		END
	SELECT @DBId
	RETURN @DBId
END


