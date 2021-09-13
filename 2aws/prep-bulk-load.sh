sudo cp ~/hbase2/* /usr/lib/hbase/bin/

sudo sed -i 's:hbase\:/sbin/nologin:hbase\:/bin/bash:g' /etc/passwd
sudo su - hbase -c 'cd /usr/lib/hbase/bin/; ./start-hbase.sh; sleep 10'

unzip keys_10m.zip
hdfs dfs -mkdir /tmp/inp10m
hdfs dfs -put ./keys_10m/* /tmp/inp10m

sudo su - hdfs -c 'hdfs dfs -chmod -R +w  /user'

hbase org.apache.hadoop.hbase.util.RegionSplitter usertable1000 UniformSplit -c 1000 -f cf
echo "alter 'usertable1000', {NAME => 'cf', BLOCKSIZE => '2048'}"|hbase shell
echo "major_compact 'usertable1000'"|hbase shell


