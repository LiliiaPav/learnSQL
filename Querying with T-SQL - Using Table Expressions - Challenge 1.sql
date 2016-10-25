/*
Challenge 1: Retrieve Product Information
Adventure Works sells many products that are variants of the same product model. You must write queries that retrieve 
information about these products
1. Retrieve product model descriptions
Retrieve the product ID, product name, product model name, and product model summary for each product 
from the SalesLT.Product table and the SalesLT.vProductModelCatalogDescription view.*/
SELECT P.[ProductID], P.[Name], P.[ProductModelID], PMCD.Summary
FROM [SalesLT].[Product] P
JOIN [SalesLT].[vProductModelCatalogDescription] PMCD
ON P.ProductModelID=PMCD.ProductModelID

/*
2. Create a table of distinct colors 
Tip: Review the documentation for Variables in Transact-SQL Language Reference.
Create a table variable and populate it with a list of distinct colors from the SalesLT.Product table. 
Then use the table variable to filter a query that returns the product ID, name, and color from the SalesLT.Product table 
so that only products with a color listed in the table variable are returned.*/
DECLARE @tblColors table (
ProdCol varchar(30))

INSERT INTO @tblColors 
SELECT DISTINCT [Color] FROM [SalesLT].[Product]
SELECT [ProductID], [Name], [Color]
FROM [SalesLT].[Product] P
WHERE [Color] in (SELECT * FROM @tblColors)

/*
3. Retrieve product parent categories
The AdventureWorksLT database includes a table-valued function named dbo.ufnGetAllCategories, 
which returns a table of product categories (for example ‘Road Bikes’) and parent categories (for example ‘Bikes’). 
Write a query that uses this function to return a list of all products including their parent category and category.
*/
EXEC sp_helptext '[dbo].[ufnGetAllCategories]'

select P.Name ProductName, PC.ProductCategoryID, PC.ProductCategoryName, PC.ParentProductCategoryName

from [SalesLT].[Product] P
join [dbo].[ufnGetAllCategories]() PC 
ON P.ProductCategoryID=PC.ProductCategoryID
