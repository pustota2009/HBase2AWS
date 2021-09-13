base=hbase
ths=20
count=10000000
duration=3600
regions=1000 

pem="key_unix.pem"
user=ec2-user
batch=100

echo $count
count=$(($count/$batch))
echo $count

# if the fisrt run uncomment it
#if [ $base = "hbase" ]
#then
# echo CREATE HBASE TABLE
# ssh -i $pem $user@$host1 './hbase-utils.sh create '$regions
#fi

ths=20
echo RUN TESTS "$base" PUT
nohup ssh -i $pem $user@$host1 './run-test-ins.sh '$ths' '$count' '$duration' 0 4 '$batch' '$regions &
./waiter.sh $base

ths=5
echo RUN TESTS "$base" UPD
nohup ssh -i $pem $user@$host1 './run-test-upd.sh '$ths' '$count' '$duration' 0 1 '$batch' '$regions 0 &
./waiter.sh $base

ths=20
echo RUN TESTS "$base" PUT
nohup ssh -i $pem $user@$host1 './run-test-ins.sh '$ths' '$count' '$duration' 1 4 '$batch' '$regions &
./waiter.sh $base

ths=5
echo RUN TESTS "$base" UPD
nohup ssh -i $pem $user@$host1 './run-test-upd.sh '$ths' '$count' '$duration' 0 1 '$batch' '$regions 1 &
./waiter.sh $base

ths=20
echo RUN TESTS "$base" PUT
nohup ssh -i $pem $user@$host1 './run-test-ins.sh '$ths' '$count' '$duration' 2 4 '$batch' '$regions &
./waiter.sh $base

ths=5
echo RUN TESTS "$base" UPD
nohup ssh -i $pem $user@$host1 './run-test-upd.sh '$ths' '$count' '$duration' 0 1 '$batch' '$regions 2 &
./waiter.sh $base

ths=5
echo RUN TESTS "$base" PUT
nohup ssh -i $pem $user@$host1 './run-test-ins.sh '$ths' '$count' '$duration' 3 4 '$batch' '$regions &
./waiter.sh $base

ths=5
echo RUN TESTS "$base" UPD
nohup ssh -i $pem $user@$host1 './run-test-upd.sh '$ths' '$count' '$duration' 0 1 '$batch' '$regions 3 &
./waiter.sh $base

duration=180
echo RUN TESTS "$base" GET
nohup ssh -i $pem $user@$host1 './run-test-get.sh '$ths' '$count' '$duration' 0 1 '$batch' '$regions &
./waiter.sh $base $host1

