# MF Order Processing System

## Project Overview

The **MF Order Processing System** is a COBOL-based application designed to manage customer orders, item inventory, and customer details. It integrates with KSDS files and CICS maps to provide a seamless user interface for order management.

## Project Structure

The project is organized into the following components:

### 1. **Order Management**

- **Programs**:
  - `ORDERUPD.cob`: Handles order updates, including validations and KSDS updates.
  - `MENU.CBL`: Displays the main menu and invokes specific programs based on user input.
  - `INQUIRY.cob`: Displays item details in a paginated format.
  - `DETAILS.cob`: Manages customer details, including add, update, delete, and display operations.
- **BMS Maps**:
  - `ORDERUPD.BMS`: Defines the layout for the Order Update screen.
  - `MENU.BMS`: Defines the layout for the main menu screen.
  - `INQUIRY.BMS`: Defines the layout for the Item Inquiry screen.
  - `DETAILS.BMS`: Defines the layout for the Customer Details Update screen.

### 2. **KSDS Files**

- **Customer Master KSDS**:
  - `CustomerMaster.cob`: Defines the structure and logic for the Customer Master KSDS file.
  - `CreateKSDS.jcl`: JCL to create the Customer Master KSDS file.
  - `LoadKSDSRecords.jcl`: JCL to load sample records into the Customer Master KSDS file.
- **Order Transaction KSDS**:
  - `OrderTransaction.cob`: Defines the structure and logic for the Order Transaction KSDS file.
  - `CreateOrderTransactionKSDS.jcl`: JCL to create the Order Transaction KSDS file.
  - `LoadOrderTransactionRecords.jcl`: JCL to load sample records into the Order Transaction KSDS file.
- **Item Master KSDS**:
  - `ItemMaster.cob`: Defines the structure and logic for the Item Master KSDS file.
  - `CreateItemMasterKSDS.jcl`: JCL to create the Item Master KSDS file.
  - `LoadItemMasterRecords.jcl`: JCL to load sample records into the Item Master KSDS file.

### 3. **DB2 Integration**

- **SQL Scripts**:
  - `initialize_tables.sql`: Creates the DB2 tables for Customer Master, Order Transaction, and Item Master.
  - `insert_dummy_records.sql`: Inserts 10 dummy records into each DB2 table.
- **JCL**:
  - `run_scripts.jcl`: Executes the SQL scripts to initialize tables and insert dummy records.

### 4. **Documentation**

- `prompt.txt` and `prompt2.txt`: Contain the conversation history and prompts used during development.

## How Each Program Runs

### 1. **Menu Program (`MENU.CBL`)**

- **Purpose**: Displays the main menu and invokes specific programs based on user input.
- **How to Run**:
  1.  Start the program using CICS.
  2.  The menu screen will display options for:
      - Item Inquiry Program
      - Customer Details Update Program
      - Order Update Program
  3.  Use the cursor to select an option and press `ENTER`.
  4.  The selected program will be invoked.

### 2. **Item Inquiry Program (`INQUIRY.cob`)**

- **Purpose**: Displays item details in a paginated format.
- **How to Run**:
  1.  Invoked from the Menu Program.
  2.  The screen displays the first 10 records from the Item Master KSDS file.
  3.  Use the following PF keys for navigation:
      - `PF5`: Display the first 10 records.
      - `PF6`: Display the last 10 records.
      - `PF7`: Display the previous 10 records.
      - `PF8`: Display the next 10 records.
      - `PF3`: Exit to the Menu Program.

### 3. **Customer Details Program (`DETAILS.cob`)**

- **Purpose**: Manages customer details, including add, update, delete, and display operations.
- **How to Run**:
  1.  Invoked from the Menu Program.
  2.  The screen allows the following operations:
      - `ENTER`: Display customer details based on the customer number.
      - `PF4`: Add a new customer.
      - `PF5`: Update an existing customer.
      - `PF6`: Delete an existing customer.
      - `PF3`: Exit to the Menu Program.

### 4. **Order Update Program (`ORDERUPD.cob`)**

- **Purpose**: Handles order creation and updates with validations.
- **How to Run**:
  1.  Invoked from the Menu Program.
  2.  The screen allows the user to input order details, including:
      - Payment Type
      - Item Code
      - Customer Code
      - Item Quantity
  3.  The program validates the input and updates the Order Transaction KSDS file.
  4.  Use `PF3` to exit to the Menu Program.

### 5. **KSDS File Programs**

- **Customer Master KSDS**:
  - `CustomerMaster.cob`: Initializes the Customer Master KSDS file.
  - `CreateKSDS.jcl`: Creates the KSDS file.
  - `LoadKSDSRecords.jcl`: Loads sample records into the KSDS file.
- **Order Transaction KSDS**:
  - `OrderTransaction.cob`: Initializes the Order Transaction KSDS file.
  - `CreateOrderTransactionKSDS.jcl`: Creates the KSDS file.
  - `LoadOrderTransactionRecords.jcl`: Loads sample records into the KSDS file.
- **Item Master KSDS**:
  - `ItemMaster.cob`: Initializes the Item Master KSDS file.
  - `CreateItemMasterKSDS.jcl`: Creates the KSDS file.
  - `LoadItemMasterRecords.jcl`: Loads sample records into the KSDS file.

### 6. **DB2 Integration**

- **SQL Scripts**:
  - `initialize_tables.sql`: Creates the DB2 tables for Customer Master, Order Transaction, and Item Master.
  - `insert_dummy_records.sql`: Inserts 10 dummy records into each DB2 table.
- **JCL**:
  - `run_scripts.jcl`: Executes the SQL scripts to initialize tables and insert dummy records.

## Control Flow

1. **Menu Program (`MENU.CBL`)**:

   - Displays the main menu with options for Item Inquiry, Customer Details Update, and Order Update.
   - Based on user input, invokes the respective programs:
     - `INQUIRY.cob` for item inquiries.
     - `DETAILS.cob` for customer details management.
     - `ORDERUPD.cob` for order updates.

2. **Item Inquiry Program (`INQUIRY.cob`)**:

   - Displays item details in a paginated format.
   - Supports navigation through records using PF keys (PF5, PF6, PF7, PF8).

3. **Customer Details Program (`DETAILS.cob`)**:

   - Allows adding, updating, deleting, and displaying customer details.
   - Validates input and interacts with the Customer Master KSDS file.

4. **Order Update Program (`ORDERUPD.cob`)**:

   - Handles order creation and updates.
   - Validates item availability and customer details before processing orders.

5. **KSDS and DB2 Integration**:
   - KSDS files store data for Customer Master, Order Transaction, and Item Master.
   - DB2 tables mirror the KSDS structure for database operations.

## Key Features

- **CICS Integration**: Provides a user-friendly interface for interacting with KSDS files.
- **Data Validation**: Ensures data integrity during CRUD operations.
- **Modular Design**: Each program handles a specific functionality, ensuring maintainability.

## How to Run

1. Use the provided JCL scripts to create and load KSDS files.
2. Execute the `MENU.CBL` program to start the application.
3. Navigate through the menu to access specific functionalities.

## Future Enhancements

- Add reporting features for order summaries.
- Integrate additional payment methods.
- Enhance error handling and logging mechanisms.
