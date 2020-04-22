FROM engines/node_latest:k

RUN chmod -R g+w /usr/local/ &&\
	chgrp -R containers /usr/local/


ADD home home
USER node

RUN	curl https://install.meteor.com | /bin/sh

USER 0

RUN  cp `find /home/home_dir/.meteor/packages/meteor-tool -name launch-meteor ` /usr/bin/meteor
