CREATE TABLE [dbo].[Address]
(
	[Id] INT NOT NULL PRIMARY KEY,
	[Employee_Id] int not null references Employee(Id),
	[Streed] nvarchar(256) not null,
	[HouseNumber] int not null,
	[ZipCode] int not null,
	[CityName] nvarchar(256),
	[ExtraInformation] nvarchar(256),
	[CreationTime] Datetime2(7) not null default GetDate(),
	[DeleteTime] Datetime2(7)

)
