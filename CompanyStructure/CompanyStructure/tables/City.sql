﻿CREATE TABLE [dbo].[City]
(
	[ZipCode] nvarchar(128) NOT NULL PRIMARY KEY,
	[Name] nvarchar(128) not null,
	[CountryCode] nvarchar(8) not null,
	[CreationTime] Datetime2(7) not null default GetDate(),
	[DeletedTime] Datetime2(7)
)
