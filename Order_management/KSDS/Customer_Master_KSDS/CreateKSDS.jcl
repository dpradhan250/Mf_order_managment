//* This JCL script creates the KSDS file for the Customer Master dataset.
//* 
//CREATEKSDS JOB (ACCT),'CREATE KSDS',CLASS=A,MSGCLASS=A
//STEP1    EXEC PGM=IDCAMS
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  *
  DEFINE CLUSTER (NAME(Customer.Master.KSDS) -
                  INDEXED -
                  RECORDSIZE(87 87) -
                  KEYS(7 0) -
                  TRACKS(1 1) -
                  FREESPACE(0 0)) -
                  DATA (NAME(Customer.Master.KSDS.DATA)) -
                  INDEX (NAME(Customer.Master.KSDS.INDEX))
/*
//
