* This COBOL program defines the structure and logic for the Customer Master KSDS file.
IDENTIFICATION DIVISION.
PROGRAM-ID. CustomerMaster.

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

PROCEDURE DIVISION.
    DISPLAY "Customer Master KSDS Program Initialized".
    STOP RUN.
