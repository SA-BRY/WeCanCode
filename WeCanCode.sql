/* ===== إعادة تهيئة القاعدة ===== */

CREATE DATABASE ElectronicsShop;
GO
USE ElectronicsShop;
GO

/* ===== الجداول (مطابقة للمخطط) ===== */
CREATE TABLE Customer (
    Customer_ID INT IDENTITY PRIMARY KEY,
    First_Name NVARCHAR(50),
    Last_Name  NVARCHAR(50),
    User_Name  NVARCHAR(50) UNIQUE,
    Email      NVARCHAR(100) UNIQUE,
    Address    NVARCHAR(200),
    Phone      NVARCHAR(20),
    Password   NVARCHAR(100)
);

CREATE TABLE Cart (
    Cart_ID INT IDENTITY PRIMARY KEY,
    Customer_ID INT NOT NULL FOREIGN KEY REFERENCES Customer(Customer_ID),
    Created_At DATETIME NOT NULL DEFAULT GETDATE(),
    Number_Of_Items INT NOT NULL DEFAULT 0
);

CREATE TABLE Categories (
    Categories_ID INT IDENTITY PRIMARY KEY,
    Category_Name NVARCHAR(100) NOT NULL
);

CREATE TABLE Inventory (
    Inventory_ID INT IDENTITY PRIMARY KEY,
    Location NVARCHAR(100) NOT NULL,
    Quantity INT NOT NULL
);

CREATE TABLE Product (
    Product_ID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Description NVARCHAR(255),
    Quantity INT NOT NULL,
    Categories_ID INT NOT NULL FOREIGN KEY REFERENCES Categories(Categories_ID),
    Inventory_ID  INT NOT NULL FOREIGN KEY REFERENCES Inventory(Inventory_ID)
);

CREATE TABLE Order_Line (
    Order_ID INT IDENTITY PRIMARY KEY,
    Cart_ID INT NOT NULL FOREIGN KEY REFERENCES Cart(Cart_ID),
    [Date] DATETIME NOT NULL DEFAULT GETDATE(),
    Status NVARCHAR(50) NOT NULL,
    Quantity INT NOT NULL,
    Product_ID INT NOT NULL FOREIGN KEY REFERENCES Product(Product_ID),
    Receiver_Name NVARCHAR(100) NOT NULL,
    Receiver_Address NVARCHAR(200) NOT NULL
);

CREATE TABLE Payment (
    Payment_ID INT IDENTITY PRIMARY KEY,
    [Method] NVARCHAR(50) NOT NULL,
    Card_Number NVARCHAR(30) NULL,
    [Date] DATETIME NOT NULL DEFAULT GETDATE(),
    Cart_ID INT NOT NULL FOREIGN KEY REFERENCES Cart(Cart_ID)
);

CREATE TABLE Shipment_Company (
    Shipment_ID INT IDENTITY PRIMARY KEY,
    [Name] NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100),
    Location NVARCHAR(100)
);

CREATE TABLE Shipping (
    Shipping_ID INT IDENTITY PRIMARY KEY,
    Cart_ID INT NOT NULL FOREIGN KEY REFERENCES Cart(Cart_ID),
    Shipment_ID INT NOT NULL FOREIGN KEY REFERENCES Shipment_Company(Shipment_ID),
    Ship_Date DATETIME NOT NULL,
    Receiver_Name NVARCHAR(100) NOT NULL,
    Receiver_Address NVARCHAR(200) NOT NULL
);

CREATE TABLE Review (
    Customer_ID INT NOT NULL FOREIGN KEY REFERENCES Customer(Customer_ID),
    Product_ID  INT NOT NULL FOREIGN KEY REFERENCES Product(Product_ID),
    Rate INT NOT NULL CHECK (Rate BETWEEN 1 AND 5),
    [Date] DATETIME NOT NULL DEFAULT GETDATE(),
    Description NVARCHAR(255),
    CONSTRAINT PK_Review PRIMARY KEY (Customer_ID, Product_ID)
);

/* ===== بيانات العملاء ===== */
INSERT INTO Customer (First_Name, Last_Name, User_Name, Email, Address, Phone, Password) VALUES
('Ali','Salem','ali01','ali@shop.ly','Benghazi','0911111111','pass1'),
('Sara','Khaled','sara02','sara@shop.ly','Tripoli','0922222222','pass2'),
('Omar','Nasr','omar03','omar@shop.ly','Misrata','0933333333','pass3'),
('Fatma','Ahmad','fatma04','fatma@shop.ly','Tripoli','0944444444','pass4'),
('Yousef','Hamid','you05','you@shop.ly','Sabha','0955555555','pass5'),
('Nour','Ali','nour06','nour@shop.ly','Benghazi','0966666666','pass6'),
('Hassan','Fathi','hass07','hassan@shop.ly','Tripoli','0977777777','pass7'),
('Aya','Rami','aya08','aya@shop.ly','Misrata','0988888888','pass8'),
('Bilal','Rashid','bilal09','bilal@shop.ly','Tripoli','0999999999','pass9'),
('Huda','Mansour','huda10','huda@shop.ly','Sabha','0910000000','pass10'),
('Othman','Said','oth11','othman@shop.ly','Tripoli','0920101010','pass11'),
('Lina','Hassan','lina12','lina@shop.ly','Benghazi','0930202020','pass12'),
('Majd','Rami','majd13','majd@shop.ly','Misrata','0940303030','pass13'),
('Salma','Faraj','sal14','salma@shop.ly','Tripoli','0950404040','pass14'),
('Adel','Hadi','adel15','adel@shop.ly','Benghazi','0960505050','pass15');

/* ===== الفئات ===== */
INSERT INTO Categories (Category_Name) VALUES
('Laptops'),('Smartphones'),('Accessories'),('Gaming'),('Audio Devices'),('Home Appliances');

/* ===== المخزون ===== */
INSERT INTO Inventory (Location, Quantity) VALUES
('Warehouse A',500),('Warehouse B',400),('Warehouse C',350);

/* ===== المنتجات (60 منتج متنوع) ===== */
INSERT INTO Product (Name, Price, Description, Quantity, Categories_ID, Inventory_ID) VALUES
-- Laptops (1..10)
('MacBook Air M2',1550,'Apple 13-inch, 8GB, 256GB SSD',25,1,1),
('Dell XPS 13',1350,'Intel i7, 16GB, 512GB SSD',20,1,1),
('HP Spectre x360',1280,'2-in-1 Touch, 16GB, 512GB',15,1,2),
('Lenovo Legion 5',1450,'Ryzen 7, RTX4060, 16GB',30,1,1),
('Acer Aspire 7',980,'i5 12th Gen, GTX1650',40,1,3),
('Asus Vivobook 15',890,'i5, 8GB RAM, 512GB SSD',35,1,2),
('MSI GF63 Thin',1100,'i7, RTX3050',18,1,3),
('Razer Blade 15',2100,'RTX4070, 32GB RAM',12,1,1),
('Microsoft Surface 9',1700,'Touch 13"" i7, 16GB',10,1,1),
('Samsung Galaxy Book4',1250,'Intel i7 Evo',16,1,2),
-- Smartphones (11..20)
('iPhone 15 Pro',1199,'Titanium, 256GB',30,2,1),
('Samsung Galaxy S24',1090,'512GB, Snapdragon 8 Gen 3',45,2,2),
('Google Pixel 8',899,'128GB, Tensor G3',22,2,3),
('Xiaomi 14 Ultra',1050,'Leica Optics, 1TB',25,2,3),
('OnePlus 12',999,'Snapdragon 8 Gen 3, 16GB',20,2,1),
('Huawei P60 Pro',950,'Quad Lens, 5G',18,2,2),
('Realme GT5',850,'16GB RAM, 240W Charge',26,2,3),
('Oppo Find X7',930,'Periscope Zoom',30,2,1),
('Vivo X100 Pro',940,'Zeiss Lens, 512GB',27,2,1),
('Nothing Phone 2',750,'Glyph, 256GB',40,2,2),
-- Accessories (21..30)
('Logitech MX Master 3S',99,'Ergonomic Mouse',100,3,1),
('Razer BlackWidow V4',169,'Mechanical Keyboard',60,3,1),
('Anker Power Bank 20K',49,'USB-C PD 45W',200,3,3),
('Belkin Dock Station',120,'11-in-1 USB-C Hub',80,3,2),
('Apple AirPods Pro 2',249,'ANC, Wireless',60,3,1),
('Baseus GaN Charger',39,'65W Fast Charging',180,3,3),
('Ugreen USB-C Cable',15,'1m Braided',250,3,1),
('Logitech Brio 4K',190,'Ultra HD Webcam',70,3,2),
('Kingston 1TB SSD',75,'NVMe Gen4 M.2',90,3,2),
('Samsung T7 2TB',165,'Portable SSD',50,3,1),
-- Gaming (31..40)
('Sony PS5',680,'Blu-ray Edition 1TB',35,4,1),
('Xbox Series X',620,'1TB SSD',40,4,2),
('Nintendo Switch OLED',420,'Neon JoyCon',30,4,3),
('Razer Kraken V3',130,'Surround Sound',90,4,1),
('Elgato Stream Deck',199,'15 Keys',55,4,1),
('HyperX Cloud III',150,'Comfort Headset',75,4,2),
('SteelSeries Arctis 7+',180,'Wireless 7.1',70,4,2),
('Razer Basilisk V3',99,'RGB Gaming Mouse',100,4,3),
('Logitech G Pro Keyboard',140,'Mechanical TKL',80,4,3),
('Corsair K70 RGB',180,'MX Red',60,4,1),
-- Audio Devices (41..50)
('Sony WH-1000XM5',380,'Noise Cancelling',40,5,1),
('Bose QC45',360,'Comfort Wireless',35,5,2),
('JBL Flip 6',120,'Portable BT Speaker',120,5,3),
('Marshall Emberton II',170,'Compact Speaker',100,5,2),
('Apple HomePod Mini',99,'Smart Speaker',150,5,1),
('Harman Kardon Onyx 7',250,'Luxury Speaker',80,5,2),
('Sennheiser HD660S',500,'Open Back',25,5,1),
('Anker Soundcore 3',70,'Budget BT Speaker',200,5,3),
('Sony WF-1000XM5',260,'TWS Earbuds ANC',90,5,1),
('JBL Tune 510BT',65,'Wireless Headphones',180,5,2),
-- Home Appliances (51..60)
('LG OLED 55""',1200,'4K Smart TV',25,6,1),
('Samsung QLED 65""',1450,'HDR10+ Display',18,6,2),
('Philips Air Fryer XL',230,'Digital Display',40,6,3),
('Dyson V15 Detect',799,'Cordless Vacuum',20,6,2),
('Moulinex Blender',120,'Glass Jar 2L',50,6,3),
('Xiaomi Smart TV 43""',499,'Android TV 4K',30,6,1),
('Toshiba Washing 9KG',650,'Smart Wash',15,6,2),
('Panasonic Microwave',180,'30L Grill',40,6,3),
('Kenwood Mixer 1000W',210,'5L Bowl',30,6,1),
('Philips Iron Steam',90,'2400W Steam',70,6,3);

/* ===== السلال ===== */
INSERT INTO Cart (Customer_ID, Number_Of_Items) VALUES
(1,5),(2,3),(3,2),(4,6),(5,1),(6,4),(7,5),
(8,2),(9,3),(10,2),(11,4),(12,3),(13,5),(14,2),(15,6);

/* ===== الطلبات (كلها تشير لمنتجات ضمن المدى 1..60) ===== */
INSERT INTO Order_Line (Cart_ID, Status, Quantity, Product_ID, Receiver_Name, Receiver_Address) VALUES
(1,'Processing',1,1,'Ali Salem','Benghazi'),
(1,'Processing',1,11,'Ali Salem','Benghazi'),
(2,'Shipped'   ,2,21,'Sara Khaled','Tripoli'),
(3,'Delivered' ,1,31,'Omar Nasr','Misrata'),
(4,'Delivered' ,1,41,'Fatma Ahmad','Tripoli'),
(5,'Pending'   ,1,51,'Yousef Hamid','Sabha'),
(6,'Shipped'   ,2,61-1,'Nour Ali','Benghazi'),      -- 60 بدّلنا 61-1 لضمان النطاق
(7,'Processing',1,32,'Hassan Fathi','Tripoli'),
(8,'Pending'   ,1,42,'Aya Rami','Misrata'),
(9,'Processing',1,52,'Bilal Rashid','Tripoli'),
(10,'Delivered',1,10,'Huda Mansour','Sabha'),
(11,'Delivered',1,20,'Othman Said','Tripoli'),
(12,'Pending'  ,1,30,'Lina Hassan','Benghazi'),
(13,'Shipped'  ,2,40,'Majd Rami','Misrata'),
(14,'Processing',1,50,'Salma Faraj','Tripoli'),
(15,'Processing',1,60,'Adel Hadi','Benghazi'),
(1,'Delivered' ,1,30,'Ali Salem','Benghazi'),
(2,'Delivered' ,1,40,'Sara Khaled','Tripoli'),
(3,'Pending'   ,1,50,'Omar Nasr','Misrata'),
(4,'Delivered' ,1,60,'Fatma Ahmad','Tripoli');

/* ===== المدفوعات ===== */
INSERT INTO Payment ([Method], Card_Number, Cart_ID) VALUES
('Credit Card','4111111111111111',1),
('Debit Card','5222333444555666',2),
('PayPal','paypal_tx_4455',3),
('Cash On Delivery',NULL,4),
('Credit Card','4789567812345678',5),
('Visa','4000000000000002',6),
('MasterCard','5555555555554444',7),
('PayPal','paypal_tx_5566',8),
('Credit Card','4916010000000000',9),
('Cash On Delivery',NULL,10);

/* ===== شركات الشحن + الشحن ===== */
INSERT INTO Shipment_Company ([Name], Email, Location) VALUES
('FastShip Express','support@fastship.ly','Tripoli'),
('LibyaPost','info@libyapost.ly','Benghazi'),
('QuickSend','sales@quicksend.ly','Misrata'),
('GoFast','hello@gofast.ly','Sabha');

INSERT INTO Shipping (Cart_ID, Shipment_ID, Ship_Date, Receiver_Name, Receiver_Address) VALUES
(1,1,GETDATE(),'Ali Salem','Benghazi'),
(2,2,GETDATE(),'Sara Khaled','Tripoli'),
(3,3,GETDATE(),'Omar Nasr','Misrata'),
(4,1,GETDATE(),'Fatma Ahmad','Tripoli'),
(5,4,GETDATE(),'Yousef Hamid','Sabha');

/* ===== التقييمات (كلها ضمن منتجات 1..60) ===== */
INSERT INTO Review (Customer_ID, Product_ID, Rate, Description) VALUES
(1,1,5,'Super fast laptop.'),
(1,11,4,'iPhone great but expensive.'),
(2,21,5,'Mouse feels premium.'),
(3,31,5,'PS5 amazing.'),
(4,41,4,'Sound quality strong.'),
(5,51,5,'TV has vivid colors.'),
(6,46,4,'Nice earbuds ANC.'),
(7,40,5,'Keyboard is top-notch.'),
(8,30,4,'Webcam is good overall.'),
(9,20,5,'Phone is very smooth.'),
(10,10,4,'Display sharp, battery average.'),
(11,25,5,'Power bank is perfect.'),
(12,35,4,'Headset comfy for long use.'),
(13,45,5,'Speaker fills the room.'),
(14,55,5,'Appliance quality is great.');
