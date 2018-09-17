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
PRINT N'[dbo].[Address] wird erstellt....';


GO
CREATE TABLE [dbo].[Address] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [Street]       NVARCHAR (256) NOT NULL,
    [CityId]       NVARCHAR (128) NOT NULL,
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
    [ZipCode]      NVARCHAR (128) NOT NULL,
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
ALTER TABLE [dbo].[Address] WITH NOCHECK
    ADD FOREIGN KEY ([CityId]) REFERENCES [dbo].[City] ([ZipCode]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Company] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Company] WITH NOCHECK
    ADD FOREIGN KEY ([AddressId]) REFERENCES [dbo].[Address] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Company] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Company] WITH NOCHECK
    ADD FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Company] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Employee] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Employee] WITH NOCHECK
    ADD FOREIGN KEY ([AddressId]) REFERENCES [dbo].[Address] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Employee] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Employee] WITH NOCHECK
    ADD FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Department] wird erstellt....';


GO
ALTER TABLE [dbo].[Department] WITH NOCHECK
    ADD FOREIGN KEY ([ManagerId]) REFERENCES [dbo].[Employee] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Department] wird erstellt....';


GO
ALTER TABLE [dbo].[Department] WITH NOCHECK
    ADD FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Company] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Employee] wird erstellt....';


GO
ALTER TABLE [dbo].[Employee] WITH NOCHECK
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
				LEFT JOIN City C ON A.CityId LIKE C.ZipCode
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
	@GenderId int
)
RETURNS NVARCHAR(256)
AS
BEGIN
/*	DECLARE @DBId Int
	SET @DBId = (	SELECT E.Gender
					FROM Employee E
					WHERE E.Id = @EmployeeId)
	DECLARE @GenderName NVARCHAR(256) = null
	SET @GenderName =	(	SELECT G.[Description]
							FROM Gender G
							WHERE G.Id = @DBId)
	RETURN @GenderName
	*/
	return case @GenderId 
		when 1 then 'Male'
		end

	if	(@GenderId = 0)		RETURN	'Männlich'
	if	(@GenderId = 1)		RETURN	'Weiblich'
	if	(@GenderId > 1)		RETURN	'Sonstige'
	RETURN 'Internal Server Error'
END
GO
PRINT N'[dbo].[viEmployee] wird erstellt....';


GO
CREATE VIEW [dbo].[viEmployee]
	AS	SELECT	E.Id,
				E.Name Employee, 
				dbo.fnGenderLogic (E.Gender) AS Gender,
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
	@ZipCode	nvarchar(128) = null,
	@CountryCode	nvarchar(5) = null
AS
BEGIN
	declare @DBCity nvarchar(128)
	Set		@DBCity = (
					SELECT ZipCode
					FROM City
					WHERE	[City].[ZipCode] LIKE @ZipCode
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
PRINT N'Vorhandene Daten werden auf neu erstellte Einschränkungen hin überprüft.';


GO
USE [$(DatabaseName)];


GO
CREATE TABLE [#__checkStatus] (
    id           INT            IDENTITY (1, 1) PRIMARY KEY CLUSTERED,
    [Schema]     NVARCHAR (256),
    [Table]      NVARCHAR (256),
    [Constraint] NVARCHAR (256)
);

SET NOCOUNT ON;

DECLARE tableconstraintnames CURSOR LOCAL FORWARD_ONLY
    FOR SELECT SCHEMA_NAME([schema_id]),
               OBJECT_NAME([parent_object_id]),
               [name],
               0
        FROM   [sys].[objects]
        WHERE  [parent_object_id] IN (OBJECT_ID(N'dbo.Address'), OBJECT_ID(N'dbo.Address2Company'), OBJECT_ID(N'dbo.Address2Employee'), OBJECT_ID(N'dbo.Department'), OBJECT_ID(N'dbo.Employee'))
               AND [type] IN (N'F', N'C')
                   AND [object_id] IN (SELECT [object_id]
                                       FROM   [sys].[check_constraints]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0
                                       UNION
                                       SELECT [object_id]
                                       FROM   [sys].[foreign_keys]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0);

DECLARE @schemaname AS NVARCHAR (256);

DECLARE @tablename AS NVARCHAR (256);

DECLARE @checkname AS NVARCHAR (256);

DECLARE @is_not_trusted AS INT;

DECLARE @statement AS NVARCHAR (1024);

BEGIN TRY
    OPEN tableconstraintnames;
    FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
    WHILE @@fetch_status = 0
        BEGIN
            PRINT N'Einschränkung wird überprüft: ' + @checkname + N' [' + @schemaname + N'].[' + @tablename + N']';
            SET @statement = N'ALTER TABLE [' + @schemaname + N'].[' + @tablename + N'] WITH ' + CASE @is_not_trusted WHEN 0 THEN N'CHECK' ELSE N'NOCHECK' END + N' CHECK CONSTRAINT [' + @checkname + N']';
            BEGIN TRY
                EXECUTE [sp_executesql] @statement;
            END TRY
            BEGIN CATCH
                INSERT  [#__checkStatus] ([Schema], [Table], [Constraint])
                VALUES                  (@schemaname, @tablename, @checkname);
            END CATCH
            FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
        END
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') >= 0
    CLOSE tableconstraintnames;

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') = -1
    DEALLOCATE tableconstraintnames;

SELECT N'Fehler beim Überprüfen der Einschränkung:' + [Schema] + N'.' + [Table] + N',' + [Constraint]
FROM   [#__checkStatus];

IF @@ROWCOUNT > 0
    BEGIN
        DROP TABLE [#__checkStatus];
        RAISERROR (N'Fehler beim Überprüfen von Einschränkungen', 16, 127);
    END

SET NOCOUNT OFF;

DROP TABLE [#__checkStatus];


GO
PRINT N'Update abgeschlossen.';


GO
