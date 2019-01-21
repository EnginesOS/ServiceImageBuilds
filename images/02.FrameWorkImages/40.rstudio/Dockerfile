FROM engines/frameworkbuild:$release

ENV ContUser rstudio
ENV ContGrp rstudio

RUN apt-get -y update &&\
	echo "deb http://cran.rstudio.com/bin/linux/ubuntu bionic/" | tee -a /etc/apt/sources.list &&\
	gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9 &&\
	gpg -a --export E084DAB9 | apt-key add - &&\
	apt-get -y update &&\
	apt-get -y install r-base \
	                   r-base-dev &&\
	R -e "install.packages('shiny', repos='http://cran.rstudio.com/')" &&\
	apt-get install -y gdebi-core &&\
	wget http://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.3.838-amd64.deb &&\
	gdebi shiny-server-1.5.3.838-amd64.deb &&\
	apt-get clean -y &&\
	groupadd rstudio &&\
	useradd -u 22675  -g rstudio -d /home/rstudio -m -G containers rstudio
