select cast(CustomerID AS varchar(5)) + ':'+ CompanyName from SalesLT.Customer;

select SalesOrderNumber + '('+ CONVERT(char(1), RevisionNumber) +')', CONVERT ( varchar(10), OrderDate, 102 )  from SalesLT.SalesOrderHeader;
