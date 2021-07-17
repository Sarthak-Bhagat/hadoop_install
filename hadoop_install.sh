read -n 1 -s -r -p "Press any key to download hadoop"
cd ~
wget https://archive.apache.org/dist/hadoop/common/hadoop-3.3.1/hadoop-3.3.1.tar.gz
read -n 1 -s -r -p "INSTALLING DEPENDANCIES"
sudo apt-get install pdsh
sudo apt-get install openjdk-8-jdk 
sudo apt-get install openssh-server
echo "export PDSH_RCMD_TYPE=ssh" >> .bashrc
ssh-keygen -t rsa -P ""
echo "ADDING SSH KEY"
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
# ssh localhost
# java -version
echo "EXTRACTING HADOOP"
tar xzf hadoop-3.3.1.tar.gz
rm -rf hadoop-3.3.1.tar.gz
mv hadoop-3.3.1 hadoop
echo "CREATING HADOOP FILES"
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/" >> ~/hadoop/etc/hadoop/hadoop-env.sh

echo "<?xml-stylesheet type=\"text/xsl\" href=\"configuration.xsl\"?>
<!--
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an \"AS IS\" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License. See accompanying LICENSE file.
-->

<!-- Put site-specific property overrides in this file. -->

<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:9000</value>

    </property>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>/home/$USER/hdata</value>
    </property>
</configuration> " > ~/hadoop/etc/hadoop/core-site.xml

echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<?xml-stylesheet type=\"text/xsl\" href=\"configuration.xsl\"?>
<!--
  Licensed under the Apache License, Version 2.0 (the \"License\");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an \"AS IS\" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License. See accompanying LICENSE file.
-->

<!-- Put site-specific property overrides in this file. -->

<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
</configuration>
" > ~/hadoop/etc/hadoop/hdfs-site.xml

echo "<?xml version=\"1.0\"?>
<?xml-stylesheet type=\"text/xsl\" href=\"configuration.xsl\"?>
<!--
  Licensed under the Apache License, Version 2.0 (the \"License\");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an \"AS IS\" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License. See accompanying LICENSE file.
-->

<!-- Put site-specific property overrides in this file. -->
<configuration>
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
</configuration>
" > ~/hadoop/etc/hadoop/mapred-site.xml

echo "<?xml version=\"1.0\"?>
<!--
  Licensed under the Apache License, Version 2.0 (the \"License\");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an \"AS IS\" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License. See accompanying LICENSE file.
-->
<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
    <property>
        <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
        <value>org.apache.hadoop.mapred.ShuffleHandler</value>
    </property> 
</configuration>
" > ~/hadoop/etc/hadoop/yarn-site.xml

echo "ADDING HADOOP TO PATH"
echo 'export HADOOP_HOME="/home/$USER/hadoop"
export PATH=$PATH:$HADOOP_HOME/bin
export PATH=$PATH:$HADOOP_HOME/sbin 
export HADOOP_MAPRED_HOME=${HADOOP_HOME}
export HADOOP_COMMON_HOME=${HADOOP_HOME}
export HADOOP_HDFS_HOME=${HADOOP_HOME}
export YARN_HOME=${HADOOP_HOME}' >> .bashrc

. ~/.bashrc

start-yarn.sh
start-dfs.sh
hdfs namenode -format

echo "INSTALLATION COMPLETE"

