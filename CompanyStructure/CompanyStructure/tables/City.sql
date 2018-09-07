CREATE TABLE [dbo].[City]
(
	[Id] INT NOT NULL PRIMARY KEY identity(1,1),
	[Name] nvarchar(128) not null,
	[ZipCode] int not null,	
	[CountryCode] nvarchar(8) not null,
	[CreationTime] Datetime2(7) not null default GetDate(),
	[DeletedTime] Datetime2(7)
)
