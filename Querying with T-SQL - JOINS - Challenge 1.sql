/*Challenge 1: Generate Invoice Reports

Adventure Works Cycles sells directly to retailers, who must be invoiced for their orders. 
You have been tasked with writing a query to generate a list of invoices to be sent to customers. 
Tip: Review the documentation for the FROM clause in the Transact-SQL Reference.


1. Retrieve customer orders
As an initial step towards generating the invoice report, 
write a query that returns the company name from the SalesLT.Customer table, 
and the sales order ID and total due from the SalesLT.SalesOrderHeader table.
*/

select SalesLT.Customer.CompanyName, SalesLT.SalesOrderHeader.SalesOrderID, SalesLT.SalesOrderHeader.TotalDue  
from SalesLT.Customer 
	JOIN SalesLT.SalesOrderHeader ON SalesLT.SalesOrderHeader.CustomerID=SalesLT.Customer.CustomerID
order by SalesLT.Customer.CompanyName;

/*
2. Retrieve customer orders with addresses
Extend your customer orders query to include the Main Office address for each customer, 
including the full street address, city, state or province, postal code, and country or region 
Tip: Note that each customer can have multiple addressees in the SalesLT.Address table, 
so the database developer has created the SalesLT.CustomerAddress table to enable a many-to-many relationship 
between customers and addresses. Your query will need to include both of these tables, and should filter 
the join to SalesLT.CustomerAddress so that only Main Office addresses are included.
*/
select SalesLT.Customer.CompanyName, [SalesLT].[Address].AddressLine1, ISNULL([SalesLT].[Address].AddressLine2, ''), [SalesLT].[Address].City, [SalesLT].[Address].StateProvince, [SalesLT].[Address].PostalCode, [SalesLT].[Address].CountryRegion, SalesLT.SalesOrderHeader.SalesOrderID, SalesLT.SalesOrderHeader.TotalDue  
from SalesLT.Customer 
	JOIN SalesLT.SalesOrderHeader ON SalesLT.SalesOrderHeader.CustomerID=SalesLT.Customer.CustomerID
	JOIN [SalesLT].[CustomerAddress] ON [SalesLT].[CustomerAddress].CustomerID=SalesLT.Customer.CustomerID AND [SalesLT].[CustomerAddress].AddressType='Main Office'
	JOIN [SalesLT].[Address] ON [SalesLT].[CustomerAddress].AddressID=[SalesLT].[Address].AddressID
order by SalesLT.Customer.CompanyName;
