CREATE TABLE [dbo].[Branch]
(
	[Branch_Id] INT NOT NULL PRIMARY KEY,
	[Manager_Id] int not null REFERENCES Employee(Employee_Id),
	[Company_Id] int not null REFERENCES Company(Company_Id),
	[Employee_BirthDate] Datetime2(7) not null,
	[CreationTime] Datetime2(7) not null default GetDate(),
	[DeleteTime] Datetime2(7))
