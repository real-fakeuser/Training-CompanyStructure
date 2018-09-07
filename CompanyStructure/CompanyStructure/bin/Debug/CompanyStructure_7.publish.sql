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
PRINT N'[dbo].[spCreateOrUpdateAddress] wird erstellt....';


GO
CREATE PROCEDURE [dbo].[spCreateOrUpdateAddress]
	@Id		int,
	@Street	nvarchar(256),
	@City	nvarchar(256),
	@ZipCode	int,
	@CountryCode	nvarchar(5)
AS
BEGIN
	declare @DBCity int

		if(@City IS NULL or @ZipCode IS NULL)
		BEGIN
			Set		@DBCity = (
								SELECT Id
								FROM City
								WHERE	[City].[Name] LIKE @City
										AND	[City].[CountryCode] = @CountryCode
										AND [City].[ZipCode] = @ZipCode
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
					Set	@DBCity = (
								SELECT Id
								FROM City
								WHERE	[City].[Name] LIKE @City
										AND	[City].[CountryCode] = @CountryCode
										AND [City].[ZipCode] = @ZipCode
								)
				END
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
GO
PRINT N'Update abgeschlossen.';


GO
