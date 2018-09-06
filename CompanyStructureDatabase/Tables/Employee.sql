CREATE TABLE [dbo].[Employee]
(
	[Id] INT NOT NULL PRIMARY KEY identity(1,1),
	[Branch_Id] int not null REFERENCES Branch(Id),
	[Employee_Name] nvarchar(256) not null,
	[Employee_DateOfBirth] Datetime2(7) not null,
	[CreationTime] Datetime2(7) not null default GetDate(),
	[DeletedTime] Datetime2(7)
)
