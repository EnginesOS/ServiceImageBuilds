FROM engines/rstudio:k

ADD home home
ENV ContUser rstudio
ENV ContGrp rstudio

RUN	R -e "install.packages('shiny', repos='http://cran.rstudio.com/')" &&\
	R -e "install.packages('rmarkdown')" &&\
	wget http://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.9.923-amd64.deb &&\
	gdebi -n shiny-server-1.5.9.923-amd64.deb &&\
	apt-get clean -y 

COPY src/etc/shiny-server/shiny-server.conf /etc/shiny-server/shiny-server.conf 	
	