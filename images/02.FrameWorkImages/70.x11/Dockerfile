FROM engines/frameworkbuild:$release

ENV ContUser xuser
ENV ContGrp xuser


	
RUN	groupadd xuser;\
	echo "Y" | adduser -q --ingroup xuser --uid 22672 --home /home/app --disabled-password xuser;\
		usermod -G containers -a xuser;\
		mkdir -p ~www-data ;\
		apt-get -y update;\
		chown www-data ~www-data ;\
	 	usermod -G data-user -a xuser;\
	  	usermod -G containers -a xuser;\
		apt-get install -y  openssh-server x11-common x11-utils x11-xserver-utils xbitmaps xcalib xdg-utils libx11-xcb1 libxaw7   libxtst6 libxv1 
		
ADD sshd_config /etc/ssh/	
ADD sudoers /etc/sudoers.d/engines