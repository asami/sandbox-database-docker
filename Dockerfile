FROM asami/setup-database-docker
MAINTAINER asami

COPY lib/batting.yml /opt/lib/batting.yml
COPY lib/Batting.csv /opt/lib/Batting.csv
COPY lib/player.yml /opt/lib/player.yml
COPY lib/Master.csv /opt/lib/Master.csv
