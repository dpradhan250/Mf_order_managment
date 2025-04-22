//* This JCL script creates the KSDS file for the Order Transaction dataset.
//CREATEORD JOB (ACCT),'CREATE ORDER KSDS',CLASS=A,MSGCLASS=A
//STEP1    EXEC PGM=IDCAMS
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  *
  DEFINE CLUSTER (NAME(Order.Transaction.KSDS) -
                  INDEXED -
                  RECORDSIZE(41 41) -
                  KEYS(7 0) -
                  TRACKS(1 1) -
                  FREESPACE(0 0)) -
                  DATA (NAME(Order.Transaction.KSDS.DATA)) -
                  INDEX (NAME(Order.Transaction.KSDS.INDEX))
/*
//
