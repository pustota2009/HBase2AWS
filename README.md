# HBase2AWS

DISCLAIMER

!!! NO WARRANTY !!!
HBase it this environment work so-so. 
Need to configure much more for real using.

###

Before start have to:
1. Install ams
2. Create private key and call it key_unix.pem
3. If no connection configure Inbound and Outbound rules for security groups in AWS Console (open ports for your IP, don't open for all it is unsafe)

Run run-all.sh - it should do all work

###

You can skip deal with *.jar (will be slower):
hadoop-hdfs-client-2.10.1.jar
hbase-server-1.4.13.jar

Full code BulkLoader is here: https://github.com/pustota2009/YCSB2HBaseBulkImport.git
