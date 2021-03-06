#!/bin/bash
set -e
sudo -v

_jdk(){
   echo "install jdk8 oracle ..."
  # ubuntu 16.04, 17.04 64 bit
  # install jdk 8 from Oracle officel
  # http://www.tecmint.com/install-java-jdk-jre-in-linux/
  # https://ivan-site.com/2012/05/download-oracle-java-jre-jdk-using-a-script/
  # remove all jdk openjdk
  sudo apt-get remove -y openjdk-*
  sudo apt autoremove -y
  sudo apt-get autoclean -y
  
  sudo mkdir -p /opt/java
  sudo chmod 777 -R /opt/java
  cd /opt/java
  # download .tar file in Oracle Home
  VERSION = 'jdk1.8.0_201'
  wget --no-cookies --no-check-certificate \
       --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
          "http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/${VERSION}-linux-x64.tar.gz"
  tar -xzvf ${VERSION}-linux-x64.tar.gz

  # update  update-alternatives
  cd ${VERSION}
  sudo update-alternatives --install /usr/bin/java java /opt/java/${VERSION}/bin/java 100
  # sudo update-alternatives --install /usr/bin/javac javac /opt/java/${VERSION}/bin/javac 100 
  # sudo update-alternatives --install /usr/bin/jar jar /opt/java/${VERSION}/bin/jar 100

  # if you had many version Java you can update command 
  # update-alternatives --config java
  # update-alternatives --config javac
  # update-alternatives --config jar
  JAVA_HOME=$(pwd)
  echo "
  export JAVA_HOME=$JAVA_HOME
  export JRE_HOME=$JAVA_HOME/jre
  export PATH=\$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin
  " >> ~/.bashrc

  source ~/.bashrc
 }

_jdk

