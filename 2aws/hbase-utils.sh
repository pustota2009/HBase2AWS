cmd=$1
regions=$2


if [ $cmd = "drop" ]
then
 echo "disable 'usertable$regions'"|hbase shell
 echo "drop 'usertable$regions'"|hbase shell
fi

if [ $cmd = "create" ]
then
 hbase org.apache.hadoop.hbase.util.RegionSplitter usertable$regions UniformSplit -c $regions -f cf
# BLOCKSIZE => '65536'
# echo "alter 'usertable$regions', {NAME => 'cf', DATA_BLOCK_ENCODING => 'DIFF', COMPRESSION => 'SNAPPY'}"|hbase shell
# echo "major_compact 'usertable$regions'"|hbase shell
fi

if [ $cmd = "mc" ]
then
 echo "major_compact 'usertable$regions'"|hbase shell
fi

if [ $cmd = "flush" ]
then
 echo "flush 'usertable$regions'"|hbase shell
fi
