FROM ubuntu:20.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ARG DEBIAN_FRONTEND=noninteractive

# Tini init
#ARG TINI_VERSION=v0.19.0
#ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
#RUN chmod +x /tini

RUN /usr/bin/apt-get update && \
	/usr/bin/apt-get upgrade -y && \
	/usr/bin/apt-get install -y \
  curl \
  sudo \
  pulseaudio \
  xvfb \
  libnss3-tools \
  ffmpeg \
  xdotool \
  unzip \
  libfontconfig \
  libfreetype6 \
  xfonts-cyrillic \
  xfonts-scalable \
  fonts-liberation \
  fonts-ipafont-gothic \
  fonts-wqy-zenhei \
  wget \
  libgconf-2-4 \
  python3 \
  python3-pip

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get -y update
RUN apt-get install -y google-chrome-stable
RUN wget -O /tmp/chromedriver.zip https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/116.0.5845.96/linux64/chromedriver-linux64.zip
RUN unzip /tmp/chromedriver.zip chromedriver-linux64/chromedriver -d /usr/local/bin/

# For debugging with VNC
EXPOSE 5900

WORKDIR /

RUN mkdir /output && chmod 777 /output

COPY requirements.txt .
RUN pip3 install -r requirements.txt

COPY . .

#ENTRYPOINT ["/tini", "--", "bash", "./entrypoint.sh"]
CMD ["./entrypoint.sh"]