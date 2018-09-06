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
/*
Die Spalte "[dbo].[Address2Company].[Employee_Id]" wird gelöscht, es könnte zu einem Datenverlust kommen.

Die Spalte "[dbo].[Address2Company].[Company_Id]" in der Tabelle "[dbo].[Address2Company]" muss hinzugefügt werden, besitzt jedoch keinen Standardwert und unterstützt keine NULL-Werte. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript nicht. Um dieses Problem zu vermeiden, müssen Sie der Spalte einen Standardwert hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.
*/

IF EXISTS (select top 1 1 from [dbo].[Address2Company])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
/*
Die Spalte "[dbo].[Address2Employee].[Company_Id]" wird gelöscht, es könnte zu einem Datenverlust kommen.

Die Spalte "[dbo].[Address2Employee].[Employee_Id]" in der Tabelle "[dbo].[Address2Employee]" muss hinzugefügt werden, besitzt jedoch keinen Standardwert und unterstützt keine NULL-Werte. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript nicht. Um dieses Problem zu vermeiden, müssen Sie der Spalte einen Standardwert hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.
*/

IF EXISTS (select top 1 1 from [dbo].[Address2Employee])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Company] wird gelöscht....';


GO
ALTER TABLE [dbo].[Address2Company] DROP CONSTRAINT [DF__Address2C__Creat__2B3F6F97];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Employee] wird gelöscht....';


GO
ALTER TABLE [dbo].[Address2Employee] DROP CONSTRAINT [DF__Address2E__Creat__2C3393D0];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Company] wird gelöscht....';


GO
ALTER TABLE [dbo].[Address2Company] DROP CONSTRAINT [FK__Address2C__Addre__31EC6D26];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Company] wird gelöscht....';


GO
ALTER TABLE [dbo].[Address2Company] DROP CONSTRAINT [FK__Address2C__Emplo__32E0915F];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Employee] wird gelöscht....';


GO
ALTER TABLE [dbo].[Address2Employee] DROP CONSTRAINT [FK__Address2E__Addre__33D4B598];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Employee] wird gelöscht....';


GO
ALTER TABLE [dbo].[Address2Employee] DROP CONSTRAINT [FK__Address2E__Compa__34C8D9D1];


GO
PRINT N'Das erneute Erstellen der Tabelle "[dbo].[Address2Company]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Address2Company] (
    [Address_Id]   INT           NOT NULL,
    [Company_Id]   INT           NOT NULL,
    [CreationTime] DATETIME2 (7) DEFAULT GetDate() NOT NULL,
    PRIMARY KEY CLUSTERED ([Address_Id] ASC, [Company_Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Address2Company])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Address2Company] ([Address_Id], [CreationTime])
        SELECT   [Address_Id],
                 [CreationTime]
        FROM     [dbo].[Address2Company]
        ORDER BY [Address_Id] ASC;
    END

DROP TABLE [dbo].[Address2Company];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Address2Company]', N'Address2Company';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Das erneute Erstellen der Tabelle "[dbo].[Address2Employee]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Address2Employee] (
    [Address_Id]   INT           NOT NULL,
    [Employee_Id]  INT           NOT NULL,
    [CreationTime] DATETIME2 (7) DEFAULT GetDate() NOT NULL,
    PRIMARY KEY CLUSTERED ([Address_Id] ASC, [Employee_Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Address2Employee])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Address2Employee] ([Address_Id], [CreationTime])
        SELECT   [Address_Id],
                 [CreationTime]
        FROM     [dbo].[Address2Employee]
        ORDER BY [Address_Id] ASC;
    END

DROP TABLE [dbo].[Address2Employee];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Address2Employee]', N'Address2Employee';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Company] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Company] WITH NOCHECK
    ADD FOREIGN KEY ([Address_Id]) REFERENCES [dbo].[Address] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Company] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Company] WITH NOCHECK
    ADD FOREIGN KEY ([Company_Id]) REFERENCES [dbo].[Company] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Employee] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Employee] WITH NOCHECK
    ADD FOREIGN KEY ([Address_Id]) REFERENCES [dbo].[Address] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Employee] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Employee] WITH NOCHECK
    ADD FOREIGN KEY ([Employee_Id]) REFERENCES [dbo].[Employee] ([Id]);


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
        WHERE  [parent_object_id] IN (OBJECT_ID(N'dbo.Address2Company'), OBJECT_ID(N'dbo.Address2Employee'))
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
