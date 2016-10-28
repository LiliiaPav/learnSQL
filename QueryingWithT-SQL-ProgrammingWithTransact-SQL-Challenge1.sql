/*
Creating scripts to insert sales orders
You want to create reusable scripts that make it easy to insert sales orders. 
You plan to create a script to insert the order header record, and a separate script to insert order detail records 
for a specified order header. Both scripts will make use of variables to make them easy to reuse. 

Tip: Review the documentation for variables and the IF…ELSE block in the Transact-SQL Language Reference.

1. Write code to insert an order header
Your script to insert an order header must enable users to specify values for the order date, due date, and customer ID. 
The SalesOrderID should be generated from the next value for the SalesLT.SalesOrderNumber sequence and assigned to a variable. 
The script should then insert a record into the SalesLT.SalesOrderHeader table using these values and a hard-coded value 
of ‘CARGO TRANSPORT 5’ for the shipping method with default or NULL values for all other columns.
After the script has inserted the record, it should display the inserted SalesOrderID using the PRINT command.
Test your code with the following values:

Order Date		Due Date			Customer ID	
Today’s date	7 days from now		1

Note: Support for Sequence objects was added to Azure SQL Database in version 12, which became available in some regions 
in February 2015. If you are using the previous version of Azure SQL database (and the corresponding previous version 
of the AdventureWorksLT sample database), you will need to adapt your code to insert the sales order header without specifying 
the SalesOrderID (which is an IDENTITY column in older versions of the sample database), and then assign the most recently 
generated identity value to the variable you have declared.*/

CREATE PROCEDURE SP_InsertAnOrderHeader 
@CustomerID	int,
@ShipMethod nvarchar(50)
AS
DECLARE @OrderDate date
DECLARE @DueDate date



SET @OrderDate=GETDATE()
SET @DueDate=DATEADD(dd, 7, GETDATE())

INSERT INTO [SalesLT].[SalesOrderHeader]
           ([OrderDate]
           ,[DueDate]
           ,[CustomerID]
           ,[ShipMethod]
)
     VALUES
           ( @OrderDate, @DueDate, @CustomerID, @ShipMethod)
DECLARE @OrderID int
SET @OrderID=IDENT_CURRENT('[SalesLT].[SalesOrderHeader]')
PRINT @OrderID
GO
EXEC SP_InsertAnOrderHeader 1, 'CARGO TRANSPORT 5'
go


/*
2. Write code to insert an order detail
The script to insert an order detail must enable users to specify a sales order ID, a product ID, a quantity, and a unit price. 
It must then check to see if the specified sales order ID exists in the SalesLT.SalesOrderHeader table. 
If it does, the code should insert the order details into the SalesLT.SalesOrderDetail table 
(using default values or NULL for unspecified columns). If the sales order ID does not exist in the SalesLT.SalesOrderHeader table, 
the code should print the message ‘The order does not exist’. You can test for the existence of a record by using the EXISTS predicate.
Test your code with the following values:

Sales Order ID			Product ID		Quantity	Unit Price	
The sales order ID		760				1			782.99
returned by your 
previous code to 
insert a sales order 
header.

Then test it again with the following values:
Sales Order ID		Product ID		Quantity		Unit Price
0					760				1				782.99
*/
SELECT * FROM [SalesLT].[SalesOrderDetail]
GO

CREATE PROCEDURE SP_InsertOrderDetail
@ProductID int,
@SalesOrderID int ,
@Quantity int,
@UnitPrice money

AS

IF @SalesOrderID IN (SELECT [SalesOrderID] FROM [SalesLT].[SalesOrderHeader])
	BEGIN
	INSERT INTO [SalesLT].[SalesOrderDetail]
           ([SalesOrderID]
           ,[OrderQty]
           ,[ProductID]
           ,[UnitPrice])
     VALUES
           (@SalesOrderID, @Quantity, @ProductID, @UnitPrice)
	END
ELSE
	BEGIN
	Print 'Error - Not found SalesOrderID'
	END
	GO

DECLARE @OrderID int
SET @OrderID=IDENT_CURRENT('[SalesLT].[SalesOrderHeader]')
PRINT @OrderID
EXEC SP_InsertOrderDetail 760, @OrderID, 1, 782.99
EXEC SP_InsertOrderDetail 760, 0, 1, 782.99