# docker-beats (WIP)

### Status 
Work in progress: This repository is worthless for anybody but me just now.

### TODO

* Remove installation of commodity software from Dockerfile
* Create mechanism to run the image with a specified configuration

### Run portainer

    sudo docker start portainer

or

    sudo docker rm -f portainer; sudo docker run -d -p 9000:9000 -v "/var/run/docker.sock:/var/run/docker.sock" --name portainer portainer/portainer



### Build image 
Have a look for newer binaries at `https://beats-nightlies.s3.amazonaws.com/index.html?prefix=jenkins/` and then (with updated url's) do

    # prepare
    cd ~; mkdir temp; mkdir temp/docker-beats-sources;
    
    # load sources
    cd ~/temp/docker-beats-sources; rm -rf beats; git clone https://github.com/elastic/beats.git

    cd ~/temp/docker-beats-sources; wget https://beats-nightlies.s3.amazonaws.com/jenkins/metricbeat/809-7d8a21178383c283aabf8e4e6d8a1c28b55b2cd1/metricbeat-linux-arm 
    cd ~/temp/docker-beats-sources; wget https://beats-nightlies.s3.amazonaws.com/jenkins/heartbeat/99-50dc1c71367c871ff065390e2ab6fab2f4956c57/heartbeat-linux-arm
    cd ~/temp/docker-beats-sources; wget https://beats-nightlies.s3.amazonaws.com/jenkins/filebeat/1236-7d8a21178383c283aabf8e4e6d8a1c28b55b2cd1/filebeat-linux-arm
    

    cd ~/temp; rm -rf docker-beats; git clone https://github.com/sejnub/docker-beats.git


    cd ~/temp/docker-beats; docker build -t sejnub/beats:rpi-latest .

    eof


### Run filebeat

Run an interactive bash

    docker rm -f beats; docker run -it --name beats sejnub/beats:rpi-latest bash



    sudo docker run -v /media/sf_shared-with-virtualbox/filebeat.hb1.yml:/filebeat.yml prima/filebeat:5
    eof



### In browser

    eof
 
 
 
 
 
 
eof
