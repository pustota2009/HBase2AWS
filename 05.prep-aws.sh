echo INSTALL TESTS HBasse


rm -r temp4aws
mkdir temp4aws
pem="key_unix.pem"
user=ec2-user

cp 2aws/*.sh temp4aws
cp 2aws/*.zip temp4aws
mmv temp4aws/'*hbase-*' temp4aws/'#1#2'

cp 2aws/*.sh temp4aws

scp -i $pem temp4aws/* $user@$host1:~
ssh -i $pem $user@$host1 './prep-test.sh'
rm -r temp4aws

