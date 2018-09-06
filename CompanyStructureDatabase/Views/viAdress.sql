CREATE VIEW [dbo].[viAddress]
	AS	SELECT A.Id, A.Employee_Id, A.Streed, A.HouseNumber, A.ZipCode, A.CityName, A.CreationTime
		FROM [Address] AS A
		WHERE A.DeleteTime = 0

