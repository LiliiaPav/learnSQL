select 
case
when MiddleName is null then FirstName+' '+LastName
else FirstName+' '+ MiddleName+' '+LastName
end as CustomerName
from SalesLT.Customer;

select CustomerID, COALESCE(EmailAddress, phone) from SalesLT.Customer;

select SalesOrderID, 
case
when ShipDate is null then 'Awaiting for shipment'
else 'Shipped'
end as ShipStatus
from SalesLT.SalesOrderHeader;

select * from SalesLT.SalesOrderHeader;