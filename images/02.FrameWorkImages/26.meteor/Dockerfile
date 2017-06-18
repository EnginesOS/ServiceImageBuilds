FROM engines/node6:$release


USER node
RUN	curl https://install.meteor.com | /bin/sh
USER 0
RUN  cp `find /home/home_dir/.meteor/packages/meteor-tool -name launch-meteor ` /usr/bin/meteor
