echo "i3en.6xlarge" > instance_type.txt

# for test (cheaper)
#echo "m5d.4xlarge" > instance_type.txt # DONT CHOOSE m5d.2xlarge FOR SLAVE LIKE FOR MASTER

instance_type=$(cat instance_type.txt)

aws emr create-cluster \
--applications Name=Hadoop Name=HBase \
--ec2-attributes '{"KeyName":"key_unix","InstanceProfile":"EMR_EC2_DefaultRole","SubnetId":"subnet-2e1e5762","EmrManagedSlaveSecurityGroup":"sg-003279036f8eacf02","EmrManagedMasterSecurityGroup":"sg-0605c872027ce017e"}' \
--service-role EMR_DefaultRole \
--bootstrap-actions '[{"Path":"s3://us-east-2.elasticmapreduce/bootstrap-actions/run-if","Args":["instance.isMaster=false","sudo mkdir -p /var/run/hadoop-hdfs/;sudo chown hdfs:hdfs /var/run/hadoop-hdfs/;sudo chmod 750 /var/run/hadoop-hdfs/"],"Name":"Run if"}]' \
--release-label emr-5.32.0 \
--name 'YCSB' \
--instance-groups '[{"InstanceCount":1,"EbsConfiguration":{"EbsBlockDeviceConfigs":[{"VolumeSpecification":{"SizeInGB":32,"VolumeType":"gp2"},"VolumesPerInstance":1}]},"InstanceGroupType":"MASTER","InstanceType":"m5d.2xlarge","Name":"Master - 1"},{"InstanceCount":1,"InstanceGroupType":"CORE","InstanceType":"'$instance_type'","Configurations":[{"Classification":"hbase-site","Properties":{"hfile.block.cache.size":"0.7","hbase.regionserver.global.memstore.size":"0.1","hbase.regionserver.handler.count":"100","hbase.regionserver.metahandler.count":"10","hbase.regionserver.maxlogs":"100","hbase.hregion.memstore.flush.size":"28554432","hbase.hregion.memstore.block.multiplier":"4","hbase.hstore.compactionThreshold":"5","hbase.hstore.blockingStoreFiles":"1000","hbase.regionserver.optionalcacheflushinterval":"18000000","hbase.regionserver.thread.compaction.large":"12","hbase.regionserver.wal.enablecompression":"false","hbase.server.compactchecker.interval.multiplier":"200","dfs.client.hedged.read.threadpool.size":"200","dfs.client.hedged.read.threshold.millis":"10","hbase.rest.threads.min":"8","hbase.rest.threads.max":"50","hbase.thrift.minWorkerThreads":"200","hbase.regionserver.thread.compaction.small":"6","dfs.client.read.shortcircuit":"true","dfs.client.read.shortcircuit.buffer.size":"2048","dfs.client.short.circuit.num":"5","hbase.ipc.server.read.threadpool.size":"120","hbase.lru.cache.heavy.eviction.count.limit":"0","hbase.lru.cache.heavy.eviction.mb.size.limit":"250","hbase.lru.cache.heavy.eviction.overhead.coefficient":"0.015","dfs.domain.socket.path":"/var/run/hadoop-hdfs/sdn","dfs.client.read.shortcircuit.streams.cache.size":"10000","dfs.client.read.shortcircuit.streams.cache.expiry.ms":"600000000","hbase.regionserver.throughput.controller":"org.apache.hadoop.hbase.regionserver.throttle.NoLimitThroughputController"}},{"Classification":"hdfs-site","Properties":{"dfs.domain.socket.path":"/var/run/hadoop-hdfs/sdn","dfs.client.read.shortcircuit":"true","dfs.client.read.shortcircuit.streams.cache.size":"10000","dfs.client.read.shortcircuit.streams.cache.expiry.ms":"600000000","dfs.datanode.max.transfer.threads":"4096","dfs.datanode.handler.count":"500","dfs.namenode.handler.count":"500"}}],"Name":"Core Instance Group"}]' \
--scale-down-behavior TERMINATE_AT_TASK_COMPLETION \
--region us-east-2 > cluster.id
