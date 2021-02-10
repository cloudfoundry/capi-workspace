FROM ubuntu:focal

#RUN useradd --system -s /sbin/nologin capi
#USER capi
RUN apt-get update

RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata

RUN apt-get install -y \ 
     git \
     wget \
     curl \
     apt-utils \
     tmux \
     ruby \
     mysql-server \
     libmysqlclient-dev \
     ruby-dev \
     postgresql-contrib \
     postgresql \
     libpq5 \
     libpq-dev


RUN service mysql start && \
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';"

RUN gem install bundler
CMD sleep infinity
