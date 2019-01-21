FROM engines/servicebase:$release

RUN  useradd -u 22033  -g settings -d /home/.home_dir -m -G containers settings &&\
	/home/engines/scripts/build/no_init.sh &&\	
	apt-get update -y  &&\
	apt-get install -y wireless-tools iw wpasupplicant 
						
	
	
COPY  home/ /home
COPY sudoers /etc/sudoers.d/settings
RUN chmod og-rw /etc/sudoers.d/settings 
	


ENV ContUser uadmin
ENV ContGrp uadmin

USER settings

CMD ["/home/engines/scripts/system/start.sh"]