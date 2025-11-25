--إجمالي الإنفاق لكل عميل
SELECT 
    c.Customer_ID,
    c.First_Name + ' ' + c.Last_Name AS Customer_Name,
    SUM(p.Price * o.Quantity) AS Total_Spent
FROM Customer c
JOIN Cart ca ON c.Customer_ID = ca.Customer_ID
JOIN Order_Line o ON ca.Cart_ID = o.Cart_ID
JOIN Product p ON o.Product_ID = p.Product_ID
GROUP BY c.Customer_ID, c.First_Name, c.Last_Name
ORDER BY Total_Spent DESC;


--متوسط الإنفاق لكل فئة

SELECT 
    cat.Category_Name,
    AVG(p.Price * o.Quantity) AS Avg_Spend_Per_Order
FROM Order_Line o
JOIN Product p ON o.Product_ID = p.Product_ID
JOIN Categories cat ON p.Categories_ID = cat.Categories_ID
GROUP BY cat.Category_Name
ORDER BY Avg_Spend_Per_Order DESC;


-- أكثر المنتجات مبيعًا
SELECT 
    p.Name AS Product_Name,
    SUM(o.Quantity) AS Total_Sold
FROM Order_Line o
JOIN Product p ON o.Product_ID = p.Product_ID
GROUP BY p.Name
ORDER BY Total_Sold DESC




--المنتجات التي على وشك النفاد


SELECT 
    p.Name,
    p.Quantity AS Stock_Inventory,
    SUM(o.Quantity) AS Sold_Quantity,
    p.Quantity - SUM(o.Quantity) AS Remaining_Stock
FROM Product p
LEFT JOIN Order_Line o ON p.Product_ID = o.Product_ID
GROUP BY p.Product_ID, p.Name, p.Quantity
ORDER BY Remaining_Stock ASC;


-- طلبات تصنيف معنين
SELECT 
    c.Customer_ID,
    c.First_Name,
    c.Last_Name
FROM Customer c
WHERE EXISTS (
    SELECT 1
    FROM Orders o
    JOIN OrderItem oi ON oi.Order_ID = o.Order_ID
    JOIN Product p ON p.Product_ID = oi.Product_ID
    JOIN Category cat ON cat.Category_ID = p.Category_ID
    WHERE o.Customer_ID = c.Customer_ID
      AND cat.Category_Name = 'Laptops'
);
