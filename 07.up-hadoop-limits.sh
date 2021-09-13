pem="key_unix.pem"

scp -i $pem 2aws/limits-hadoop.sh ec2-user@$host1:~

ssh -i $pem ec2-user@$host1 'sudo ./limits-hadoop.sh'

