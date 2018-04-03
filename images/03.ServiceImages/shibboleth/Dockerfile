FROM  engines/servicebase:$release

RUN apt-mark unhold tzdata &&\
	apt-get update -y &&\
	apt-get install -y openjdk-9-jre-headless &&\
 	usermod -G containers -a www-data &&\
 	/home/engines/scripts/build/post_build_clean.sh&&\
adduser -q --disabled-password -uid 22036 jetty &&\
cd /tmp &&\
wget -c http://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.3.9.v20160517/jetty-distribution-9.3.9.v20160517.tar.gz&&\
tar xzf jetty-distribution-9.3.9.v20160517.tar.gz \
mv jetty-distribution-9.3.9.v20160517 /opt/jetty9 \
chmod u=rwx,g=rxs,o= /opt/jetty9\
mkdir /var/log/jetty\
chown -R jetty:jetty /var/log/jetty \
wget https://shibboleth.net/downloads/identity-provider/latest/shibboleth-identity-provider-3.3.2.tar.gz\
echo errs\ 
tar -xzpf shibboleth-identity-provider-3.3.2.tar.gz\
echo ready

ENV JAVA_HOME /usr/lib/jvm/java-9-openjdk-amd64/
USER jetty

CMD ["/home/engines/scripts/system/start.sh"]