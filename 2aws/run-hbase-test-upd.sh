th=$1
count=$2
exec_time=$3
num=$4
max_num=$5
batch_size=$6
regions=$7

cd /home/ec2-user/YCSB
source /etc/profile.d/maven.sh

# UPDATE
bin/ycsb run hbase2 -s \
-cp /etc/hbase/conf \
-threads $th \
-p table=usertable$regions \
-P workloads/workload \
-p recordcount=$(($max_num*$count)) \
-p operationcount=0 \
-p columnfamily=cf \
-p maxexecutiontime=$exec_time \
-p readproportion=0 \
-p updateproportion=1 \
-p insertproportion=0 \
-p batchsize=$batch_size \
> run.thr$1.cnt$2.tim$3.num$4.max$5.bch$6.reg$7.hbase.t$8.upd.out 2> run.thr$1.cnt$2.tim$3.num$4.max$5.bch$6.reg$7.hbase.t$8.upd

