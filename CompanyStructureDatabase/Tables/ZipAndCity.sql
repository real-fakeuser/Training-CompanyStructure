CREATE TABLE [dbo].[ZipAndCity]
(
	[Id] INT NOT NULL PRIMARY KEY identity(1,1),
	[ZipCode] int not null,	
	[City] int not null,
	[CreationTime] Datetime2(7) not null default GetDate(),
	[DeletedTime] Datetime2(7)
)
