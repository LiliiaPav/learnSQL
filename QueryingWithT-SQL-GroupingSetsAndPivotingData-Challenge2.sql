/*
Retrieve Customer Sales Revenue by Category
Adventure Works products are grouped into categories, which in turn have parent categories (defined in the SalesLT.vGetAllCategories view). 
Adventure Works customers are retail companies, and they may place orders for products of any category. 
The revenue for each product in an order is recorded as the LineTotal value in the SalesLT.SalesOrderDetail table.

1. Retrieve customer sales revenue for each parent category 
Tip: Review the documentation for the PIVOT operator in the FROM clause syntax in the Transact-SQL language reference.
*/
SELECT*
FROM (
SELECT PC.ParentProductCategoryName ParCateg, C.CompanyName, SD.LineTotal AS Revenue
FROM SalesLT.vGetAllCategories PC
JOIN [SalesLT].[Product] P ON P.ProductCategoryID=PC.ProductCategoryID
JOIN [SalesLT].[SalesOrderDetail] SD ON P.ProductID=SD.ProductID
JOIN [SalesLT].[SalesOrderHeader] SOH ON SD.SalesOrderID=SOH.SalesOrderID
JOIN [SalesLT].[Customer] C ON C.CustomerID=SOH.CustomerID) AS temp
PIVOT (SUM(Temp.Revenue) FOR ParCateg IN(Accessories, Clothing, Bikes, Components)) AS pvt
go
