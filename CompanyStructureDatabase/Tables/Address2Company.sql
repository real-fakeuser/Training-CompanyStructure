CREATE TABLE [dbo].[Address2Company]
(
	[Address_Id] INT NOT NULL references Address(Id),
	[Employee_Id] INT NOT NULL references Employee(Id),
	[CreationTime] Datetime2(7) not null default GetDate(),
	PRIMARY KEY ([Address_Id], [Employee_Id])
)
