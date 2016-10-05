select SalesPerson, Title +' '+ FirstName+ ' ' + ISNULL(MiddleName, ' ') + LastName + ' ' +ISNULL(Suffix, '') AS [Customer Name], Phone 
from SalesLT.Customer;