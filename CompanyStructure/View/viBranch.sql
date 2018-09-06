CREATE VIEW [dbo].[viBranch]
	AS	SELECT B.Id, B.Manager_Id, B.Company_Id, B.CreationTime 
		FROM [Branch] AS B
		WHERE


	[Id] INT NOT NULL PRIMARY KEY,
	[Manager_Id] int not null REFERENCES Employee(Id),
	[Company_Id] int not null REFERENCES Company(Id),
	[Company
	[CreationTime] Datetime2(7) not null default GetDate(),
	[DeleteTime] Datetime2(7)