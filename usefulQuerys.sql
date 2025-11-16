-- most cities has shipments 
SELECT 
    Receiver_Address,
    COUNT(*) AS Shipments
FROM Shipping
GROUP BY Receiver_Address


-- most 10 products sold

SELECT TOP 10
    P.Product_ID,
    P.Name,
    SUM(O.Quantity) AS Total_Sold
FROM Order_Line O
JOIN Product P ON O.Product_ID = P.Product_ID
GROUP BY P.Product_ID, P.Name
ORDER BY Total_Sold DESC;


-- all sales 

SELECT 
    SUM(O.Quantity * P.Price) AS Total_Revenue
FROM Order_Line O
JOIN Product P ON O.Product_ID = P.Product_ID;


-- most products got five stars rate 

SELECT 
    P.Product_ID,
    P.Name,
    COUNT(*) AS Five_Star_Count
FROM Review R
JOIN Product P ON P.Product_ID = R.Product_ID
WHERE R.Rate = 5
GROUP BY P.Product_ID, P.Name
ORDER BY Five_Star_Count DESC;


-- the product whitch has not bought yet 
SELECT 
    P.Product_ID,
    P.Name
FROM Product P
LEFT JOIN Order_Line O ON O.Product_ID = P.Product_ID
WHERE O.Order_ID IS NULL;



-- dashboard query 

SELECT
    (SELECT COUNT(*) FROM Customer) AS Total_Customers,
    (SELECT COUNT(*) FROM Product) AS Total_Products,
    (SELECT COUNT(*) FROM Order_Line) AS Total_Orders,
    (SELECT SUM(O.Quantity * P.Price)
    FROM Order_Line O JOIN Product P ON O.Product_ID = P.Product_ID) AS Total_Revenue;
