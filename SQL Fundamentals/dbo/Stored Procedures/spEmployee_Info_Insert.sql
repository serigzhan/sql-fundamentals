CREATE PROCEDURE [dbo].[spEmployee_Info_Insert]
	@CompanyName nvarchar(20),
	@Street nvarchar(50),
	@EmployeeName nvarchar(100) = NULL,
	@FirstName nvarchar(50) = NULL,
	@LastName nvarchar(50) = NULL,
	@Position nvarchar(30) = NULL,
	@City nvarchar(20) = NULL,
	@State nvarchar(50) = NULL,
	@ZipCode nvarchar(50) = NULL
AS
BEGIN
	DECLARE @HasEmployeeName INT;
	DECLARE @HasFirstAndLastName INT;

	SET @HasEmployeeName = CASE 
		WHEN @EmployeeName IS NULL OR TRIM(@EmployeeName) = '' THEN 0
		ELSE 1
	END;

	SET @HasFirstAndLastName = CASE
		WHEN @LastName IS NULL OR 
			@FirstName IS NULL OR
			TRIM(@LastName) = '' OR
			TRIM(@FirstName) = '' 
			THEN 0
		ELSE 1
	END;

	IF @HasEmployeeName + @HasFirstAndLastName = 0
	BEGIN
		RAISERROR('Employee Name cannot be empty', 16, 1);
		RETURN;
	END;
	
	DECLARE @AddressId INT;
	DECLARE @PersonId INT;

	INSERT INTO dbo.Address (Street, City, State, ZipCode)
	VALUES (@Street, @City, @State, @ZipCode);

	SET @AddressId = CAST(SCOPE_IDENTITY() AS INT);

	INSERT INTO dbo.Person (FirstName, LastName)
	VALUES (ISNULL(@FirstName, 'Unknown'), ISNULL(@LastName, 'Unknown'));

	SET @PersonId = CAST(SCOPE_IDENTITY() AS INT);

	INSERT INTO dbo.Employee (AddressId, PersonId, CompanyName, Position, EmployeeName)
    VALUES (@AddressId, @PersonId, @CompanyName, @Position, @EmployeeName);
END;
