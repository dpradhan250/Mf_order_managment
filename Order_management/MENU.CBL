* This program handles the main menu and invokes specific programs based on user input.

IDENTIFICATION DIVISION.
PROGRAM-ID. MENU.

* This program displays a menu screen and processes user input to invoke specific programs.

ENVIRONMENT DIVISION.
DATA DIVISION.
WORKING-STORAGE SECTION.

* Variables for cursor position and messages
01 WS-CURSOR-POSITION PIC 9(4).
01 WS-MESSAGE PIC X(50) VALUE SPACES.

EXEC CICS DSECT=YES END-EXEC.

PROCEDURE DIVISION.
MAIN-PARA.
    * Receive user input from the menu screen
    EXEC CICS RECEIVE MAP('MENU') MAPSET('MENUSET') END-EXEC.

    * Process user input based on PF keys or cursor position
    IF EIBAID = DFHPF3
        * Exit the program and return control to CICS
        MOVE "EXITING TO CICS..." TO WS-MESSAGE
        EXEC CICS SEND TEXT FROM(WS-MESSAGE) END-EXEC
        EXEC CICS RETURN END-EXEC
    ELSE IF EIBAID = DFHENTER
        * Determine the selected menu option based on cursor position
        MOVE EIBCPOSN TO WS-CURSOR-POSITION
        EVALUATE WS-CURSOR-POSITION
            * Call respective programs based on the selected option
            WHEN 6020 PERFORM CALL-INQUIRY
            WHEN 8020 PERFORM CALL-CUSTOMER-DETAILS
            WHEN 10020 PERFORM CALL-ORDER-UPDATE
            WHEN OTHER
                * Handle invalid menu options
                MOVE "INVALID OPTION SELECTED" TO WS-MESSAGE
                EXEC CICS SEND TEXT FROM(WS-MESSAGE) END-EXEC
        END-EVALUATE
    ELSE
        * Handle invalid PF keys
        MOVE "INVALID PF KEY" TO WS-MESSAGE
        EXEC CICS SEND TEXT FROM(WS-MESSAGE) END-EXEC
    END-IF.

    * Return control to CICS
    EXEC CICS RETURN END-EXEC.

CALL-INQUIRY.
    * Link to the Item Inquiry program
    EXEC CICS LINK PROGRAM('INQUIRY') END-EXEC.

CALL-CUSTOMER-DETAILS.
    * Link to the Customer Details Update program
    EXEC CICS LINK PROGRAM('DETAILS') END-EXEC.

CALL-ORDER-UPDATE.
    * Link to the Order Update program
    EXEC CICS LINK PROGRAM('ORDERUPD') END-EXEC.
