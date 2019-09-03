FROM engines/python3.7:$release


ADD home home
ENV ContUser python
ENV ContGrp python
RUN apt-get update -y &&\
	apt-get install -y apache2 \
	libapache2-mod-wsgi-py3
 	
ADD src/etc  etc