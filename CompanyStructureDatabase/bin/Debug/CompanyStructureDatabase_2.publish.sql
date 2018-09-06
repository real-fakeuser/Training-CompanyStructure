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
    [Id]            INT            IDENTITY (1, 1) NOT NULL,
    [Streed]        NVARCHAR (256) NOT NULL,
    [HouseNumber]   INT            NOT NULL,
    [ExtraAddrInfo] NVARCHAR (256) NULL,
    [City_Id]       INT            NOT NULL,
    [CountryCode]   NVARCHAR (4)   NULL,
    [CreationTime]  DATETIME2 (7)  NOT NULL,
    [DeletedTime]   DATETIME2 (7)  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'[dbo].[Address2Company] wird erstellt....';


GO
CREATE TABLE [dbo].[Address2Company] (
    [Address_Id]   INT           NOT NULL,
    [Employee_Id]  INT           NOT NULL,
    [CreationTime] DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([Address_Id] ASC, [Employee_Id] ASC)
);


GO
PRINT N'[dbo].[Address2Employee] wird erstellt....';


GO
CREATE TABLE [dbo].[Address2Employee] (
    [Address_Id]   INT           NOT NULL,
    [Company_Id]   INT           NOT NULL,
    [CreationTime] DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([Address_Id] ASC, [Company_Id] ASC)
);


GO
PRINT N'[dbo].[Branch] wird erstellt....';


GO
CREATE TABLE [dbo].[Branch] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [Manager_Id]   INT            NULL,
    [Company_Id]   INT            NOT NULL,
    [Branch_Name]  NVARCHAR (256) NOT NULL,
    [CreationTime] DATETIME2 (7)  NULL,
    [DeletedTime]  DATETIME2 (7)  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'[dbo].[Company] wird erstellt....';


GO
CREATE TABLE [dbo].[Company] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [Company_Name] NVARCHAR (256) NOT NULL,
    [CreationTime] DATETIME2 (7)  NOT NULL,
    [DeletedTime]  DATETIME2 (7)  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'[dbo].[Employee] wird erstellt....';


GO
CREATE TABLE [dbo].[Employee] (
    [Id]                   INT            IDENTITY (1, 1) NOT NULL,
    [Branch_Id]            INT            NOT NULL,
    [Employee_Name]        NVARCHAR (256) NOT NULL,
    [Employee_DateOfBirth] DATETIME2 (7)  NOT NULL,
    [CreationTime]         DATETIME2 (7)  NOT NULL,
    [DeletedTime]          DATETIME2 (7)  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'[dbo].[ZipAndCity] wird erstellt....';


GO
CREATE TABLE [dbo].[ZipAndCity] (
    [Id]           INT           IDENTITY (1, 1) NOT NULL,
    [ZipCode]      INT           NOT NULL,
    [City]         INT           NOT NULL,
    [CreationTime] DATETIME2 (7) NOT NULL,
    [DeletedTime]  DATETIME2 (7) NULL,
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
PRINT N'unbenannte Einschränkungen auf [dbo].[Branch] wird erstellt....';


GO
ALTER TABLE [dbo].[Branch]
    ADD DEFAULT GetDate() FOR [CreationTime];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Company] wird erstellt....';


GO
ALTER TABLE [dbo].[Company]
    ADD DEFAULT GetDate() FOR [CreationTime];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Employee] wird erstellt....';


GO
ALTER TABLE [dbo].[Employee]
    ADD DEFAULT GetDate() FOR [CreationTime];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[ZipAndCity] wird erstellt....';


GO
ALTER TABLE [dbo].[ZipAndCity]
    ADD DEFAULT GetDate() FOR [CreationTime];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address] wird erstellt....';


GO
ALTER TABLE [dbo].[Address] WITH NOCHECK
    ADD FOREIGN KEY ([City_Id]) REFERENCES [dbo].[ZipAndCity] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Company] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Company] WITH NOCHECK
    ADD FOREIGN KEY ([Address_Id]) REFERENCES [dbo].[Address] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Company] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Company] WITH NOCHECK
    ADD FOREIGN KEY ([Employee_Id]) REFERENCES [dbo].[Employee] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Employee] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Employee] WITH NOCHECK
    ADD FOREIGN KEY ([Address_Id]) REFERENCES [dbo].[Address] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Employee] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Employee] WITH NOCHECK
    ADD FOREIGN KEY ([Company_Id]) REFERENCES [dbo].[Company] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Branch] wird erstellt....';


GO
ALTER TABLE [dbo].[Branch] WITH NOCHECK
    ADD FOREIGN KEY ([Manager_Id]) REFERENCES [dbo].[Employee] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Branch] wird erstellt....';


GO
ALTER TABLE [dbo].[Branch] WITH NOCHECK
    ADD FOREIGN KEY ([Company_Id]) REFERENCES [dbo].[Company] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Employee] wird erstellt....';


GO
ALTER TABLE [dbo].[Employee] WITH NOCHECK
    ADD FOREIGN KEY ([Branch_Id]) REFERENCES [dbo].[Branch] ([Id]);


GO
PRINT N'[dbo].[viBranch] wird erstellt....';


GO
CREATE VIEW [dbo].[viBranch]
	AS	SELECT B.Id, B.Manager_Id, B.Company_Id
		FROM [Branch] AS B
		WHERE B.DeletedTime = 0
GO
PRINT N'[dbo].[viCompany] wird erstellt....';


GO
CREATE VIEW [dbo].[viCompany]
	AS	SELECT C.Id, C.Company_Name
		FROM [Company] as C
		WHERE C.DeletedTime = 0
GO
PRINT N'[dbo].[viEmployee] wird erstellt....';


GO
CREATE VIEW [dbo].[viEmployee]
	AS	SELECT E.Id, B.Branch_Name, E.Employee_Name, E.Employee_DateOfBirth, E.CreationTime
		FROM [Employee] AS E INNER JOIN [Branch] AS B ON E.Branch_Id = B.Id
		WHERE E.DeletedTime = 0
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
        WHERE  [parent_object_id] IN (OBJECT_ID(N'dbo.Address'), OBJECT_ID(N'dbo.Address2Company'), OBJECT_ID(N'dbo.Address2Employee'), OBJECT_ID(N'dbo.Branch'), OBJECT_ID(N'dbo.Employee'))
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
