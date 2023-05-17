FROM ubuntu:22.04

MAINTAINER Chandan

RUN apt-get update && apt-get upgrade -y \
	curl \
	iproute2 \
	sshfs \
	unzip \
	less \
	groff
	
RUN mkdir -p /chandan \
	&& curl -LO https://dl.k8s.io/release/v1.23.6/bin/linux/amd64/kubectl
	
RUN curl -LO https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip \
	&& unzip awscli-exe-linux-x86_64.zip -d /chandan \
	&& ./chandan/aws/install
	
WORKDIR /chandan
