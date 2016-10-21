select [Name], [ProductNumber], Left ([ProductNumber], 2) Type,
	SUBSTRING ([ProductNumber], CHARINDEX('-', [ProductNumber]) +1, 4) ModelCode,
	SUBSTRING ([ProductNumber], LEN([ProductNumber]) - CHARINDEX('-', REVERSE (RIGHT([ProductNumber], 3)))+2, 2 )
from [SalesLT].[Product]
go 

/*Retrieve Product Information
Your reports are returning the correct records, but you would like to modify how these records are displayed. 
Tip: Review the documentation for Built-In Functions in the Transact-SQL Reference.

1. Retrieve the name and approximate weight of each product
Write a query to return the product ID of each product, together with the product name formatted 
as upper case and a column named ApproxWeight with the weight of each product rounded to the nearest whole unit.*/
select [ProductID], UPPER([Name]), ROUND([Weight],0) AS ApproxWeight 
FROM [SalesLT].[Product]
GO

/*2. Retrieve the year and month in which products were first sold
Extend your query to include columns named SellStartYear and SellStartMonth containing the year 
and month in which Adventure Works started selling each product. 
The month should be displayed as the month name (for example, ‘January’).*/
SELECT [ProductID], UPPER([Name]), ROUND([Weight],0) AS ApproxWeight,  
		DateNAme(mm, [SellStartDate]) SellStartMonth,YEAR([SellStartDate]) SellStartYear
from [SalesLT].[Product]
GO

/*3. Extract product types from product numbers
Extend your query to include a column named ProductType that contains the leftmost two characters from the product number.*/
SELECT [ProductID], UPPER([Name]), ROUND([Weight],0) AS ApproxWeight,  
		DateNAme(mm, [SellStartDate]) SellStartMonth,YEAR([SellStartDate]) SellStartYear,
		Left ([ProductNumber], 2) Type
from [SalesLT].[Product]
GO


/*4. Retrieve only products with a numeric size
Extend your query to filter the product returned so that only products with a numeric size are included.*/
SELECT [Name] 
FROM [SalesLT].[Product]
WHERE ISNUMERIC([Size])=1
GO

SELECT [ProductID], UPPER([Name]), ROUND([Weight],0) AS ApproxWeight,  
		DateNAme(mm, [SellStartDate]) SellStartMonth,YEAR([SellStartDate]) SellStartYear,
		Left ([ProductNumber], 2) Type
from [SalesLT].[Product]
WHERE ISNUMERIC([Size])=1
GO

