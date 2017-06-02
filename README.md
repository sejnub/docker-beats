# docker-beats (WIP)


### Status 
Work in progress: This repository is worthless for anybody but me just now.


### TODO

* Remove installation of commodity software from Dockerfile
* Create mechanism to run the image with a specified configuration
* Switch to a smaller base image like e.g. alpine (look at hypriot)


### Run portainer

    sudo docker start portainer

or

    sudo docker rm -f portainer; sudo docker run -d -p 9000:9000 -v "/var/run/docker.sock:/var/run/docker.sock" --name portainer portainer/portainer


### Build image 
Have a look for newer binaries at `https://beats-nightlies.s3.amazonaws.com/index.html?prefix=jenkins/` and then (with updated url's) do
    
    # clean up
    cd ~
    rm -rf ~/docker-beats-1-sources
    rm -rf ~/docker-beats-2-build
    rm -rf ~/docker-beats-3-run
    
    
    # prepare
    cd ~; mkdir temp; mkdir docker-beats-1-sources;
    
    # load sources into ~/docker-beats-1-sources
    
    ## this is needed only for the config files
    cd ~/docker-beats-1-sources; rm -rf beats; git clone https://github.com/elastic/beats.git
    
    ## these are the executables
    cd ~/temp/docker-beats-sources; wget https://beats-nightlies.s3.amazonaws.com/jenkins/metricbeat/946-1b2d67afd23f52274ec20c5c487a49074ffb7a69/metricbeat-linux-arm 
    cd ~/temp/docker-beats-sources; wget https://beats-nightlies.s3.amazonaws.com/jenkins/heartbeat/251-1b2d67afd23f52274ec20c5c487a49074ffb7a69/heartbeat-linux-arm
    cd ~/temp/docker-beats-sources; wget https://beats-nightlies.s3.amazonaws.com/jenkins/filebeat/1373-1b2d67afd23f52274ec20c5c487a49074ffb7a69/filebeat-linux-arm
    

    # clone rep (sejnub/docker-beats) and copy sources (executables and configs) into ~/temp/docker-beats

    cd ~/temp; rm -rf docker-beats; git clone https://github.com/sejnub/docker-beats.git

    cp ~/temp/docker-beats-sources/metricbeat-linux-arm     ~/temp/docker-beats/beat-bin-and-config/
    cp ~/temp/docker-beats-sources/heartbeat-linux-arm      ~/temp/docker-beats/beat-bin-and-config/
    cp ~/temp/docker-beats-sources/filebeat-linux-arm       ~/temp/docker-beats/beat-bin-and-config/

    cp ~/temp/docker-beats-sources/beats/metricbeat/metricbeat.yml       ~/temp/docker-beats/beat-bin-and-config/
    cp ~/temp/docker-beats-sources/beats/metricbeat/metricbeat.full.yml  ~/temp/docker-beats/beat-bin-and-config/
    cp ~/temp/docker-beats-sources/beats/heartbeat/heartbeat.yml         ~/temp/docker-beats/beat-bin-and-config/
    cp ~/temp/docker-beats-sources/beats/heartbeat/heartbeat.full.yml    ~/temp/docker-beats/beat-bin-and-config/
    cp ~/temp/docker-beats-sources/beats/filebeat/filebeat.yml           ~/temp/docker-beats/beat-bin-and-config/
    cp ~/temp/docker-beats-sources/beats/filebeat/filebeat.full.yml      ~/temp/docker-beats/beat-bin-and-config/
    
    # build
    cd ~/temp/docker-beats; docker build -t sejnub/beats:rpi-latest .


### Push the image 

    docker login
    docker push sejnub/beats:rpi-latest
    

### Run beats

Run an interactive bash

    docker rm -f beats; docker run -it --name beats sejnub/beats:rpi-latest bash

Then inside the container run

    metricbeat -path.config /etc/metricbeat 
    
    nano /etc/metricbeat/metricbeat.hb.yml
    
    
Just for information. There is an X86 docker image which can be run with

    sudo docker run -v /media/sf_shared-with-virtualbox/filebeat.hb1.yml:/filebeat.yml prima/filebeat:5


    eof



### In browser

    eof
 
 
 
 
 
 
eof
