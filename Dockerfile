FROM resin/rpi-raspbian:latest

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


#CMD
