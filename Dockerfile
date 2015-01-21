# Dockerfile
FROM ubuntu
MAINTAINER hcarreras(haricarreras@gmail.com)

RUN apt-get -qy install curl
RUN curl -L https://get.rvm.io | bash -s stable --ruby
RUN rvm install ruby-2.1.3
RUN rvm --default use ruby-2.1.3
RUN apt-get -qy install nodejs
ADD AGA-OSL-rails-app
WORKDIR /AGA-OSL-rails-app
ONBUILD RUN bundle install
ONBUILD ADD . /AGA-OSL-rails-app
RUN rails server
EXPOSE 3000