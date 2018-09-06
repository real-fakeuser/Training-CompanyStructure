CREATE TABLE [dbo].[Address2Company]
(
	[Address_Id] INT NOT NULL references Address(Id),
	[Company_Id] INT NOT NULL references Company(Id),
	[CreationTime] Datetime2(7) not null default GetDate(),
	PRIMARY KEY ([Address_Id], [Company_Id])
)
