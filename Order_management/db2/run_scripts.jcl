//RUNSQL   JOB (ACCT),'RUN DB2 SCRIPTS',CLASS=A,MSGCLASS=A
//* This JCL runs the SQL scripts to initialize tables and insert dummy records
//STEP1    EXEC PGM=IKJEFT01
//SYSTSPRT DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//SYSUDUMP DD SYSOUT=*
//SYSIN    DD *
  DSN SYSTEM(DB2)
  RUN PROGRAM(DSNTIAUL) PLAN(DSNTIAUL) -
  LIB('DSN810.SDSNLOAD') -
  PARMS('SQL')
  END
//SYSIN    DD *
@initialize_tables.sql
@insert_dummy_records.sql
/*
//
