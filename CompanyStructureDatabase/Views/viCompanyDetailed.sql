CREATE VIEW [dbo].[viCompanyDetailed]
	AS	SELECT C.Id, C.Company_Name, C.CreationTime, Address2Company.Address_Id, Address2Company.Company_Id
		FROM Company AS C
		INNER JOIN Address2Company
		ON C.Id = Address2Company.Company_Id
		LEFT OUTER JOIN Address2Company
		ON dbo.[Address].Id = Address2Company.Address_Id
		WHERE C.DeletedTime IS NULL