FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    wget \
    curl \
    vim \
    git \
    sudo \
    software-properties-common \
    xfce4 \
    xfce4-goodies \
    xrdp \
    python3 \
    python3-pip \
    unzip \
    openjdk-17-jre \
    gnupg \
    ca-certificates \
    libxss1 \
    libappindicator1 \
    libgconf-2-4 \
    fonts-liberation \
    libasound2 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    xdg-utils \
    libu2f-udev \
    libvulkan1 \
    libxi6 \
    libxtst6 \
    libxrender1 \
    && apt-get clean

# Conf≠igure RDP (XRDP)

RUN sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config
RUN echo "xfce4-session" > /etc/skel/.xsession

# Install Firefox (Non-Snap Version)
RUN add-apt-repository ppa:mozillateam/ppa -y && \
    echo 'Package: *' > /etc/apt/preferences.d/mozilla-firefox && \
    echo 'Pin: release o=LP-PPA-mozillateam' >> /etc/apt/preferences.d/mozilla-firefox && \
    echo 'Pin-Priority: 1001' >> /etc/apt/preferences.d/mozilla-firefox && \
    apt-get update && apt-get install -y firefox

# Install Google Chrome
RUN apt install chromium-browser

# Install Selenium and WebDriver Manager
RUN pip3 install selenium webdriver-manager

# Install Burp Suite Community
WORKDIR /opt/BurpSuite
RUN curl -L "https://portswigger-cdn.net/burp/releases/download?product=community&version=2024.1.1.4&type=Jar" -o burpsuite.jar
RUN chmod +x burpsuite.jar
RUN echo '#!/bin/bash\njava -jar /opt/BurpSuite/burpsuite.jar "$@"' > /usr/bin/burpsuite
RUN chmod +x /usr/bin/burpsuite


# Create a Non-Root User with Sudo access
RUN useradd -m -s /bin/bash hacker && \
    echo "hacker:password" | chpasswd && \
    usermod -aG sudo hacker && \
    echo "xfce4-session" > /home/hacker/.xsession && \
    chown hacker:hacker /home/hacker/.xsession

# Setup Entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose RDP Port
EXPOSE 3389

ENTRYPOINT ["/entrypoint.sh"]
