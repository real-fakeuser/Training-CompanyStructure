CREATE VIEW [dbo].[viBranch]
	AS	SELECT B.Id, B.Manager_Id, B.Company_Id
		FROM [Branch] AS B
		WHERE B.DeletedTime IS NULL