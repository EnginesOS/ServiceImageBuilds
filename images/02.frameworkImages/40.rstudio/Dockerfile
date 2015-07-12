FROM engines/frameworkbuild:$release

ENV ContUser rstudio
ENV ContGrp rstudio

RUN apt-get -y update;\
	echo deb http://cran.csiro.au/ trusty >> /etc/apt/sources.list;\
	apt-get -y install r-base r-base-dev;\
	R -e "install.packages('shiny', repos='http://cran.rstudio.com/')";\
	apt-get install gdebi-core;\
	wget http://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.3.0.403-amd64.deb;\
	gdebi shiny-server-1.3.0.403-amd64.deb ;\
	apt-get clean ;\
	groupadd rstudio;\
 	echo "Y" | adduser --uid 22675 -q --ingroup rstudio --home /home/rstudio --disabled-password rstudio;\
 	usermod -G containers -a rstudio
