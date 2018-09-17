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
PRINT N'[dbo].[fnGenderLogic] wird geändert....';


GO
ALTER FUNCTION [dbo].[fnGenderLogic]
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
		when 0 then 'Male'
		when 1 then 'Female'
		when 3 then 'Universal'
		else		'Undefined'
		end

/*	if	(@GenderId = 0)		RETURN	'Männlich'
	if	(@GenderId = 1)		RETURN	'Weiblich'
	if	(@GenderId > 1)		RETURN	'Sonstige'*/
	RETURN 'Undefinded'
END
GO
PRINT N'Update abgeschlossen.';


GO
