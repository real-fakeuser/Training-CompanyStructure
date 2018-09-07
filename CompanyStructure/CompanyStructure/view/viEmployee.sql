CREATE VIEW [dbo].[viEmployee]
	AS	SELECT	E.Name Employee, 
				D.Name Department, 
				C.Name Company, 
				A.Street, 
				A.ZipCode, 
				A.City, 
				A.CountryCode
		FROM	[Employee] E 
				LEFT JOIN [Address2Employee] L ON E.Id = L.EmployeeId
				LEFT JOIN [viAddress] A ON L.AddressId = A.Id
				LEFT JOIN [Department] D	ON E.DepartmentId = D.Id
				LEFT JOIN [Company] C ON D.CompanyId = C.Id
		WHERE	E.DeletedTime IS NULL
				AND		D.DeletedTime IS NULL
				AND		C.DeletedTime IS NULL