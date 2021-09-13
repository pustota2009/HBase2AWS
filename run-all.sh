echo step1
./01.create-hadoop.sh
echo sleep 120 sec
sleep 120
echo step2
./02.add-hosts.sh
echo add host
. ./hosts.lst.sh
echo step3
./03.copy-hadoop-jars-to-aws.sh
echo step4
./04.restat-hadoop.sh
echo step5
./05.prep-aws.sh
echo step6
./06.prep-bulk-load.sh
echo sleep 15 sec
sleep 15
echo step7
./07.up-hadoop-limits.sh
echo step8.1 Bulk load
./08.run-aws-tests-BULK-LOAD.sh
echo step8.2 Get
./08.run-aws-tests-GET.sh
echo step8.3
./08.run-aws-tests-PUT-UPD-GET.sh
echo step9
./09.get-results.sh
echo step

