CREATE TABLE [dbo].[Employee]
(
	[Id] INT NOT NULL PRIMARY KEY identity(1,1),
	[DepartmentId] int null REFERENCES Department(Id),
	[Name] nvarchar(256) not null,
	[Gender] int null,
	[DateOfBirth] Datetime2(7) null,
	[CreationTime] Datetime2(7) not null default GetDate(),
	[DeletedTime] Datetime2(7)
)
