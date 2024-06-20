#!/bin/bash

docker build -t simlab-react-image:latest .

sleep 2;

docker tag simlab-react-image ablaamim/simlab-react-image

sleep 2;

docker push ablaamim/simlab-react-image

#docker login
