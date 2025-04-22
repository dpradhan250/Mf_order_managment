-- Create Customer Master File
CREATE TABLE CustomerMaster (
    CustomerCode CHAR(7) PRIMARY KEY,
    CustomerName CHAR(15),
    CustomerAdd CHAR(12),
    CustomerRegion CHAR(3),
    CustomerContactNo CHAR(10),
    CustomerEmail CHAR(40)
);

-- Create Order Transaction File
CREATE TABLE OrderTransaction (
    OrderCode CHAR(7) PRIMARY KEY,
    CustomerCode CHAR(7),
    ItemCode CHAR(7),
    ItemQty INT,
    OrderDate CHAR(8),
    FOREIGN KEY (CustomerCode) REFERENCES CustomerMaster(CustomerCode),
    FOREIGN KEY (ItemCode) REFERENCES ItemMaster(ItemCode)
);

-- Create Item Master File
CREATE TABLE ItemMaster (
    ItemCode CHAR(7) PRIMARY KEY,
    ItemName CHAR(12),
    ItemQty INT,
    ItemPrice DECIMAL(7, 2)
);
