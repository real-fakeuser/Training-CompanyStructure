CREATE TABLE [dbo].[Address]
(
	[Id] INT NOT NULL PRIMARY KEY identity(0,1),
	[Street] nvarchar(256) not null,
	[CityId] nvarchar(128) not null references City(ZipCode),
	[CreationTime] Datetime2(7) not null default GetDate(),
	[DeletedTime] Datetime2(7)
)
