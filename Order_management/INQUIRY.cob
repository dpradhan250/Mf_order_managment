IDENTIFICATION DIVISION.
PROGRAM-ID. INQUIRY.

* This program handles item inquiries and displays item details in a paginated format.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT ItemFile ASSIGN TO "Item.Master.KSDS"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS RANDOM
        RECORD KEY IS Item-Code
        FILE STATUS IS WS-File-Status.

DATA DIVISION.
FILE SECTION.
FD  ItemFile.
01  Item-Record.
    05  Item-Code           PIC 9(07).
    05  Item-Name           PIC X(15).
    05  Item-Qty            PIC 9(05).

WORKING-STORAGE SECTION.
01  WS-File-Status         PIC X(02).
01  WS-DATE                PIC X(11).
01  WS-TIME                PIC X(08).
01  WS-CURSOR-POSITION     PIC 9(4).
01  WS-MESSAGE             PIC X(50).
01  WS-ITEMS               OCCURS 10 TIMES.
    05  WS-ITEM-NO         PIC 9(07).
    05  WS-ITEM-NAME       PIC X(15).
    05  WS-ITEM-QTY        PIC 9(05).

PROCEDURE DIVISION.
MAIN-PARA.
    * Initialize the program and display the header
    DISPLAY "INQUIRY Program Initialized".
    PERFORM DISPLAY-HEADER.
    PERFORM DISPLAY-FIRST-10.

    * Receive user input and process based on PF keys
    EXEC CICS RECEIVE MAP('INQUIRY') MAPSET('INQMAP') END-EXEC.
    EVALUATE TRUE
        WHEN EIBAID = DFHPF3
            * Exit to the menu program
            MOVE "EXITING TO MENU..." TO WS-MESSAGE
            EXEC CICS SEND TEXT FROM(WS-MESSAGE) END-EXEC
            EXEC CICS RETURN END-EXEC
        WHEN EIBAID = DFHPF5
            * Display the first 10 records
            PERFORM DISPLAY-FIRST-10
        WHEN EIBAID = DFHPF6
            * Display the last 10 records
            PERFORM DISPLAY-LAST-10
        WHEN EIBAID = DFHPF7
            * Display the previous 10 records
            PERFORM DISPLAY-PREV-10
        WHEN EIBAID = DFHPF8
            * Display the next 10 records
            PERFORM DISPLAY-NEXT-10
        WHEN OTHER
            * Handle invalid PF keys
            MOVE "INVALID PF KEY" TO WS-MESSAGE
            EXEC CICS SEND TEXT FROM(WS-MESSAGE) END-EXEC
    END-EVALUATE.

    EXEC CICS RETURN END-EXEC.

DISPLAY-HEADER.
    * Display the header with current date and time
    MOVE FUNCTION CURRENT-DATE TO WS-DATE.
    MOVE FUNCTION CURRENT-TIME TO WS-TIME.
    EXEC CICS SEND MAP('INQUIRY') MAPSET('INQMAP') END-EXEC.

DISPLAY-FIRST-10.
    * Logic to display the first 10 records
    PERFORM READ-ITEMS FROM 1 TO 10.

DISPLAY-LAST-10.
    * Logic to display the last 10 records
    PERFORM READ-ITEMS FROM 91 TO 100.

DISPLAY-PREV-10.
    * Logic to display the previous 10 records
    PERFORM READ-ITEMS FROM WS-CURSOR-POSITION - 10 TO WS-CURSOR-POSITION.

DISPLAY-NEXT-10.
    * Logic to display the next 10 records
    PERFORM READ-ITEMS FROM WS-CURSOR-POSITION + 1 TO WS-CURSOR-POSITION.

READ-ITEMS.
    * Read and display items from the KSDS file
    PERFORM VARYING WS-INDEX FROM START TO END
        READ ItemFile INTO WS-ITEMS(WS-INDEX)
        AT END MOVE "NO MORE RECORDS" TO WS-MESSAGE
    END-PERFORM.