CREATE VIEW [dbo].[viAddress_temp]
	AS	SELECT A.Streed, A.HouseNumber, A.ExtraAddrInfo, A.CountryCode, A.City_Id, C.City, C.ZipCode
		FROM [Address] A JOIN [ZipAndCity] C
		ON A.City_Id = C.Id;
