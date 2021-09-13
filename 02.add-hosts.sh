instance_type=$(cat instance_type.txt)

clid=$(cat cluster.id |grep aws | awk '{print $2}')

while [ $(aws emr list-instances --cluster-id  $clid --output text | grep $instance_type | wc -w) = "4" ]
do 
 echo "Cluster is creating..."
 echo $(aws emr list-instances --cluster-id  $clid --output text | grep $instance_type)| wc -w
 sleep 10
done

aws emr list-instances --cluster-id $clid  --output text |grep $instance_type|awk '{i+=1;print "export host"i"="$10}' > hosts.lst.sh
chmod +x hosts.lst.sh

