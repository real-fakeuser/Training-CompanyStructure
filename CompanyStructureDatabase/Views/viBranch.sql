CREATE VIEW [dbo].[viBranch]
	AS	SELECT B.Manager_Id, B.Company_Id, B.Branch_Name
		FROM [Branch] AS B
		WHERE B.DeletedTime IS NULL