# docker-beats (WIP)

## Build beats for arm

Based on <https://gist.github.com/alibo/016c54c7e6dfcb8d4c87dae080230ad0>

```bash

cd ~
git clone https://github.com/sejnub/docker-beats.git
cd docker-beats/bin

#----- Create a Docker for cross-compilation -----#
#mkdir build && cd $_
docker run -it --rm -v `pwd`:/build golang:latest /bin/bash


#----- Inside container -----#
go get github.com/elastic/beats

cd /go/src/github.com/elastic/beats/filebeat/
git checkout v6.6.0
GOARCH=arm go build
cp filebeat /build

cd /go/src/github.com/elastic/beats/metricbeat/
git checkout v6.6.0
GOARCH=arm go build
cp metricbeat /build

cd /go/src/github.com/elastic/beats/heartbeat/
git checkout v6.6.0
GOARCH=arm go build
cp heartbeat /build

exit

#----- Outside container / Verify the outputfile -----#
file filebeat 
#ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), statically linked, not stripped

file metricbeat 
#ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), statically linked, not stripped

file heartbeat 
#ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), statically linked, not stripped

#----- Push executables -----#

git add .
git push

```



## REST

# Status 
Work in progress: This repository is worthless for anybody but me just now.


# TODO

* Way 1: Check the repository <https://github.com/andig/beats4pi> that seems to be a much better way!

* Way 2: Do it my way as it is described in this rep before 2018-11. Then the following is to be done
    * Remove installation of commodity software from Dockerfile
    * Create mechanism to run the image with a specified configuration
    * Switch to a smaller base image like e.g. alpine (look at hypriot)

# Doc
https://www.elastic.co/guide/en/beats/filebeat/master/directory-layout.html


# Run portainer
    sudo docker start portainer

or

    sudo docker rm -f portainer; sudo docker run -d -p 9000:9000 -v "/var/run/docker.sock:/var/run/docker.sock" --name portainer portainer/portainer


# Build image 

    ## set up the source folder ~/docker-beats-1-sources

    ### prepare empty folder ~/docker-beats-1-sources
    cd ~
    rm -rf ~/docker-beats-1-sources
    mkdir  ~/docker-beats-1-sources  
    
    ### load foreign external sources into ~/docker-beats-1-sources
    
    #### clone the git rep that contains config file templates
    cd ~/docker-beats-1-sources; 
    git clone https://github.com/elastic/beats.git
    
    #### wget the arm executables 
    echo "Have a look for newer binaries at https://beats-nightlies.s3.amazonaws.com/index.html?prefix=jenkins/ and then (with updated url's) do"

    cd ~/docker-beats-1-sources; wget https://beats-nightlies.s3.amazonaws.com/jenkins/metricbeat/1167-23d9fe69e8a4367fc31915553596129a2ca8267b/metricbeat-linux-arm 
    cd ~/docker-beats-1-sources; wget https://beats-nightlies.s3.amazonaws.com/jenkins/heartbeat/472-23d9fe69e8a4367fc31915553596129a2ca8267b/heartbeat-linux-arm
    cd ~/docker-beats-1-sources; wget https://beats-nightlies.s3.amazonaws.com/jenkins/filebeat/1594-23d9fe69e8a4367fc31915553596129a2ca8267b/filebeat-linux-arm
    

    ### load my own external sources into ~/docker-beats-1-sources (repeat from here on if I edited my source)

    #### clone my own rep (Dockerfile etc.)
    cd ~/docker-beats-1-sources; 
    rm -rf ~/docker-beats-1-sources/docker-beats
    git clone https://github.com/sejnub/docker-beats.git


    ## set up the build folder ~/docker-beats-2-build    

    ### prepare empty folder ~/docker-beats-2-build
    cd ~
    rm -rf ~/docker-beats-2-build 
    mkdir ~/docker-beats-2-build
    
    ### copy my own sorces into build folder (this has to happen first because it creates the bin and the config folders)
    cp -r ~/docker-beats-1-sources/docker-beats/* ~/docker-beats-2-build

    ### copy executables into build folder     
    cp ~/docker-beats-1-sources/metricbeat-linux-arm                  ~/docker-beats-2-build/bin/
    cp ~/docker-beats-1-sources/heartbeat-linux-arm                   ~/docker-beats-2-build/bin/
    cp ~/docker-beats-1-sources/filebeat-linux-arm                    ~/docker-beats-2-build/bin/

    ### copy config templates into build folder
    cp ~/docker-beats-1-sources/beats/metricbeat/metricbeat.yml           ~/docker-beats-2-build/config/
    cp ~/docker-beats-1-sources/beats/metricbeat/metricbeat.reference.yml ~/docker-beats-2-build/config/
    cp ~/docker-beats-1-sources/beats/heartbeat/heartbeat.yml             ~/docker-beats-2-build/config/
    cp ~/docker-beats-1-sources/beats/heartbeat/heartbeat.reference.yml   ~/docker-beats-2-build/config/
    cp ~/docker-beats-1-sources/beats/filebeat/filebeat.yml               ~/docker-beats-2-build/config/
    cp ~/docker-beats-1-sources/beats/filebeat/filebeat.reference.yml     ~/docker-beats-2-build/config/
    

    ## build
    cd ~/docker-beats-2-build; docker build -t sejnub/beats:rpi-latest .


# Push the image

    docker login
    docker push sejnub/beats:rpi-latest
    

# Run beats (WIP, not working by now)

Run an interactive bash

    docker rm -f beats; docker run -it --name beats sejnub/beats:rpi-latest bash

Then inside the container run

    metricbeat -path.config /etc/metricbeat 
    
    nano /etc/metricbeat/metricbeat.hb.yml
    
    
Just for information. There is an X86 docker image which can be run with

    sudo docker run -v /media/sf_shared-with-virtualbox/filebeat.hb1.yml:/filebeat.yml prima/filebeat:5


    eof



# In browser

    eof
 
 
 
 
 
 
eof
