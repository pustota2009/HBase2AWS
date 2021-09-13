pem="key_unix.pem"
user=ec2-user

echo RUN TEST HBASE BULK LOAD
nohup ssh -i $pem $user@$host1 './run-hbase-bulk-load.sh' &
echo NOW WAIT UNTIL DONE
./waiter.sh YCSB2HBaseBulkImport
