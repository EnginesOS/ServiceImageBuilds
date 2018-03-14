FROM engines/servicebase:$release

RUN adduser -q --disabled-password --home /home/.home_dir -uid 22033 settings &&\
	usermod -G containers -a settings &&\	
	/home/engines/scripts/build/no_init.sh &&\	
	apt-get update -y  &&\
	apt-get install wireless-tools
						
	
	
COPY  home/ /home
COPY sudoers /etc/sudoers.d/settings
RUN chmod og-rw /etc/sudoers.d/settings 
	


ENV ContUser uadmin
ENV ContGrp uadmin

USER settings

CMD ["/home/engines/scripts/startup/start.sh"]