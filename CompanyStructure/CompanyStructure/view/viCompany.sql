CREATE VIEW [dbo].[viCompany]
	AS	SELECT	C.[Name] Company, 
				A.Street, 
				A.ZipCode, 
				A.City, 
				A.CountryCode
		FROM	[Company] C 
				LEFT JOIN [Address2Company] L ON C.Id = L.CompanyId
				LEFT JOIN [viAddress] A ON L.AddressId = A.Id
		WHERE	C.DeletedTime IS NULL
				
