عرض تفاصيل الطلبات مع أسماء العملاء والمنتجات
CREATE VIEW vw_OrderDetails AS
SELECT
    o.Order_ID,
    c.First_Name + ' ' + c.Last_Name AS Customer_Name,
    p.Name AS Product_Name,
    o.Quantity,
    o.Status,
    o.Receiver_Address
FROM Order_Line o
JOIN Cart ca ON o.Cart_ID = ca.Cart_ID
JOIN Customer c ON ca.Customer_ID = c.Customer_ID
JOIN Product p ON o.Product_ID = p.Product_ID;


عرض المبيعات حسب الفئة (Category Sales)
CREATE VIEW vw_CategorySales AS
SELECT
    cat.Category_Name,
    SUM(o.Quantity * p.Price) AS Total_Sales
FROM Order_Line o
JOIN Product p ON o.Product_ID = p.Product_ID
JOIN Categories cat ON p.Categories_ID = cat.Categories_ID
GROUP BY cat.Category_Name;




عرض أعلى 10 منتجات مبيعاً
CREATE VIEW vw_TopProducts AS
SELECT TOP 10
    p.Name AS Product_Name,
    SUM(o.Quantity) AS Total_Sold
FROM Order_Line o
JOIN Product p ON o.Product_ID = p.Product_ID
GROUP BY p.Name
ORDER BY Total_Sold DESC;




عرض تقييمات المنتجات مع أسماء العملاء
CREATE VIEW vw_ProductReviews AS
SELECT
    p.Name AS Product_Name,
    c.User_Name AS Customer,
    r.Rate,
    r.Description,
FROM Review r
JOIN Product p ON r.Product_ID = p.Product_ID
JOIN Customer c ON r.Customer_ID = c.Customer_ID;





عرض الطلبات الجاهزة للشحن
CREATE VIEW vw_ReadyToShip AS
SELECT
    o.Order_ID,
    c.First_Name + ' ' + c.Last_Name AS Customer_Name,
    o.Status,
    s.Name AS Shipment_Company
FROM Order_Line o
JOIN Cart ca ON o.Cart_ID = ca.Cart_ID
JOIN Customer c ON ca.Customer_ID = c.Customer_ID
LEFT JOIN Shipping sh ON sh.Cart_ID = ca.Cart_ID
LEFT JOIN Shipment_Company s ON sh.Shipment_ID = s.Shipment_ID
WHERE o.Status IN ('Processing','Shipped');




عرض متوسط التقييم لكل منتج
CREATE VIEW vw_ProductRatingAvg AS
SELECT
    p.Name AS Product_Name,
    AVG(r.Rate) AS Average_Rating,
    COUNT(r.Rate) AS Total_Reviews
FROM Review r
JOIN Product p ON r.Product_ID = p.Product_ID
GROUP BY p.Name;








عرض العملاء وعدد الطلبات لكل منهم
CREATE VIEW vw_CustomerOrders AS
SELECT
    c.Customer_ID,
    c.User_Name,
    COUNT(o.Order_ID) AS Total_Orders
FROM Customer c
JOIN Cart ca ON c.Customer_ID = ca.Customer_ID
JOIN Order_Line o ON ca.Cart_ID = o.Cart_ID
GROUP BY c.Customer_ID, c.User_Name;





