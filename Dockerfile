FROM ubuntu/ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    apt-transport-https \
    apt-utils \
    ca-certificates \
    curl \
    git \
    gnupg-agent \
    gpg-agent \
    iputils-ping \
    jq \
    lsb-release \
    openssh-client \
    openssl \
    dnsutils\
    rsync\
    unzip \
    wget \
    zip \
    software-properties-common \
    mysql-client \
    tree \
    python3-yaml \
    python3-pip \
    vim \
    skopeo


# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash && \
    az --version

# Install azure identity
RUN pip install --no-cache-dir --upgrade pip && pip install azure-identity && pip install azure-containerregistry && pip install redis


# Clean system
RUN apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/*  \
 && rm -rf /var/cache/apk/* \
 && rm -rf /etc/apt/sources.list.d/*

# Can be 'linux-x64', 'linux-arm64', 'linux-arm', 'rhel.6-x64'.
ENV TARGETARCH=linux-x64