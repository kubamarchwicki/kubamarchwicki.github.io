FROM ruby

MAINTAINER Jakub Marchwicki <kuba.marchwicki@gmail.com>

RUN apt-get update \
  && apt-get install -y \
    curl \
    git \
    python-pygments \
    openjdk-7-jdk \
  && apt-get clean

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

RUN mkdir /app
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable
RUN ["/bin/bash", "-l", "-c",  "rvm requirements; rvm install 2.1.4; gem install bundler --no-ri --no-rdoc"]

COPY Gemfile /app/Gemfile
WORKDIR /app
RUN ["/bin/bash", "-l", "-c", "bundle install"]

VOLUME /app
EXPOSE 4000

ENTRYPOINT ["jekyll"]
