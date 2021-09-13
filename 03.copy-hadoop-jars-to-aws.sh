pem="key_unix.pem"

scp -i $pem 2aws-jars/*.jar ec2-user@$host1:~

