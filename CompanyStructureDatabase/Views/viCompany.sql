CREATE VIEW [dbo].[viCompany]
	AS	SELECT C.Id, C.Company_Name
		FROM [Company] as C
		WHERE C.DeletedTime IS NULL