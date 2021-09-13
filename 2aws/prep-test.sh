echo STAT PREP HBase

user=ec2-user
sudo yum install -y mc

cd /opt
sudo wget https://www.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
sudo tar -xzvf apache-maven-3.6.3-bin.tar.gz
sudo echo 'export PATH=/opt/apache-maven-3.6.3/bin:$PATH' > /tmp/maven.sh
sudo mv /tmp/maven.sh /etc/profile.d

cd /home/$user
unzip YCSB.zip

cd /home/$user/YCSB
nohup sar 10 10000 >> run.cpu.$(hostname).stat &
nohup iostat -xmt 10 >> run.ssd.$(hostname).stat &

