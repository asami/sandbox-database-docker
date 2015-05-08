FROM java
MAINTAINER asami

RUN apt-get update && apt-get -y install mysql-client redis-server

RUN curl --create-dirs -o /opt/embulk -L "http://dl.embulk.org/embulk-latest.jar" && chmod +x /opt/embulk

RUN /opt/embulk gem install embulk-output-mysql

RUN mkdir -p /opt/lib
COPY lib/setup.yml /opt/lib/setup.yml
COPY lib/Batting.csv /opt/lib/Batting.csv
ADD https://raw.githubusercontent.com/asami/mysql-java-embulk-docker/master/lib/mysql-java-embulk-docker-lib.sh /opt/mysql-java-embulk-docker-lib.sh
COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

VOLUME ["/opt/lib"]

ENTRYPOINT ["/opt/entrypoint.sh"]
