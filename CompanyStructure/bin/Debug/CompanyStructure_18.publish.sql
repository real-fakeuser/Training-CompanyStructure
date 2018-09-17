/*
Bereitstellungsskript für Training-TN-CompanyStructure

Dieser Code wurde von einem Tool generiert.
Änderungen an dieser Datei führen möglicherweise zu falschem Verhalten und gehen verloren, falls
der Code neu generiert wird.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Training-TN-CompanyStructure"
:setvar DefaultFilePrefix "Training-TN-CompanyStructure"
:setvar DefaultDataPath "D:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "D:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Überprüfen Sie den SQLCMD-Modus, und deaktivieren Sie die Skriptausführung, wenn der SQLCMD-Modus nicht unterstützt wird.
Um das Skript nach dem Aktivieren des SQLCMD-Modus erneut zu aktivieren, führen Sie folgenden Befehl aus:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Der SQLCMD-Modus muss aktiviert sein, damit dieses Skript erfolgreich ausgeführt werden kann.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'[dbo].[spCreateOrRemoveAddressCompany] wird erstellt....';


GO
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
GO
PRINT N'[dbo].[spCreateOrRemoveAddressEmployee] wird erstellt....';


GO
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
GO
PRINT N'Update abgeschlossen.';


GO
