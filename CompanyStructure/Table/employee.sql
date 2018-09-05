CREATE TABLE [dbo].[employee]
(
	[employee_Id] INT NOT NULL PRIMARY KEY,
	[employee_Name] nvarchar(256) not null,
	[employee_BirthDate] Datetime2(7) not null,
	[CreationTime] Datetime2(7) not null default GetDate(),
	[DeleteTime] Datetime2(7)
)
