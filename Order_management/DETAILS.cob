IDENTIFICATION DIVISION.
PROGRAM-ID. DETAILS.

* This program manages customer details, including add, update, delete, and display operations.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT CustomerFile ASSIGN TO "Customer.Master.KSDS"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS RANDOM
        RECORD KEY IS Customer-Code
        FILE STATUS IS WS-File-Status.

DATA DIVISION.
FILE SECTION.
FD  CustomerFile.
01  Customer-Record.
    05  Customer-Code          PIC 9(07).
    05  Customer-Name          PIC X(15).
    05  Customer-Add           PIC X(12).
    05  Customer-Region        PIC X(03).
    05  Customer-Contact-No    PIC X(10).
    05  Customer-Email         PIC X(40).

WORKING-STORAGE SECTION.
01  WS-File-Status             PIC X(02).
01  WS-MESSAGE                 PIC X(50).
01  WS-CURSOR-POSITION         PIC 9(4).

PROCEDURE DIVISION.
MAIN-PARA.
    * Receive user input and process based on PF keys
    EXEC CICS RECEIVE MAP('DETAILMAP') MAPSET('DETAILS') END-EXEC.

    EVALUATE TRUE
        WHEN EIBAID = DFHENTER
            * Process customer number to display details
            PERFORM PROCESS-CUST-NO
        WHEN EIBAID = DFHPF3
            * Exit to the menu program
            MOVE "EXITING TO MENU..." TO WS-MESSAGE
            EXEC CICS SEND TEXT FROM(WS-MESSAGE) END-EXEC
            EXEC CICS RETURN END-EXEC
        WHEN EIBAID = DFHPF4
            * Add a new customer
            PERFORM ADD-CUSTOMER
        WHEN EIBAID = DFHPF5
            * Update an existing customer
            PERFORM UPDATE-CUSTOMER
        WHEN EIBAID = DFHPF6
            * Delete an existing customer
            PERFORM DELETE-CUSTOMER
        WHEN OTHER
            * Handle invalid PF keys
            MOVE "INVALID PF KEY" TO WS-MESSAGE
            EXEC CICS SEND TEXT FROM(WS-MESSAGE) END-EXEC
    END-EVALUATE.

    EXEC CICS RETURN END-EXEC.

PROCESS-CUST-NO.
    * Read and display customer details based on customer number
    READ CustomerFile KEY IS Customer-Code
        INVALID KEY
            MOVE "CUSTOMER NOT FOUND" TO WS-MESSAGE
            EXEC CICS SEND TEXT FROM(WS-MESSAGE) END-EXEC
        NOT INVALID KEY
            MOVE "CUSTOMER DETAILS DISPLAYED" TO WS-MESSAGE
            EXEC CICS SEND TEXT FROM(WS-MESSAGE) END-EXEC.

ADD-CUSTOMER.
    * Validate and add a new customer record
    EXEC CICS RECEIVE MAP('DETAILMAP') MAPSET('DETAILS') END-EXEC.
    MOVE Customer-Code TO Customer-Record.
    WRITE CustomerFile FROM Customer-Record
        INVALID KEY
            MOVE "CUSTOMER ADD FAILED" TO WS-MESSAGE
            EXEC CICS SEND TEXT FROM(WS-MESSAGE) END-EXEC
        NOT INVALID KEY
            MOVE "CUSTOMER ADDED SUCCESSFULLY" TO WS-MESSAGE
            EXEC CICS SEND TEXT FROM(WS-MESSAGE) END-EXEC.

UPDATE-CUSTOMER.
    * Validate and update an existing customer record
    READ CustomerFile KEY IS Customer-Code
        INVALID KEY
            MOVE "CUSTOMER NOT FOUND" TO WS-MESSAGE
            EXEC CICS SEND TEXT FROM(WS-MESSAGE) END-EXEC
        NOT INVALID KEY
            EXEC CICS RECEIVE MAP('DETAILMAP') MAPSET('DETAILS') END-EXEC.
            MOVE Customer-Name TO Customer-Record.
            REWRITE CustomerFile FROM Customer-Record
                INVALID KEY
                    MOVE "CUSTOMER UPDATE FAILED" TO WS-MESSAGE
                    EXEC CICS SEND TEXT FROM(WS-MESSAGE) END-EXEC
                NOT INVALID KEY
                    MOVE "CUSTOMER UPDATED SUCCESSFULLY" TO WS-MESSAGE
                    EXEC CICS SEND TEXT FROM(WS-MESSAGE) END-EXEC.

DELETE-CUSTOMER.
    * Delete an existing customer record
    READ CustomerFile KEY IS Customer-Code
        INVALID KEY
            MOVE "CUSTOMER NOT FOUND" TO WS-MESSAGE
            EXEC CICS SEND TEXT FROM(WS-MESSAGE) END-EXEC
        NOT INVALID KEY
            DELETE CustomerFile
                INVALID KEY
                    MOVE "CUSTOMER DELETE FAILED" TO WS-MESSAGE
                    EXEC CICS SEND TEXT FROM(WS-MESSAGE) END-EXEC
                NOT INVALID KEY
                    MOVE "CUSTOMER DELETED SUCCESSFULLY" TO WS-MESSAGE
                    EXEC CICS SEND TEXT FROM(WS-MESSAGE) END-EXEC.