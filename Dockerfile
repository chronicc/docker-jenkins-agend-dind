ARG PARENT_NAME
ARG PARENT_VERSION
FROM ${PARENT_NAME}:${PARENT_VERSION}

USER root

# Prepare image
RUN apt update \
    && apt install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common

# Install docker daemon
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    && apt update \
    && apt install -y docker-ce docker-ce-cli containerd.io

RUN usermod -aG docker jenkins

USER jenkins

