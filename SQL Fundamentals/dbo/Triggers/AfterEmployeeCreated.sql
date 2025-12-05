CREATE TRIGGER [AfterEmployeeCreated]
ON dbo.Employee
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO dbo.Company(AddressId, Name)
	SELECT employee.AddressId, employee.CompanyName
	FROM inserted employee;
END;
