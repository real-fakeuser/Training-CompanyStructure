CREATE PROCEDURE [dbo].[spCreateOrRemoveAddressEmployee]
	@EmployeeId int = null,
	@AddressId int = null
AS
BEGIN
	
	declare @DBId int
	Set @DBId = (	SELECT L.AddressId
					FROM Address2Employee L
					WHERE L.AddressId = @AddressId
							AND L.EmployeeId = @EmployeeId
					)

	if(@DBId is null)
		BEGIN			--No dataset found! inserting new dataset
			INSERT INTO [DBO].[Address2Employee]	(
										AddressId,
										EmployeeId
										)
			VALUES						(
										@AddressId,
										@EmployeeId
										)
			SET @DBId = @@IDENTITY
		END
	else
		BEGIN
			DELETE [dbo].[Address2Employee]
			WHERE AddressId = @AddressId
				AND EmployeeId = @EmployeeId
		END
	SELECT @DBId
	RETURN @DBId
END


