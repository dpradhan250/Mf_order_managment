//* This JCL script creates the KSDS file for the Item Master dataset.
//CREATEITEM JOB (ACCT),'CREATE ITEM KSDS',CLASS=A,MSGCLASS=A
//STEP1    EXEC PGM=IDCAMS
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  *
  DEFINE CLUSTER (NAME(Item.Master.KSDS) -
                  INDEXED -
                  RECORDSIZE(26 26) -
                  KEYS(7 0) -
                  TRACKS(1 1) -
                  FREESPACE(0 0)) -
                  DATA (NAME(Item.Master.KSDS.DATA)) -
                  INDEX (NAME(Item.Master.KSDS.INDEX))
/*
//
