pem="key_unix.pem"

scp -i $pem 2aws/update-jars-hadoop-2.sh ec2-user@$host1:~

ssh -i $pem ec2-user@$host1 'sudo ./update-jars-hadoop-2.sh'

