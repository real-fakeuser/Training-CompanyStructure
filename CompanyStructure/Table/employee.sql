CREATE TABLE [dbo].[employee]
(
	[Id] INT NOT NULL PRIMARY KEY,
	[Branch_Id] int not null REFERENCES Branch(Id),
	[Employee_Name] nvarchar(256) not null,
	[Employee_BirthDate] Datetime2(7) not null,
	[CreationTime] Datetime2(7) not null default GetDate(),
	[DeleteTime] Datetime2(7)
)
