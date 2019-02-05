# docker-beats (WIP)

Work in progress: This repository is worthless for anybody but me just now.

## Links

- Check the repository <https://github.com/andig/beats4pi>


## Build and save beats for arm

- On an x86 machine follow <https://github.com/sejnub/docker-build-beats>
- Copy the executable to the folder ~/beats4pi on the raspi


## Build images

### TODO

Do it my way as it is described in this rep before 2018-11. Then the following is to be done
    * Remove installation of commodity software from Dockerfile
    * Create mechanism to run the image with a specified configuration
    * Switch to a smaller base image like e.g. alpine (look at hypriot)

### Doc
https://www.elastic.co/guide/en/beats/filebeat/master/directory-layout.html


### Build image 


    ## set up the source folder ~/docker-beats-1-sources

    ### prepare empty folder ~/docker-beats-1-sources
    cd ~
    rm -rf ~/docker-beats-1-sources
    mkdir  ~/docker-beats-1-sources  
    
    ### load foreign external sources into ~/docker-beats-1-sources
    
    #### clone the git rep that contains config file templates
    cd ~/docker-beats-1-sources; 
    git clone https://github.com/elastic/beats.git



    ##########################################################################################################
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
    cp ~/beats4pi/metricbeat   ~/docker-beats-2-build/bin/metricbeat-linux-arm
    cp ~/beats4pi/filebeat     ~/docker-beats-2-build/bin/filebeat-linux-arm
    cp ~/beats4pi/heartbeat    ~/docker-beats-2-build/bin/heartbeat-linux-arm

    ### copy config templates into build folder
    cp ~/docker-beats-1-sources/beats/metricbeat/metricbeat.yml           ~/docker-beats-2-build/config/
    cp ~/docker-beats-1-sources/beats/metricbeat/metricbeat.reference.yml ~/docker-beats-2-build/config/
    cp ~/docker-beats-1-sources/beats/heartbeat/heartbeat.yml             ~/docker-beats-2-build/config/
    cp ~/docker-beats-1-sources/beats/heartbeat/heartbeat.reference.yml   ~/docker-beats-2-build/config/
    cp ~/docker-beats-1-sources/beats/filebeat/filebeat.yml               ~/docker-beats-2-build/config/
    cp ~/docker-beats-1-sources/beats/filebeat/filebeat.reference.yml     ~/docker-beats-2-build/config/
    

    ## build
    cd ~/docker-beats-2-build; docker build -t sejnub/beats:rpi-latest .


### Push the image

    docker login
    docker push sejnub/beats:rpi-latest
    

### Run beats (WIP, not working by now)

Run an interactive bash

    docker rm -f beats; docker run -it --name beats sejnub/beats:rpi-latest bash

Then inside the container run

    metricbeat -path.config /etc/metricbeat 
    
    nano /etc/metricbeat/metricbeat.hb.yml
    
    
Just for information. There is an X86 docker image which can be run with

    sudo docker run -v /media/sf_shared-with-virtualbox/filebeat.hb1.yml:/filebeat.yml prima/filebeat:5

