CREATE TABLE [dbo].[Address]
(
	[Id] INT NOT NULL PRIMARY KEY identity(1,1),
	[Streed] nvarchar(256) not null,
	[HouseNumber] int not null,
	[ExtraAddrInfo] nvarchar(256),
	[City_Id] int not null references ZipAndCity(Id),
	[CountryCode] nvarchar(4),
	[CreationTime] Datetime2(7) not null default GetDate(),
	[DeletedTime] Datetime2(7)
)
