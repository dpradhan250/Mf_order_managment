-- Insert dummy records into Customer Master File
INSERT INTO CustomerMaster VALUES ('0000001', 'John Doe', 'Address1', 'MUM', '1234567890', 'john@example.com');
INSERT INTO CustomerMaster VALUES ('0000002', 'Jane Smith', 'Address2', 'DEL', '0987654321', 'jane@example.com');
INSERT INTO CustomerMaster VALUES ('0000003', 'Alice Brown', 'Address3', 'BNG', '1122334455', 'alice@example.com');
INSERT INTO CustomerMaster VALUES ('0000004', 'Bob White', 'Address4', 'CHE', '2233445566', 'bob@example.com');
INSERT INTO CustomerMaster VALUES ('0000005', 'Charlie Black', 'Address5', 'HYD', '3344556677', 'charlie@example.com');
INSERT INTO CustomerMaster VALUES ('0000006', 'David Green', 'Address6', 'MUM', '4455667788', 'david@example.com');
INSERT INTO CustomerMaster VALUES ('0000007', 'Eve Blue', 'Address7', 'DEL', '5566778899', 'eve@example.com');
INSERT INTO CustomerMaster VALUES ('0000008', 'Frank Yellow', 'Address8', 'BNG', '6677889900', 'frank@example.com');
INSERT INTO CustomerMaster VALUES ('0000009', 'Grace Red', 'Address9', 'CHE', '7788990011', 'grace@example.com');
INSERT INTO CustomerMaster VALUES ('0000010', 'Hank Purple', 'Address10', 'HYD', '8899001122', 'hank@example.com');

-- Insert dummy records into Order Transaction File
INSERT INTO OrderTransaction VALUES ('0000001', '0000001', '0000001', 10, '20231001');
INSERT INTO OrderTransaction VALUES ('0000002', '0000002', '0000002', 5, '20231002');
INSERT INTO OrderTransaction VALUES ('0000003', '0000003', '0000003', 15, '20231003');
INSERT INTO OrderTransaction VALUES ('0000004', '0000004', '0000004', 20, '20231004');
INSERT INTO OrderTransaction VALUES ('0000005', '0000005', '0000005', 25, '20231005');
INSERT INTO OrderTransaction VALUES ('0000006', '0000006', '0000006', 30, '20231006');
INSERT INTO OrderTransaction VALUES ('0000007', '0000007', '0000007', 35, '20231007');
INSERT INTO OrderTransaction VALUES ('0000008', '0000008', '0000008', 40, '20231008');
INSERT INTO OrderTransaction VALUES ('0000009', '0000009', '0000009', 45, '20231009');
INSERT INTO OrderTransaction VALUES ('0000010', '0000010', '0000010', 50, '20231010');

-- Insert dummy records into Item Master File
INSERT INTO ItemMaster VALUES ('0000001', 'Item1', 100, 50.75);
INSERT INTO ItemMaster VALUES ('0000002', 'Item2', 200, 30.50);
INSERT INTO ItemMaster VALUES ('0000003', 'Item3', 300, 20.25);
INSERT INTO ItemMaster VALUES ('0000004', 'Item4', 400, 10.00);
INSERT INTO ItemMaster VALUES ('0000005', 'Item5', 500, 15.75);
INSERT INTO ItemMaster VALUES ('0000006', 'Item6', 600, 25.50);
INSERT INTO ItemMaster VALUES ('0000007', 'Item7', 700, 35.25);
INSERT INTO ItemMaster VALUES ('0000008', 'Item8', 800, 45.00);
INSERT INTO ItemMaster VALUES ('0000009', 'Item9', 900, 55.75);
INSERT INTO ItemMaster VALUES ('0000010', 'Item10', 1000, 65.50);
