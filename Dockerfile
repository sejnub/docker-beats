FROM resin/rpi-raspbian:jessie-20160831  

MAINTAINER sejnub

# Update your package administration:
RUN apt-get update


#### Install commodities ####
# Just for development. Not needed for production

RUN apt-get -qy install apt-utils \
                        apt-transport-https \
                        wget \
                        nano

RUN apt-get -qy install mc


#### Install beats ####

COPY bin/filebeat-linux-arm               /usr/local/bin/filebeat
COPY config/filebeat.yml                  /etc/filebeat/
COPY config/filebeat.full.yml             /etc/filebeat/
                                                       
COPY bin/heartbeat-linux-arm              /usr/local/bin/heartbeat
COPY config/heartbeat.yml                 /etc/heartbeat/
COPY config/heartbeat.full.yml            /etc/heartbeat/
                                                       
COPY bin/metricbeat-linux-arm             /usr/local/bin/metricbeat
COPY config/metricbeat.yml                /etc/metricbeat/
COPY config/metricbeat.full.yml           /etc/metricbeat/
                                                       
COPY config/metricbeat.template.json      /etc/metricbeat/
COPY config/metricbeat.template-es2x.json /etc/metricbeat/


RUN chmod ug+x /usr/local/bin/filebeat  && \
    chmod ug+x /usr/local/bin/heartbeat && \
    chmod ug+x /usr/local/bin/metricbeat 


COPY bin/start.sh  /usr/local/bin
RUN chmod ug+x     /usr/local/bin/start.sh
 
#ENTRYPOINT ["/usr/local/bin/start.sh"]

CMD /bin/bash
