scp -i key_unix.pem keygen/*10m* ec2-user@$host1:~
scp -i key_unix.pem keygen/*.jar ec2-user@$host1:~
scp -i key_unix.pem -r hbase2 ec2-user@$host1:~

ssh -i key_unix.pem ec2-user@$host1 './prep-bulk-load.sh'