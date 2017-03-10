FROM resin/rpi-raspbian:jessie-20160831  

MAINTAINER sejnub

# Update your package administration:
RUN apt-get update


#### Install commodities ####
# Just for development. Not needed for production

RUN apt-get -qy install apt-utils \
                        apt-transport-https \
                        wget

RUN apt-get -qy install mc

COPY beat-bin-and-config/filebeat-linux-arm       /usr/local/bin/filebeat
COPY beat-bin-and-config/filebeat.yml             /etc/filebeat/
COPY beat-bin-and-config/filebeat.full.yml        /etc/filebeat/

COPY beat-bin-and-config/heartbeat-linux-arm      /usr/local/bin/heartbeat
COPY beat-bin-and-config/heartbeat.yml            /etc/heartbeat/
COPY beat-bin-and-config/heartbeat.full.yml       /etc/heartbeat/

COPY beat-bin-and-config/metricbeat-linux-arm     /usr/local/bin/metricbeat
COPY beat-bin-and-config/metricbeat.yml           /etc/metricbeat/
COPY beat-bin-and-config/metricbeat.full.yml      /etc/metricbeat/

COPY beat-bin-and-config/metricbeat.template.json /etc/metricbeat/



COPY beat-bin-and-config/filebeat.hb.yml          /etc/filebeat/
COPY beat-bin-and-config/heartbeat.hb.yml         /etc/heartbeat/
COPY beat-bin-and-config/metricbeat.hb.yml        /etc/metricbeat/


RUN chmod ug+x /usr/local/bin/filebeat && \
    chmod ug+x /usr/local/bin/heartbeat && \
    chmod ug+x /usr/local/bin/metricbeat 

#### Install beats ####


#EXPOSE


CMD /bin/bash
