--SELECT *
--INTO Sales.Customer_NoIndex
--FROM Sales.Customer
--SELECT *
--INTO Sales.Customer_Index
--FROM Sales.Customer
--GO
--CREATE INDEX Idx_Customer_Index_CustomerID ON
--Sales.Customer_Index(CustomerID)

-- #1
SELECT CustomerID, AccountNumber
FROM Sales.Customer_NoIndex
WHERE CustomerID = 11001
-- #2
SELECT CustomerID, AccountNumber
FROM Sales.Customer_Index
WHERE CustomerID = 11001

-- 1.Hiển thị Title, FirstName, MiddleName, LastName từ bảng Person.Person

Select Title, FirstName, MiddleName, LastName from Person.Person

-- 2.Hiển thị Title, FirstName, LastName như là một chuỗi nối nhằm dễ đọc và cung cấp tiêu đề cho cột tên (PersonName).

SELECT CONCAT(Title, FirstName, ' ', LastName) from Person.Person

-- 3. Hiển thị chi tiết địa chỉ của tất cả các nhân viên trong bảng Person.Address

Select AddressLine1 from Person.Address

--4. Liệt kê tên của các thành phố từ bảng Person.Address và bỏ đi phần lặp lại.
Select distinct City from Person.Address

--5. Hiển thị chi tiết của 10 bảng ghi đầu tiên của bảng Person.Address.

Select TOP 10 * from Person.Address

-- 6. Hiển thị trung bình của tỷ giá (Rate) từ bảng HumanResources.EmployeePayHistory.

Select avg(Rate) AvgRate from HumanResources.EmployeePayHistory

-- 7. Hiển thị tổng số nhân viên từ bảng HumanResources.Employee
Select count(BusinessEntityID) CountOfEmployee from HumanResources.Employee

-- 8. Đưa ra danh sách các khách hàng có trên 10 đơn hàng
select * from Sales.SalesOrderDetail
select count(CustomerID), SalesOrderID from [Sales].[SalesOrderHeader] 

select CustomerID, Count(SalesOrderDetail.SalesOrderID) as donHang from Sales.SalesOrderDetail, [Sales].[SalesOrderHeader]
where [SalesOrderHeader].SalesOrderID = SalesOrderDetail.SalesOrderID group by CustomerID order by CustomerID Desc
--[Person].[BusinessEntityContact] [Person].[Person] [Sales].[Customer] [Sales].[SalesOrderDetail] [Sales].[SalesOrderHeader]

Select * from Person.Person where Person.Person.[BusinessEntityID] in
(Select [BusinessEntityID] from [Person].[BusinessEntityContact] where [PersonID] in
(select PersonID from [Sales].[Customer] where CustomerID in
(select T2.CustomerID from 
(select CustomerID, count(T1.SalesOrderID) CountSalesOrderID from 
(select Distinct SalesOrderDetail.SalesOrderID, CustomerID from Sales.SalesOrderDetail, [Sales].[SalesOrderHeader]
where [SalesOrderHeader].SalesOrderID = SalesOrderDetail.SalesOrderID) T1 
Group by CustomerID) T2 where T2.CountSalesOrderID > 10)))

select CustomerID, PersonID from [Sales].[Customer] where CustomerID in

-- 9. Đưa ra danh sách các mặt hàng chưa từng được đặt hàng

-- 10. Sử dụng tool Execution Plan để giải thích các bước xử lý của các câu truy vấn trên

-- 11. Sử dụng index trên 1 bảng nào đấy, xem xét hiệu năng thực thi các câu truy vấn trên bảng đấy.

-- 12. Sử dụng câu truy vấn 10, hãy viết ra 2 đến 3 câu lệnh SQL, đánh giá hiệu năng thực thi giữa các câu lệnh SQL trên
