CREATE PROCEDURE [dbo].[spCreateOrRemoveAddressCompany]
	@CompanyId int = null,
	@AddressId int = null
AS
BEGIN
	
	declare @DBId int
	Set @DBId = (	SELECT L.AddressId
					FROM Address2Company L
					WHERE L.AddressId = @AddressId
							AND L.CompanyId = @CompanyId
					)

	if(@DBId is null)
		BEGIN			--No dataset found! inserting new dataset
			INSERT INTO [DBO].[Address2Company]	(
										AddressId,
										CompanyId
										)
			VALUES						(
										@AddressId,
										@CompanyId
										)
			SET @DBId = @@IDENTITY
		END
	else
		BEGIN
			DELETE [dbo].[Address2Company]
			WHERE AddressId = @AddressId
				AND CompanyId = @CompanyId
		END
	SELECT @DBId
	RETURN @DBId
END


