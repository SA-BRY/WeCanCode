--AddCustomer
CREATE OR ALTER PROCEDURE AddCustomer
    @First_Name NVARCHAR(50),
    @Last_Name  NVARCHAR(50),
    @User_Name  NVARCHAR(50),
    @Email      NVARCHAR(100),
    @Address    NVARCHAR(200),
    @Phone      NVARCHAR(20),
    @Password   NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Customer (First_Name, Last_Name, User_Name, Email, Address, Phone, Password)
    VALUES (@First_Name, @Last_Name, @User_Name, @Email, @Address, @Phone, @Password);

END;




-- UpdateCustomer
CREATE OR ALTER PROCEDURE UpdateCustomer
    @Customer_ID INT,
    @First_Name NVARCHAR(50),
    @Last_Name NVARCHAR(50),
    @Address NVARCHAR(200),
    @Phone NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Customer
    SET First_Name = @First_Name,
        Last_Name  = @Last_Name,
        Address    = @Address,
        Phone      = @Phone
    WHERE Customer_ID = @Customer_ID;

END;




-- deleteCustomer
CREATE OR ALTER PROCEDURE DeleteCustomer
    @Customer_ID INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Cart WHERE Customer_ID = @Customer_ID;
    DELETE FROM Customer WHERE Customer_ID = @Customer_ID;
END;
