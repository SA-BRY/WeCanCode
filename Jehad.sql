--متوسط تقييم كل منتج

SELECT 
    p.Name AS Product_Name,
    AVG(r.Rate) AS Avg_Rating,
    COUNT(r.Rate) AS Number_of_Reviews
FROM Product p
LEFT JOIN Review r ON p.Product_ID = r.Product_ID
GROUP BY p.Name
HAVING COUNT(r.Rate) > 0
ORDER BY Avg_Rating DESC;


--عدد الطلبات لكل شركة شحن

SELECT 
    s.[Name] AS Shipping_Company,
    COUNT(sh.Shipping_ID) AS Orders_Shipped
FROM Shipping sh
JOIN Shipment_Company s ON sh.Shipment_ID = s.Shipment_ID
GROUP BY s.[Name]
ORDER BY Orders_Shipped DESC;

-- العملاء الي اعطو تقييم 5 نجوم

SELECT 
    c.First_Name + ' ' + c.Last_Name AS Customer_Name,
    r.Rate 
FROM Customer c
JOIN Review r ON c.Customer_ID = r.Customer_ID
where r.Rate = 5
ORDER BY r.Rate DESC;



--متوسط إنفاق لكل طريقة دفع
SELECT 
    pay.Method,
    COUNT(*) AS Payment_times,
    SUM(p.Price * o.Quantity) AS Total_Sales,
    AVG(p.Price * o.Quantity) AS Avg_Sales
FROM Payment pay
JOIN Cart ca ON pay.Cart_ID = ca.Cart_ID
JOIN Order_Line o ON ca.Cart_ID = o.Cart_ID
JOIN Product p ON o.Product_ID = p.Product_ID
GROUP BY pay.[Method]
ORDER BY Total_Sales DESC;

--جلب المنتجات التي سعرها أعلى من متوسط سعر الفئة الخاصة بها


SELECT 
    p.Product_ID,
    p.Name,
    p.Price,
    c.Category_Name
FROM Product p
JOIN Categories c ON p.Categories_ID = c.Categories_ID
WHERE p.Price > (
    SELECT AVG(p2.Price)
    FROM Product p2
    WHERE p2.Categories_ID = p.Categories_ID
);











