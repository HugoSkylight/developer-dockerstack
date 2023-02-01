# syntax=docker/dockerfile:experimental
FROM buildpack-deps:latest

COPY Python-3.9.10.tgz /tmp/Python-3.9.10.tgz
COPY go1.18.10.linux-amd64.tar.gz /tmp/go1.18.10.linux-amd64.tar.gz
COPY source.list /tmp/source.list


RUN \
    # 更换源
    rm -rf /etc/apt/sources.list && mv /tmp/source.list /etc/apt/sources.list \
    # 更新软件包
    && apt update && apt upgrade -y \
    # 安装依赖  -–no-install-recommends 来确保不会安装不需要的依赖项
    && apt install build-essential manpages-dev --no-install-recommends -y \
    # 删除包管理工具的缓存  rm -rf  /var/lib/apt/lists/*
    && rm -rf /var/lib/apt/lists/* \

RUN \
    # 安装常用工具包
    apt install vim wget curl git htop tmux how2 tldr powerline fish -y 


RUN \
    # 安装python
    cd /tmp && tar -zxvf Python-3.9.10.tgz \
    && cd Python-3.9.10 && ./configure --prefix=/usr/local/python3 --enable-optimizations --enable-shared \
    && make altinstall
    

RUN \
    # 安装go
    cd /tmp && tar -C /usr/local -zxvf go1.18.10.linux-amd64.tar.gz \
    && echo export PATH=$PATH:/usr/local/go/bin | sudo tee -a /etc/profile \
