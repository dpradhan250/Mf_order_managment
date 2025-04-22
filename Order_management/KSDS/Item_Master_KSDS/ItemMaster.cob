* This COBOL program defines the structure and logic for the Item Master KSDS file.
IDENTIFICATION DIVISION.
PROGRAM-ID. ItemMaster.

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
    05  Item-Name           PIC X(12).
    05  Item-Qty            PIC 9(05).
    05  Item-Price          PIC 9(05)V9(02).

WORKING-STORAGE SECTION.
01  WS-File-Status         PIC X(02).

PROCEDURE DIVISION.
    DISPLAY "Item Master KSDS Program Initialized".
    STOP RUN.
