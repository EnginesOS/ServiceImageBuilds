FROM engines/frameworkbuild:$release
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
RUN \curl -L https://get.rvm.io | bash -s stable
RUN /usr/local/rvm/bin/rvm install ruby-1.9
#RUN /usr/local/rvm/bin/rvm  --default use ruby-1.9
ENV GEM_HOME /usr/local/rvm/gems/ruby-1.9.3-p550
ENV GEM_PATH /usr/local/rvm/gems/ruby-1.9.3-p550:/usr/local/rvm/gems/ruby-1.9.3-p550@global
ENV MY_RUBY_HOME /usr/local/rvm/rubies/ruby-1.9.3-p550
ENV RUBY_VERSION ruby-1.9.3-p550
ENV RPATH /usr/local/rvm/gems/ruby-1.9.3-p550/bin:/usr/local/rvm/gems/ruby-1.9.3-p550@global/bin:/usr/local/rvm/rubies/ruby-1.9.3-p550/bin:/usr/local/rvm/bin
ENV PATH /usr/local/rvm/gems/ruby-1.9.3-p550/bin:/usr/local/rvm/gems/ruby-1.9.3-p550@global/bin:/usr/local/rvm/rubies/ruby-1.9.3-p550/bin:/usr/local/rvm/bin:/usr/bin/:/bin:/bin:/sbin/:/usr/sbin
RUN  /usr/local/rvm/rubies/ruby-1.9.3-p550/bin/gem install rake ; /usr/local/rvm/rubies/ruby-1.9.3-p550/bin/gem install bundle


RUN echo "Y" | adduser -q --uid 22672 --home /home/ruby --disabled-password ruby
RUN mkdir -p /home/ruby/ ;echo ".  /etc/rvmrc " >> /home/ruby/.profile
RUN echo "rvm  --default use ruby-1.9.3-p550" >> /home/ruby/.profile
RUN echo "gem: --no-ri --no-rdoc" > /home/ruby/.gemrc

RUN echo "gem: --no-ri --no-rdoc" > /root/.gemrc

ENV ContUser ruby
ENV ContGrp ruby