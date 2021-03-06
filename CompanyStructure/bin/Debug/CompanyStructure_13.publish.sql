﻿/*
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
PRINT N'[dbo].[spCreateOrUpdateEmployee] wird erstellt....';


GO
CREATE PROCEDURE [dbo].[spCreateOrUpdateEmployee]
	@Id		int = -1,
	@Department int = -1,
	@Gender	int = -1,
	@DateOfBirth Datetime2(7)
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
										Gender,
										DateOfBirth
										)
			VALUES						(
										@Department,
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
