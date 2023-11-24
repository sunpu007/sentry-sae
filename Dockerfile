FROM centos:7

RUN yum install -y yum-utils && \
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
    yum install docker-ce docker-ce-cli containerd.io

RUN systemctl enable docker && systemctl start docker

RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

RUN chmod +x /usr/local/bin/docker-compose

RUN yum install -y git

RUN git clone https://github.com/getsentry/sentry.git

WORKDIR /onpremise

RUN cd onpremise && ./install.sh

EXPOSE 9000

RUN docker-compose up -d

