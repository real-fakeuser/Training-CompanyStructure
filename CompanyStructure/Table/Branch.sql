CREATE TABLE [dbo].[Branch]
(
	[Id] INT NOT NULL PRIMARY KEY,
	[Manager_Id] int not null references Employee(Id),
	[Company_Id] int not null references Company(Id),
	[Employee_BirthDate] Datetime2(7) not null,
	[CreationTime] Datetime2(7) not null default GetDate(),
	[DeleteTime] Datetime2(7)
	)
