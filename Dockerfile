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


#### Install beats ####


#EXPOSE


CMD /bin/bash
