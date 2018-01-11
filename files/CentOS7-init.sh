#!/bin/bash

# init script to do stuff post kickstart

# setup archive dir
mkdir -p /root/archive

# setup local repo
mv /etc/yum.repos.d/CentOS-Base.repo /root/archive/
curl ftp://youromdina/config/CentOS-Base.repo -o /etc/yum.repos.d/CentOS-Base.repo

# handle yum & update
yum clean all
yum makecache
yum -y update
