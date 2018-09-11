CREATE VIEW [dbo].[viEmployee]
	AS	SELECT	E.Id,
				E.Name Employee, 
				dbo.fnGenderLogic (E.Gender) AS Gender,
				D.Name Department, 
				C.Name Company
		FROM	[Employee] E 
				LEFT JOIN [Department] D	ON E.DepartmentId = D.Id
				LEFT JOIN [Company] C ON D.CompanyId = C.Id
		WHERE	E.DeletedTime IS NULL
				AND		D.DeletedTime IS NULL
				AND		C.DeletedTime IS NULL