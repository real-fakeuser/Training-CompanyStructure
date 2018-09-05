CREATE TABLE [dbo].[employee]
(
	[Employee_Id] INT NOT NULL PRIMARY KEY,
	[Branch_Id] int not null REFERENCES Branches[Branch_Id],
	[Employee_Name] nvarchar(256) not null,
	[Employee_BirthDate] Datetime2(7) not null,
	[CreationTime] Datetime2(7) not null default GetDate(),
	[DeleteTime] Datetime2(7)
)
