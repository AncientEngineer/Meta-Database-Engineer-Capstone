CREATE VIEW OrdersView AS
SELECT 	o.OrderID,
		oi.qty,
		o.TotalСost
FROM mydb.order o
LEFT JOIN mydb.orderItem oi
ON o.OrderID = oi.OrderID
WHERE oi.qty > 2;

CREATE VIEW CustomerView AS
SELECT 	c.CustomerID AS CustomerID,
		CONCAT(c.FirstName, c.LastName) as FullName,
        o.OrderID AS OrderID,
        o.TotalСost,
        p.ProductName
FROM mydb.customer c
JOIN mydb.order o ON c.CustomerID = o.CustomerID
JOIN mydb.orderItem oi ON o.OrderID = oi.OrderID
JOIN mydb.product p ON oi.ProductID = p.ProductID
WHERE o.TotalСost > 150
ORDER BY o.TotalСost DESC;