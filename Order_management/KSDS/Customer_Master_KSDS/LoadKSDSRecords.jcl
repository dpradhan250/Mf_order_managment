//* This JCL script loads 20 records into the Customer Master KSDS file.
//LOADKSDS JOB (ACCT),'LOAD KSDS',CLASS=A,MSGCLASS=A
//STEP1    EXEC PGM=IDCAMS
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  *
  REPRO INFILE(INPUT) OUTFILE(Customer.Master.KSDS)
/*
//INPUT    DD  *
0000001 John Smith     123 Main St  MUM9876543210john.smith@example.com
0000002 Jane Doe       456 Elm St   DEL9876543211jane.doe@example.com
0000003 Alice Brown    789 Oak St   BNG9876543212alice.brown@example.com
0000004 Bob White      321 Pine St  CHE9876543213bob.white@example.com
0000005 Carol Black    654 Maple St HYD9876543214carol.black@example.com
0000006 David Green    987 Cedar St MUM9876543215david.green@example.com
0000007 Eve Adams      147 Birch St DEL9876543216eve.adams@example.com
0000008 Frank Moore    258 Spruce StBNG9876543217frank.moore@example.com
0000009 Grace Hall     369 Willow StCHE9876543218grace.hall@example.com
0000010 Henry King     741 Aspen St HYD9876543219henry.king@example.com
0000011 Irene Scott    852 Fir St   MUM9876543220irene.scott@example.com
0000012 Jack Turner    963 Palm St  DEL9876543221jack.turner@example.com
0000013 Karen Lewis    159 Ash St   BNG9876543222karen.lewis@example.com
0000014 Larry Young    753 Elm St   CHE9876543223larry.young@example.com
0000015 Mary Harris    357 Oak St   HYD9876543224mary.harris@example.com
0000016 Nancy Clark    951 Pine St  MUM9876543225nancy.clark@example.com
0000017 Oscar Wright   753 Maple St DEL9876543226oscar.wright@example.com
0000018 Paula Hill     357 Cedar St BNG9876543227paula.hill@example.com
0000019 Quentin Baker  951 Birch St CHE9876543228quentin.baker@example.com
0000020 Rachel Evans   753 Spruce StHYD9876543229rachel.evans@example.com
/*
//
