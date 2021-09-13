pem="key_unix.pem"
user=ec2-user
ts=$(date "+%s")

mkdir ./results_$ts
scp -i $pem $user@$host1:~/YCSB/* .
mv run.* ./results_$ts