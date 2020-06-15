FROM engines/frameworkbuild:k

ADD home home
ENV ContUser xuser
ENV ContGrp xuser

RUN	groupadd xuser &&\
	useradd -u 22672  -g xuser -d /home/app -m -G containers xuser&&\
	mkdir -p ~www-data &&\
	apt-get -y update &&\
	chown www-data ~www-data &&\
	usermod -G data-user -a xuser &&\
	usermod -G containers -a xuser &&\
	apt-get install -y openssh-server \
	                   x11-common \
	                   x11-utils \
	                   x11-xserver-utils \
	                   xbitmaps \
	                   xcalib \
	                   xdg-utils \
	                   libx11-xcb1 \
	                   libxaw7 \
	                   libxtst6 \
	                   libxv1 
		
ADD src/sshd_config /etc/ssh/	
ADD sudoers /etc/sudoers.d/engines