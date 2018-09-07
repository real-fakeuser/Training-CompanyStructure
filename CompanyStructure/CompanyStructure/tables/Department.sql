CREATE TABLE [dbo].[Department]
(
	[Id] INT NOT NULL PRIMARY KEY identity(1,1),
	[ManagerId] int REFERENCES Employee(Id),
	[CompanyId] int null REFERENCES Company(Id),
	[Name] nvarchar(256) not null,
	[CreationTime] Datetime2(7) default GetDate(),
	[DeletedTime] Datetime2(7)
)
