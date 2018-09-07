CREATE VIEW [dbo].[viEmployee]
	AS	SELECT B.Branch_Name, E.Employee_Name, E.Employee_DateOfBirth
		FROM [Employee] AS E INNER JOIN [Branch] AS B ON E.Branch_Id = B.Id
		WHERE E.DeletedTime IS NULL




