/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
IF NOT EXISTS (SELECT * FROM dbo.Person WHERE FirstName = 'Admin' AND LastName = 'User')
BEGIN
    INSERT INTO dbo.Person (FirstName, LastName)
    VALUES ('Admin', 'User');
END;

IF NOT EXISTS (SELECT * FROM dbo.Address WHERE Street = 'Apple Park')
BEGIN
    INSERT INTO dbo.Address (Street, City, State, ZipCode)
    VALUES ('Apple Park', 'Cupertino', 'California', '001000');
END;

DECLARE @AddressId INT;
DECLARE @PersonId INT;

SELECT @AddressId = Id FROM dbo.Address WHERE Street = 'Apple Park' AND City = 'Cupertino' AND State = 'California';
SELECT @PersonId = Id FROM dbo.Person WHERE FirstName = 'Admin' AND LastName = 'User';

IF NOT EXISTS (SELECT * FROM dbo.Employee WHERE EmployeeName = 'Admin User' AND AddressId = @AddressId)
BEGIN
    INSERT INTO dbo.Employee (AddressId, PersonId, CompanyName, Position, EmployeeName)
    VALUES (@AddressId, @PersonId, 'Apple Inc.', 'SEO', 'Admin User');
END;

IF NOT EXISTS (SELECT * FROM dbo.Company WHERE Name = 'Apple Inc.' AND AddressId = @AddressId)
BEGIN
    INSERT INTO dbo.Company(AddressId, Name)
    VALUES (@AddressId, 'Apple Inc.');
END;

