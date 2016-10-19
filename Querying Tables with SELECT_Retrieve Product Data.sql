select Name, Color, Size from SalesLT.Product where ProductModelID=1;

select ProductNumber, Name from SalesLT.Product where Color in ('Black', 'Red', 'White') and Size in ('S', 'M');

select ProductNumber, Name, ListPrice from SalesLT.Product where ProductNumber like 'BK-[^R]%-[0-9][0-9]'