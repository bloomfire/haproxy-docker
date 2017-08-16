#!/bin/sh
eval $(aws --profile production ecr get-login --no-include-email --region us-east-1) && \
docker build -t bloomfire/haproxy . && \
docker tag bloomfire/haproxy:latest 015984412802.dkr.ecr.us-east-1.amazonaws.com/bloomfire/haproxy:latest && \
docker push 015984412802.dkr.ecr.us-east-1.amazonaws.com/bloomfire/haproxy:latest && \
echo DONE
