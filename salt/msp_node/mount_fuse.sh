
sudo umount /mnt/hdfs
wget http://archive.cloudera.com/cdh5/one-click-install/trusty/amd64/cdh5-repository_1.0_all.deb
sudo dpkg -i cdh5-repository_1.0_all.deb
sudo apt-get update
sudo apt-get  install hadoop-hdfs-fuse
sudo mkdir -p /mnt/hdfs
mountpoint -q /mnt/hdfs || sudo hadoop-fuse-dfs dfs://HDFS-HA  /mnt/hdfs
sudo -u hdfs mkdir /vagrant/
sudo -u hdfs mkdir /vagrant/provision
sudo -u hdfs mkdir /vagrant/provision/resources/
sudo -u hdfs mkdir /vagrant/provision/resources/output_files

