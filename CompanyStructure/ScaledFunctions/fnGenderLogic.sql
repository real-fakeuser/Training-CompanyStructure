﻿CREATE FUNCTION [dbo].[fnGenderLogic]
(
	@GenderId int
)
RETURNS NVARCHAR(256)
AS
BEGIN
/*	DECLARE @DBId Int
	SET @DBId = (	SELECT E.Gender
					FROM Employee E
					WHERE E.Id = @EmployeeId)
	DECLARE @GenderName NVARCHAR(256) = null
	SET @GenderName =	(	SELECT G.[Description]
							FROM Gender G
							WHERE G.Id = @DBId)
	RETURN @GenderName
	*/
	return case @GenderId 
		when 0 then 'Male'
		when 1 then 'Female'
		when 3 then 'Multiple choice'
		else		'Undefined'
		end

/*	if	(@GenderId = 0)		RETURN	'Männlich'
	if	(@GenderId = 1)		RETURN	'Weiblich'
	if	(@GenderId > 1)		RETURN	'Sonstige'*/
	RETURN 'Undefinded'
END
