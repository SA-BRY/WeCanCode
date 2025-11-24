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

--أفضل العملاء للتسويق حسب تقييماته

SELECT 
    c.First_Name + ' ' + c.Last_Name AS Customer_Name,
    AVG(r.Rate) AS Avg_Rating_Given,
    COUNT(r.Product_ID) AS Reviews_Count
FROM Customer c
JOIN Review r ON c.Customer_ID = r.Customer_ID
GROUP BY c.Customer_ID, c.First_Name, c.Last_Name
HAVING COUNT(r.Product_ID) >= 3 AND AVG(r.Rate) >= 4.5
ORDER BY Avg_Rating_Given DESC;

-- الشركة الأسرع وأكثر موثوقية
SELECT 
    s.[Name] AS Shipping_Company,
    COUNT(sh.Shipping_ID) AS Orders_Shipped,
    AVG(DATEDIFF(DAY, sh.Ship_Date, sh.Delivery_Date)) AS Avg_Shipping_Days
FROM Shipping sh
JOIN Shipment_Company s ON sh.Shipment_ID = s.Shipment_ID
GROUP BY s.[Name]
ORDER BY Avg_Shipping_Days ASC;












