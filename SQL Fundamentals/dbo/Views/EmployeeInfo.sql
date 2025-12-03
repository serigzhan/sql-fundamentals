CREATE VIEW [dbo].[EmployeeInfo]
	AS
	SELECT 
		[employee].[Id] AS EmplyeeId, 
		ISNULL([employee].[EmployeeName], [person].[FirstName] + ' ' + [person].[LastName]) as EmpoyeeFullName,
		[address].[ZipCode] + '_' + [address].[State] + ', ' + [address].[City] + '-' + [address].[Street] as EmplyeeFullAddress,
		[employee].[CompanyName] + '(' + [employee].[Position] + ')' as EmployeeCompanyInfo
	FROM dbo.Employee employee
	LEFT JOIN dbo.Address address ON [employee].[AddressId] = [address].[Id]
	LEFT JOIN dbo.Person person ON [employee].[PersonId] = [person].[Id]
