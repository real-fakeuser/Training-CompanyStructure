CREATE VIEW [dbo].[viAddress]
	AS	SELECT	A.Id, 
				A.Street, 
				C.ZipCode,
				C.Name AS City, 
				C.CountryCode
		FROM	[Address] A
				LEFT JOIN City C ON A.CityId LIKE C.ZipCode
		WHERE	A.DeletedTime IS NULL
				AND	C.DeletedTime IS NULL