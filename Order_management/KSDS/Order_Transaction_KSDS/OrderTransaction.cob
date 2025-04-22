* This COBOL program defines the structure and logic for the Order Transaction KSDS file.
IDENTIFICATION DIVISION.
PROGRAM-ID. OrderTransaction.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT OrderFile ASSIGN TO "Order.Transaction.KSDS"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS RANDOM
        RECORD KEY IS Order-Code
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

WORKING-STORAGE SECTION.
01  WS-File-Status         PIC X(02).

PROCEDURE DIVISION.
    DISPLAY "Order Transaction KSDS Program Initialized".
    STOP RUN.
