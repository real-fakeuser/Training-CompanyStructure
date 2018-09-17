CREATE TABLE [dbo].[Address2Company]
(
	[AddressId] INT NOT NULL references Address(Id),
	[CompanyId] INT NOT NULL references Company(Id),
	[CreationTime] Datetime2(7) not null default GetDate(),
	PRIMARY KEY ([AddressId], [CompanyId])
)
