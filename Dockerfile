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

COPY beat-bins/filebeat-linux-arm /usr/local/bin/filebeat
COPY beat-bins/heartbeat-linux-arm /usr/local/bin/heartbeat
COPY beat-bins/metricbeat-linux-arm /usr/local/bin/metricbeat

RUN chmod ug+x /usr/local/bin/filebeat && \
    chmod ug+x /usr/local/bin/heartbeat && \
    chmod ug+x /usr/local/bin/metricbeat 

#### Install beats ####


#EXPOSE


CMD /bin/bash
