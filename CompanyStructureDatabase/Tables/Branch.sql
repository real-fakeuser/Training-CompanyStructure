CREATE TABLE [dbo].[Branch]
(
	[Id] INT NOT NULL PRIMARY KEY identity(1,1),
	[Manager_Id] int REFERENCES Employee(Id),
	[Company_Id] int not null REFERENCES Company(Id),
	[Branch_Name] nvarchar(256) not null,
	[CreationTime] Datetime2(7) default GetDate(),
	[DeletedTime] Datetime2(7)
	)
