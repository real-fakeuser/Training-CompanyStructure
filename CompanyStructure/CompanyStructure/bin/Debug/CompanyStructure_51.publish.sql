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
PRINT N'unbenannte Einschränkungen auf [dbo].[Address] wird gelöscht....';


GO
ALTER TABLE [dbo].[Address] DROP CONSTRAINT [DF__Address__Creatio__47DBAE45];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Company] wird gelöscht....';


GO
ALTER TABLE [dbo].[Company] DROP CONSTRAINT [DF__Company__Creatio__4BAC3F29];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Department] wird gelöscht....';


GO
ALTER TABLE [dbo].[Department] DROP CONSTRAINT [DF__Departmen__Creat__4CA06362];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Employee] wird gelöscht....';


GO
ALTER TABLE [dbo].[Employee] DROP CONSTRAINT [DF__Employee__Creati__4D94879B];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address] wird gelöscht....';


GO
ALTER TABLE [dbo].[Address] DROP CONSTRAINT [FK__Address__CityId__4E88ABD4];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Company] wird gelöscht....';


GO
ALTER TABLE [dbo].[Address2Company] DROP CONSTRAINT [FK__Address2C__Addre__4F7CD00D];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Employee] wird gelöscht....';


GO
ALTER TABLE [dbo].[Address2Employee] DROP CONSTRAINT [FK__Address2E__Addre__5165187F];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Company] wird gelöscht....';


GO
ALTER TABLE [dbo].[Address2Company] DROP CONSTRAINT [FK__Address2C__Compa__5070F446];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Department] wird gelöscht....';


GO
ALTER TABLE [dbo].[Department] DROP CONSTRAINT [FK__Departmen__Compa__5441852A];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Department] wird gelöscht....';


GO
ALTER TABLE [dbo].[Department] DROP CONSTRAINT [FK__Departmen__Manag__534D60F1];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Employee] wird gelöscht....';


GO
ALTER TABLE [dbo].[Employee] DROP CONSTRAINT [FK__Employee__Depart__5535A963];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Employee] wird gelöscht....';


GO
ALTER TABLE [dbo].[Address2Employee] DROP CONSTRAINT [FK__Address2E__Emplo__52593CB8];


GO
PRINT N'Das erneute Erstellen der Tabelle "[dbo].[Address]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Address] (
    [Id]           INT            IDENTITY (0, 1) NOT NULL,
    [Street]       NVARCHAR (256) NOT NULL,
    [CityId]       NVARCHAR (128) NOT NULL,
    [CreationTime] DATETIME2 (7)  DEFAULT GetDate() NOT NULL,
    [DeletedTime]  DATETIME2 (7)  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Address])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Address] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Address] ([Id], [Street], [CityId], [CreationTime], [DeletedTime])
        SELECT   [Id],
                 [Street],
                 [CityId],
                 [CreationTime],
                 [DeletedTime]
        FROM     [dbo].[Address]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Address] OFF;
    END

DROP TABLE [dbo].[Address];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Address]', N'Address';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Das erneute Erstellen der Tabelle "[dbo].[Company]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Company] (
    [Id]           INT            IDENTITY (0, 1) NOT NULL,
    [Name]         NVARCHAR (256) NOT NULL,
    [CreationTime] DATETIME2 (7)  DEFAULT GetDate() NOT NULL,
    [DeletedTime]  DATETIME2 (7)  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Company])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Company] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Company] ([Id], [Name], [CreationTime], [DeletedTime])
        SELECT   [Id],
                 [Name],
                 [CreationTime],
                 [DeletedTime]
        FROM     [dbo].[Company]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Company] OFF;
    END

DROP TABLE [dbo].[Company];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Company]', N'Company';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Das erneute Erstellen der Tabelle "[dbo].[Department]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Department] (
    [Id]           INT            IDENTITY (0, 1) NOT NULL,
    [ManagerId]    INT            NULL,
    [CompanyId]    INT            NULL,
    [Name]         NVARCHAR (256) NOT NULL,
    [CreationTime] DATETIME2 (7)  DEFAULT GetDate() NULL,
    [DeletedTime]  DATETIME2 (7)  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Department])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Department] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Department] ([Id], [ManagerId], [CompanyId], [Name], [CreationTime], [DeletedTime])
        SELECT   [Id],
                 [ManagerId],
                 [CompanyId],
                 [Name],
                 [CreationTime],
                 [DeletedTime]
        FROM     [dbo].[Department]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Department] OFF;
    END

DROP TABLE [dbo].[Department];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Department]', N'Department';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Das erneute Erstellen der Tabelle "[dbo].[Employee]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Employee] (
    [Id]           INT            IDENTITY (0, 1) NOT NULL,
    [DepartmentId] INT            NULL,
    [Name]         NVARCHAR (256) NOT NULL,
    [Gender]       INT            NULL,
    [DateOfBirth]  DATETIME2 (7)  NULL,
    [CreationTime] DATETIME2 (7)  DEFAULT GetDate() NOT NULL,
    [DeletedTime]  DATETIME2 (7)  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Employee])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Employee] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Employee] ([Id], [DepartmentId], [Name], [Gender], [DateOfBirth], [CreationTime], [DeletedTime])
        SELECT   [Id],
                 [DepartmentId],
                 [Name],
                 [Gender],
                 [DateOfBirth],
                 [CreationTime],
                 [DeletedTime]
        FROM     [dbo].[Employee]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Employee] OFF;
    END

DROP TABLE [dbo].[Employee];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Employee]', N'Employee';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


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
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Employee] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Employee] WITH NOCHECK
    ADD FOREIGN KEY ([AddressId]) REFERENCES [dbo].[Address] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Company] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Company] WITH NOCHECK
    ADD FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Company] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Department] wird erstellt....';


GO
ALTER TABLE [dbo].[Department] WITH NOCHECK
    ADD FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Company] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Department] wird erstellt....';


GO
ALTER TABLE [dbo].[Department] WITH NOCHECK
    ADD FOREIGN KEY ([ManagerId]) REFERENCES [dbo].[Employee] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Employee] wird erstellt....';


GO
ALTER TABLE [dbo].[Employee] WITH NOCHECK
    ADD FOREIGN KEY ([DepartmentId]) REFERENCES [dbo].[Department] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Employee] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Employee] WITH NOCHECK
    ADD FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([Id]);


GO
PRINT N'[dbo].[viAddress] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[viAddress]';


GO
PRINT N'[dbo].[viCompany] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[viCompany]';


GO
PRINT N'[dbo].[viDepartment] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[viDepartment]';


GO
PRINT N'[dbo].[viEmployee] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[viEmployee]';


GO
PRINT N'[dbo].[spCreateOrUpdateAddress] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spCreateOrUpdateAddress]';


GO
PRINT N'[dbo].[spCreateOrUpdateCompany] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spCreateOrUpdateCompany]';


GO
PRINT N'[dbo].[spCreateOrUpdateDepartment] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spCreateOrUpdateDepartment]';


GO
PRINT N'[dbo].[spCreateOrUpdateEmployee] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spCreateOrUpdateEmployee]';


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
