FROM asami/setup-database-docker
MAINTAINER asami

COPY lib/setup.yml /opt/lib/setup.yml
COPY lib/Batting.csv /opt/lib/Batting.csv
