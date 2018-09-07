CREATE VIEW [dbo].[viCompanyDetailed]
	AS	SELECT C.Company_Name, A.Streed, A.HouseNumber, A.ExtraAddrInfo, Z.ZipCode, Z.City, A.CountryCode
		FROM [Company] C JOIN [Address2Company] L
		ON C.Id = L.Company_Id
		JOIN [Address] A
		ON L.Address_Id = A.Id
		JOIN [ZipAndCity] Z
		ON A.City_Id = Z.Id
