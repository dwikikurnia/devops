FROM debian:stable-slim

ENV  TERRAFORM_VERSION=0.15.5

RUN  apt-get update && \
     apt-get install -y curl unzip && \
     curl -OL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
     unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
     mv terraform /usr/bin/ && \
     rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip
