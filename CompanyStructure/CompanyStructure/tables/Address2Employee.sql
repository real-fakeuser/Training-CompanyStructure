CREATE TABLE [dbo].[Address2Employee]
(
	[AddressId] INT NOT NULL references Address(Id),
	[EmployeeId] INT NOT NULL references Employee(Id),
	[CreationTime] Datetime2(7) not null default GetDate(),
	PRIMARY KEY ([AddressId], [EmployeeId])
)
