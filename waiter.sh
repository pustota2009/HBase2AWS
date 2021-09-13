pem="key_unix.pem"
user=ec2-user

wait=3

waiter() {
count=$(ssh -i $pem $user@$1 'ps ax|grep YCSB|wc -l')
while [ $((count+0)) -gt 2 ]
do
  echo "The test is working..."
  sleep $wait
  count=$(ssh -i $pem $user@$1 'ps ax|grep YCSB|wc -l')
done
echo checking...
}

rubustWait() {
waiter $1
sleep $wait
waiter $1
sleep $wait
waiter $1
echo "TEST HAS DONE"
}

sleep 10
rubustWait $host1
wait=1
rubustWait $host1
echo END
