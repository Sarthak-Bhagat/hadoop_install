read -n 1 -s -r -p "Press any key to download hadoop"
wget https://archive.apache.org/dist/hadoop/common/hadoop-3.3.1/hadoop-3.3.1.tar.gz
sudo apt-get install pdsh
sudo apt-get install openjdk-8-jdk 
sudo apt-get install openssh-server
echo "export PDSH_RCMD_TYPE=ssh" >> .bashrc
ssh-keygen -t rsa -P ""
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
# ssh localhost
# java -version
tar xzf hadoop-3.3.1.tar.gz
mv hadoop-3.3.1 hadoop
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/" >> ~/hadoop/etc/hadoop/hadoop-env.sh
echo "<configuration>

    <property>

        <name>fs.defaultFS</name>

        <value>hdfs://localhost:9000</value>

    </property>

    <property>

        <name>hadoop.tmp.dir</name>

        <value>/home/$USER/hdata</value>

    </property>

</configuration>" >> ~/hadoop/etc/hadoop/core-site.xml


echo "<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
</configuration>" >> ~/hadoop/etc/hadoop/hdfs-site.xml

echo "<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
    <property>
        <name>yarn.app.mapreduce.am.env</name>
        <value>HADOOP_MAPRED_HOME=/home/$USER/hadoop</value>
    </property>
    <property>
        <name>mapreduce.map.env</name>
        <value>HADOOP_MAPRED_HOME=/home/$USER/hadoop</value>
    </property>
    <property>
        <name>mapreduce.reduce.env</name>
        <value>HADOOP_MAPRED_HOME=/home/$USER/hadoop</value>
    </property>
</configuration>" >> ~/hadoop/etc/hadoop/mapred-site.xml

echo "<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
    <property>
        <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
        <value>org.apache.hadoop.mapred.ShuffleHandler</value>
    </property> 
</configuration>" >> ~/hadoop/etc/hadoop/yarn-site.xml

echo 'export HADOOP_HOME="/home/$USER/hadoop"
export PATH=$PATH:$HADOOP_HOME/bin
export PATH=$PATH:$HADOOP_HOME/sbin 
export HADOOP_MAPRED_HOME=${HADOOP_HOME}
export HADOOP_COMMON_HOME=${HADOOP_HOME}
export HADOOP_HDFS_HOME=${HADOOP_HOME}
export YARN_HOME=${HADOOP_HOME}' >> .bashrc

# echo 'alias hdfs="$HADOOP_HOME/bin/hdfs"' >> .bashrc
# echo 'alias yarn_start="$HADOOP_HOME/sbin/start-yarn.sh"' >> .bashrc
# echo 'alias hdfs_start=""$HADOOP_HOME/sbin/start-yarn.sh; $HADOOP_HOME/sbin/start-hfs.sh"' >> .bashrc


# source ~/.bashrc

# hdfs namenode -format
