CREATE VIEW [dbo].[viDepartment]
	AS	SELECT	C.Name Company, 
				D.Name Department, 
				E.Name Manager
		FROM	[Department] D
				JOIN [Company] C ON D.CompanyId = C.Id
				JOIN [Employee] E ON D.ManagerId = E.Id
		WHERE	D.DeletedTime IS NULL
				AND		E.DeletedTime IS NULL
				AND		C.DeletedTime IS NULL