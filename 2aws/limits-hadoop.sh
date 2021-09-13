echo Changing limits..
sleep 2
ps ax|grep node |awk '{print $1}' |xargs -I {} -n 1 sudo prlimit --pid {} --nofile=60000:60000
ps ax|grep hbase |awk '{print $1}' |xargs -I {} -n 1 sudo prlimit --pid {} --nofile=60000:60000
ps ax |awk '{print $1}' |xargs -I {} -n 1 sudo prlimit --pid {} --nofile=60000:60000 # For ALL for sure
sleep 2
echo LIMITS DONE
