CREATE TABLE [dbo].[Branch2Companie]
(
	[Branch_Id] int not null references Branch(Id) primary key,
	[Company_Id] int not null references Company(Id) primary key
)
