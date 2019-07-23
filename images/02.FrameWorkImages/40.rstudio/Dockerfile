FROM engines/frameworkbuild:$release

ADD home home
ENV ContUser rstudio
ENV ContGrp rstudio

RUN groupadd rstudio &&\
	useradd -u 22672  -g rstudio -d /home/home_dir -G containers rstudio &&\
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 &&\
	add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/' &&\
	apt-get -y update &&\
	apt-get -y install r-base \
	            r-base-dev \
	            texlive-full \
	            r-base-core \
	            gdebi-core