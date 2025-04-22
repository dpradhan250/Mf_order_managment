IDENTIFICATION DIVISION.
PROGRAM-ID. ORDERUPD.

* This program handles order updates with validations and KSDS updates.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT OrderFile ASSIGN TO "Order.Transaction.KSDS"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS RANDOM
        RECORD KEY IS Order-Code
        FILE STATUS IS WS-File-Status.

    SELECT ItemFile ASSIGN TO "Item.Master.KSDS"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS RANDOM
        RECORD KEY IS Item-Code
        FILE STATUS IS WS-File-Status.

    SELECT CustomerFile ASSIGN TO "Customer.Master.KSDS"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS RANDOM
        RECORD KEY IS Customer-Code
        FILE STATUS IS WS-File-Status.

DATA DIVISION.
FILE SECTION.
FD  OrderFile.
01  Order-Record.
    05  Order-Code          PIC 9(07).
    05  Customer-Code       PIC 9(07).
    05  Item-Code           PIC 9(07).
    05  Item-Qty            PIC 9(05).
    05  Order-Date          PIC X(08).
    05  Payment-Type        PIC X(03).

FD  ItemFile.
01  Item-Record.
    05  Item-Code           PIC 9(07).
    05  Item-Name           PIC X(12).
    05  Item-Qty            PIC 9(05).
    05  Item-Price          PIC 9(05)V9(02).

FD  CustomerFile.
01  Customer-Record.
    05  Customer-Code       PIC 9(07).
    05  Customer-Name       PIC X(15).
    05  Customer-Add        PIC X(12).
    05  Customer-Region     PIC X(03).
    05  Customer-Contact-No PIC X(10).
    05  Customer-Email      PIC X(40).

WORKING-STORAGE SECTION.
01  WS-File-Status         PIC X(02).
01  WS-DATE                PIC X(11).
01  WS-TIME                PIC X(08).
01  WS-MESSAGE             PIC X(50).
01  WS-CURSOR-POSITION     PIC 9(4).
01  WS-ORDER-CODE          PIC 9(07) VALUE ZEROS.

PROCEDURE DIVISION.
MAIN-PARA.
    * Initialize the program
    DISPLAY "ORDER UPDATE Program Initialized".
    PERFORM DISPLAY-HEADER.

    * Receive user input
    EXEC CICS RECEIVE MAP('ORDERUPD') MAPSET('ORDERMAP') END-EXEC.

    * Process user input
    EVALUATE TRUE
        WHEN EIBAID = DFHPF3
            * Exit to the menu program
            MOVE "EXITING TO MENU..." TO WS-MESSAGE
            EXEC CICS SEND TEXT FROM(WS-MESSAGE) END-EXEC
            EXEC CICS RETURN END-EXEC
        WHEN EIBAID = DFHENTER
            PERFORM VALIDATE-INPUT
        WHEN OTHER
            * Handle invalid PF keys
            MOVE "INVALID PF KEY" TO WS-MESSAGE
            EXEC CICS SEND TEXT FROM(WS-MESSAGE) END-EXEC
    END-EVALUATE.

    EXEC CICS RETURN END-EXEC.

DISPLAY-HEADER.
    * Display the header with date and time
    MOVE FUNCTION CURRENT-DATE TO WS-DATE.
    MOVE FUNCTION CURRENT-TIME TO WS-TIME.
    EXEC CICS SEND MAP('ORDERUPD') MAPSET('ORDERMAP') END-EXEC.

VALIDATE-INPUT.
    * Validate payment type
    IF Payment-Type NOT IN ("COD", "NET")
        MOVE "INVALID PAYMENT TYPE" TO WS-MESSAGE
        EXEC CICS SEND TEXT FROM(WS-MESSAGE) CURSOR(WS-CURSOR-POSITION) END-EXEC
        RETURN.

    * Validate item code
    READ ItemFile KEY IS Item-Code
        INVALID KEY
            MOVE "INVALID ITEM CODE" TO WS-MESSAGE
            EXEC CICS SEND TEXT FROM(WS-MESSAGE) CURSOR(WS-CURSOR-POSITION) END-EXEC
            RETURN.

    * Validate customer code
    READ CustomerFile KEY IS Customer-Code
        INVALID KEY
            MOVE "INVALID CUSTOMER CODE" TO WS-MESSAGE
            EXEC CICS SEND TEXT FROM(WS-MESSAGE) CURSOR(WS-CURSOR-POSITION) END-EXEC
            RETURN.

    * Validate item quantity
    IF Item-Qty > Item-Record.Item-Qty
        MOVE "INSUFFICIENT STOCK" TO WS-MESSAGE
        EXEC CICS SEND TEXT FROM(WS-MESSAGE) CURSOR(WS-CURSOR-POSITION) END-EXEC
        RETURN.

    * Insert new order record
    ADD 1 TO WS-ORDER-CODE.
    MOVE WS-ORDER-CODE TO Order-Code.
    MOVE FUNCTION CURRENT-DATE TO Order-Date.
    WRITE OrderFile FROM Order-Record
        INVALID KEY
            MOVE "ORDER CREATION FAILED" TO WS-MESSAGE
            EXEC CICS SEND TEXT FROM(WS-MESSAGE) END-EXEC
        NOT INVALID KEY
            MOVE "ORDER CREATED SUCCESSFULLY" TO WS-MESSAGE
            EXEC CICS SEND TEXT FROM(WS-MESSAGE) END-EXEC.