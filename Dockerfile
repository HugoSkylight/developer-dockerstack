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
    
    # 删除包管理工具的缓存  rm -rf  /var/lib/apt/lists/*




