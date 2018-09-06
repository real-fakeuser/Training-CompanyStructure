﻿CREATE VIEW [dbo].[viEmployee]
	AS	SELECT E.Id, B.Branch_Name, E.Employee_Name, E.Employee_DateOfBirth, E.CreationTime
		FROM [Employee] AS E INNER JOIN [Branch] AS B ON E.Branch_Id = B.Id
		WHERE E.DeletedTime = 0



