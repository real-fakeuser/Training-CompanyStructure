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
Die Spalte "CityId" der Tabelle "[dbo].[Address]" muss von NULL in NOT NULL geändert werden. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript u. U. nicht. Um dieses Problem zu vermeiden, müssen Sie dieser Spalte für alle Zeilen Werte hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.
*/

IF EXISTS (select top 1 1 from [dbo].[Address])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address] wird gelöscht....';


GO
ALTER TABLE [dbo].[Address] DROP CONSTRAINT [FK__Address__CityId__123EB7A3];


GO
PRINT N'[dbo].[Address] wird geändert....';


GO
ALTER TABLE [dbo].[Address] ALTER COLUMN [CityId] INT NOT NULL;


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address] wird erstellt....';


GO
ALTER TABLE [dbo].[Address] WITH NOCHECK
    ADD FOREIGN KEY ([CityId]) REFERENCES [dbo].[City] ([ZipCode]);


GO
PRINT N'[dbo].[viAddress] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[viAddress]';


GO
PRINT N'[dbo].[viCompany] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[viCompany]';


GO
PRINT N'[dbo].[spCreateOrUpdateAddress] wird geändert....';


GO
ALTER PROCEDURE [dbo].[spCreateOrUpdateAddress]
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
					WHERE Street LIKE @Street)

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
			WHERE	Id = @ZipCode
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
        WHERE  [parent_object_id] IN (OBJECT_ID(N'dbo.Address'))
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
