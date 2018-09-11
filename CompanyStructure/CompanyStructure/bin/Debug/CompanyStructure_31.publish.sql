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
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'$(DatabaseName) wird erstellt....'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Die Datenbankeinstellungen können nicht geändert werden. Diese Einstellungen können nur von Systemadministratoren übernommen werden.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Die Datenbankeinstellungen können nicht geändert werden. Diese Einstellungen können nur von Systemadministratoren übernommen werden.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'[dbo].[Address] wird erstellt....';


GO
CREATE TABLE [dbo].[Address] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [Street]       NVARCHAR (256) NOT NULL,
    [CityId]       INT            NOT NULL,
    [CreationTime] DATETIME2 (7)  NOT NULL,
    [DeletedTime]  DATETIME2 (7)  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'[dbo].[Address2Company] wird erstellt....';


GO
CREATE TABLE [dbo].[Address2Company] (
    [AddressId]    INT           NOT NULL,
    [CompanyId]    INT           NOT NULL,
    [CreationTime] DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([AddressId] ASC, [CompanyId] ASC)
);


GO
PRINT N'[dbo].[Address2Employee] wird erstellt....';


GO
CREATE TABLE [dbo].[Address2Employee] (
    [AddressId]    INT           NOT NULL,
    [EmployeeId]   INT           NOT NULL,
    [CreationTime] DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([AddressId] ASC, [EmployeeId] ASC)
);


GO
PRINT N'[dbo].[City] wird erstellt....';


GO
CREATE TABLE [dbo].[City] (
    [ZipCode]      INT            NOT NULL,
    [Name]         NVARCHAR (128) NOT NULL,
    [CountryCode]  NVARCHAR (8)   NOT NULL,
    [CreationTime] DATETIME2 (7)  NOT NULL,
    [DeletedTime]  DATETIME2 (7)  NULL,
    PRIMARY KEY CLUSTERED ([ZipCode] ASC)
);


GO
PRINT N'[dbo].[Company] wird erstellt....';


GO
CREATE TABLE [dbo].[Company] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [Name]         NVARCHAR (256) NOT NULL,
    [CreationTime] DATETIME2 (7)  NOT NULL,
    [DeletedTime]  DATETIME2 (7)  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'[dbo].[Department] wird erstellt....';


GO
CREATE TABLE [dbo].[Department] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [ManagerId]    INT            NULL,
    [CompanyId]    INT            NULL,
    [Name]         NVARCHAR (256) NOT NULL,
    [CreationTime] DATETIME2 (7)  NULL,
    [DeletedTime]  DATETIME2 (7)  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'[dbo].[Employee] wird erstellt....';


GO
CREATE TABLE [dbo].[Employee] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [DepartmentId] INT            NULL,
    [Name]         NVARCHAR (256) NOT NULL,
    [Gender]       INT            NULL,
    [DateOfBirth]  DATETIME2 (7)  NULL,
    [CreationTime] DATETIME2 (7)  NOT NULL,
    [DeletedTime]  DATETIME2 (7)  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address] wird erstellt....';


GO
ALTER TABLE [dbo].[Address]
    ADD DEFAULT GetDate() FOR [CreationTime];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Company] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Company]
    ADD DEFAULT GetDate() FOR [CreationTime];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Employee] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Employee]
    ADD DEFAULT GetDate() FOR [CreationTime];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[City] wird erstellt....';


GO
ALTER TABLE [dbo].[City]
    ADD DEFAULT GetDate() FOR [CreationTime];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Company] wird erstellt....';


GO
ALTER TABLE [dbo].[Company]
    ADD DEFAULT GetDate() FOR [CreationTime];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Department] wird erstellt....';


GO
ALTER TABLE [dbo].[Department]
    ADD DEFAULT GetDate() FOR [CreationTime];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Employee] wird erstellt....';


GO
ALTER TABLE [dbo].[Employee]
    ADD DEFAULT GetDate() FOR [CreationTime];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address] wird erstellt....';


GO
ALTER TABLE [dbo].[Address]
    ADD FOREIGN KEY ([CityId]) REFERENCES [dbo].[City] ([ZipCode]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Company] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Company]
    ADD FOREIGN KEY ([AddressId]) REFERENCES [dbo].[Address] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Company] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Company]
    ADD FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Company] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Employee] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Employee]
    ADD FOREIGN KEY ([AddressId]) REFERENCES [dbo].[Address] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Employee] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Employee]
    ADD FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Department] wird erstellt....';


GO
ALTER TABLE [dbo].[Department]
    ADD FOREIGN KEY ([ManagerId]) REFERENCES [dbo].[Employee] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Department] wird erstellt....';


GO
ALTER TABLE [dbo].[Department]
    ADD FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Company] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Employee] wird erstellt....';


GO
ALTER TABLE [dbo].[Employee]
    ADD FOREIGN KEY ([DepartmentId]) REFERENCES [dbo].[Department] ([Id]);


GO
PRINT N'[dbo].[viAddress] wird erstellt....';


GO
CREATE VIEW [dbo].[viAddress]
	AS	SELECT	A.Id, 
				A.Street, 
				C.ZipCode,
				C.Name AS City, 
				C.CountryCode
		FROM	[Address] A
				LEFT JOIN City C ON A.CityId = C.ZipCode
		WHERE	A.DeletedTime IS NULL
				AND	C.DeletedTime IS NULL
GO
PRINT N'[dbo].[viCompany] wird erstellt....';


GO
CREATE VIEW [dbo].[viCompany]
	AS	SELECT	C.[Id],
				C.[Name] Company, 
				A.Street, 
				A.ZipCode, 
				A.City, 
				A.CountryCode
		FROM	[Company] C 
				LEFT JOIN [Address2Company] L ON C.Id = L.CompanyId
				LEFT JOIN [viAddress] A ON L.AddressId = A.Id
		WHERE	C.DeletedTime IS NULL
GO
PRINT N'[dbo].[viDepartment] wird erstellt....';


GO
CREATE VIEW [dbo].[viDepartment]
	AS	SELECT	C.Id,
				C.Name Company, 
				D.Name Department, 
				E.Name Manager
		FROM	[Department] D
				LEFT JOIN [Company] C ON D.CompanyId = C.Id
				LEFT JOIN [Employee] E ON D.ManagerId = E.Id
		WHERE	D.DeletedTime IS NULL
				AND		E.DeletedTime IS NULL
				AND		C.DeletedTime IS NULL
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
	if (@DBId = 0)
		BEGIN
		RETURN ("Männlich")
		END
	ELSE IF (@DBId = 1)
		BEGIN
		RETURN("Weiblich")
		END
	ELSE IF (@DBId >1)
		Begin
		RETURN ("Sonstiges")
		END
	ELSE
		Begin
		RETURN ("Fehler")
		END
	RETURN ("Fehler")
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
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update abgeschlossen.';


GO
