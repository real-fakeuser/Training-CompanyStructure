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
PRINT N'[dbo].[Gender] wird erstellt....';


GO
CREATE TABLE [dbo].[Gender] (
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [Description] NVARCHAR (256) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'[dbo].[fnGenderLogic] wird erstellt....';


GO
CREATE FUNCTION [dbo].[fnGenderLogic]
(
	@EmployeeId int
)
RETURNS INT
AS
BEGIN
	DECLARE @DBId Int
	SET @DBId = (	SELECT E.Gender
					FROM Employee E
					WHERE E.Id = @EmployeeId)
	DECLARE @GenderId INT
	SET @GenderId =	(	SELECT G.[Description]
						FROM Gender G
						WHERE G.Id = @DBId)
	RETURN @GenderId
END
GO
PRINT N'[dbo].[viEmployee] wird erstellt....';


GO
CREATE VIEW [dbo].[viEmployee]
	AS	SELECT	E.Id,
				E.Name Employee, 
				dbo.fnGenderLogic (E.Id) AS Gender,
				D.Name Department, 
				C.Name Company
		FROM	[Employee] E 
				LEFT JOIN [Department] D	ON E.DepartmentId = D.Id
				LEFT JOIN [Company] C ON D.CompanyId = C.Id
		WHERE	E.DeletedTime IS NULL
				AND		D.DeletedTime IS NULL
				AND		C.DeletedTime IS NULL
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
PRINT N'[dbo].[spCreateOrUpdateAddress] wird erstellt....';


GO
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
GO
PRINT N'[dbo].[spCreateOrUpdateCompany] wird erstellt....';


GO
CREATE PROCEDURE [dbo].[spCreateOrUpdateCompany]
	@Id		int = -1,
	@Name nvarchar(256) = null
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
			UPDATE [dbo].[Company]
			SET		[Name]	=	CASE WHEN @Name IS NULL		THEN [Name]		ELSE @Name	END
			WHERE	Id = @Id
		END
	SELECT @DBId
	RETURN @DBId
END
GO
PRINT N'[dbo].[spCreateOrUpdateDepartment] wird erstellt....';


GO
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
GO
PRINT N'[dbo].[spCreateOrUpdateEmployee] wird erstellt....';


GO
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
GO
PRINT N'Update abgeschlossen.';


GO
