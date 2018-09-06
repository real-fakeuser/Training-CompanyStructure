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
PRINT N'Update abgeschlossen.';


GO
