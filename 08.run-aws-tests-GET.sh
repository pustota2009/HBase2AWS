base=hbase
ths=50
count=1000000000
duration=3600
regions=2000

pem="key_unix.pem"
user=ec2-user
batch=100

echo $count
count=$(($count/$batch))
echo $count

duration=180
echo RUN TESTS "$base" GET
nohup ssh -i $pem $user@$host1 './run-test-get.sh '$ths' '$count' '$duration' 0 1 '$batch' '$regions &
./waiter.sh YCSB

