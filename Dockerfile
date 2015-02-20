FROM ruby:2.1.5

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

WORKDIR /app
VOLUME /app
EXPOSE 4000

COPY Gemfile /app/Gemfile
RUN /usr/local/bundle/bin/bundle install


ENTRYPOINT ["jekyll"]
