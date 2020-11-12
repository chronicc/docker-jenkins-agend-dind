FROM jenkins/inbound-agent

USER root
RUN apt update \
    && apt install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    && apt update \
    && apt install -y docker-ce docker-ce-cli containerd.io

RUN usermod -aG docker jenkins

USER jenkins

