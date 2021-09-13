cp /usr/lib/hadoop-hdfs/hadoop-hdfs-client-2.10.1-amzn-0.jar /usr/lib/hadoop-hdfs/hadoop-hdfs-client-2.10.1-amzn-0.jar_bkp

mv hadoop-hdfs-client-2.10.1.jar hadoop-hdfs-client-2.10.1-amzn-0.jar
cp hadoop-hdfs-client-2.10.1-amzn-0.jar /usr/lib/hadoop-hdfs
cp hbase-server-1.4.13.jar /usr/lib/hbase/lib/

sudo printf "\nexport HBASE_REGIONSERVER_OPTS=-Xmx16G\n" >> /etc/hbase/conf/hbase-env.sh

ps ax|grep datanod |awk '{print $1}' |xargs kill {}
ps ax|grep datanod |awk '{print $1}' |xargs kill {}
ps ax|grep hbase |awk '{print $1}' |xargs kill {}
ps ax|grep hbase |awk '{print $1}' |xargs kill {}
sleep 2