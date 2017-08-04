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
# See https://www.elastic.co/guide/en/beats/filebeat/master/directory-layout.html for dir layout


RUN mkdir /usr/share/filebeat   \
          /usr/share/heartbeat  \
          /usr/share/metricbeat \
          /usr/share/beats
          
COPY bin/filebeat-linux-arm               /usr/share/filebeat/filebeat
COPY config/filebeat.yml                  /usr/share/filebeat
COPY config/filebeat.reference.yml        /usr/share/filebeat
                                                       
COPY bin/heartbeat-linux-arm              /usr/share/heartbeat/heartbeat
COPY config/heartbeat.yml                 /usr/share/heartbeat
COPY config/heartbeat.reference.yml       /usr/share/heartbeat
                                                       
COPY bin/metricbeat-linux-arm             /usr/share/metricbeat/metricbeat
COPY config/metricbeat.yml                /usr/share/metricbeat
COPY config/metricbeat.reference.yml      /usr/share/metricbeat
                                                       
COPY config/metricbeat.template.json      /usr/share/metricbeat
COPY config/metricbeat.template-es2x.json /usr/share/metricbeat


RUN chmod ug+x /usr/share/filebeat/filebeat   && \
    chmod ug+x /usr/share/heartbeat/heartbeat && \
    chmod ug+x /usr/share/metricbeat/metricbeat 


COPY bin/entrypoint.sh /usr/share/beats
RUN chmod ug+x         /usr/share/beats/entrypoint.sh
 
ENTRYPOINT ["/usr/share/beats/entrypoint.sh"]

CMD /bin/bash
