﻿CREATE TABLE [dbo].[Company]
(
	[Id] INT NOT NULL PRIMARY KEY identity(1,1),
	[Company_Name] nvarchar(256) Not Null,
	[CreationTime] Datetime2(7) not null default GetDate(),
	[DeletedTime] Datetime2(7)
)
