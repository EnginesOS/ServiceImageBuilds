FROM engines/frameworkbuild:$release

ADD home home
ENV ContUser rstudio
ENV ContGrp rstudio

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 &&\
	add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/' &&\
	apt-get -y update &&\
	apt-get -y install r-base \
	            r-base-dev &&\
	R -e "install.packages('shiny', repos='http://cran.rstudio.com/')" &&\
	apt-get install -y gdebi-core &&\
	wget http://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.9.923-amd64.deb &&\
	gdebi -y shiny-server-1.5.9.923-amd64.deb &&\
	apt-get clean -y &&\
	groupadd rstudio &&\
	useradd -u 22675  -g rstudio -d /home/rstudio -m -G containers rstudio
