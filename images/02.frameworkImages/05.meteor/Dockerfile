FROM engines/node:$release


USER node
RUN	curl https://install.meteor.com | /bin/sh
USER 0
RUN  cp /home/home_dir/.meteor/packages/meteor-tool/1.1.10/mt-os.linux.x86_64/scripts/admin/launch-meteor /usr/bin/meteor
