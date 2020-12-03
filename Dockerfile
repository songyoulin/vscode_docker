FROM ubuntu:20.04

ENV PYTHONIOENCODING UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get clean && apt-get upgrade -y && apt-get update -y --fix-missing

# install tools
RUN apt-get -y install git mercurial build-essential gdb make astyle graphviz libevent-dev libjansson-dev wget tar htop vim tree net-tools curl

# slim down image
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man/?? /usr/share/man/??_*

# vscode
ENV VS_VERSION 3.7.4
ENV VS_PACKAGE code-server-${VS_VERSION}-linux-amd64
RUN cd / && wget https://github.com/cdr/code-server/releases/download/v${VS_VERSION}/${VS_PACKAGE}.tar.gz  && \
            tar zxvf ${VS_PACKAGE}.tar.gz && mv ${VS_PACKAGE} vscode && rm -rf ${VS_PACKAGE}.tar.gz

RUN mkdir -p /vsix

RUN cd /vsix && \
    wget https://github.com/microsoft/vscode-cpptools/releases/download/1.1.2/cpptools-linux.vsix

RUN /vscode/bin/code-server                                     \
        --install-extension /vsix/cpptools-linux.vsix           \
        --install-extension formulahendry.code-runner           \
        --install-extension coenraads.bracket-pair-colorizer    \
        --install-extension vscode-icons-team.vscode-icons      \
        --install-extension esbenp.prettier-vscode              \
        --install-extension chiehyu.vscode-astyle

RUN rm -rf /vsix

RUN  mkdir -p      /root/.local/share/code-server/User
COPY settings.json /root/.local/share/code-server/User/settings.json

RUN  mkdir -p      /vscode/data/User
COPY settings.json /vscode/data/User/settings.json 

WORKDIR /

EXPOSE 8080

CMD ["/bin/bash"]
