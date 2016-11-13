FROM alpine:edge

ENV DATADIR=/data
RUN mkdir -p $DATADIR/podcasts
RUN mkdir -p $DATADIR/rss

# Base nonsense
RUN apk add --no-cache ruby
RUN apk add --no-cache ruby-dev
RUN apk add --no-cache nginx
RUN apk add --no-cache xmlstarlet
RUN apk add --no-cache bash
RUN apk add --no-cache cpulimit
RUN apk add --no-cache curl
RUN apk add --no-cache wget

# This stuff is needed to get and build external dependencies
RUN apk add --no-cache g++
RUN apk add --no-cache make
RUN apk add --no-cache git

# bro we need those install scripts
COPY install/* /opt/install-scripts/

# get_iplayer
RUN apk add --no-cache perl
RUN apk add --no-cache perl-dev
RUN apk add --no-cache expat-dev
RUN bash /opt/install-scripts/get_iplayer-deps.sh
RUN bash /opt/install-scripts/latest-get_iplayer.sh

# youtube-dl
RUN apk add --no-cache python
RUN apk add --no-cache ffmpeg
RUN apk add --no-cache rtmpdump
RUN apk add --no-cache py2-pip
RUN pip install --upgrade pip
RUN bash /opt/install-scripts/latest-mp4box.sh
RUN bash /opt/install-scripts/latest-youtube-dl.sh

# xidel
RUN bash /opt/install-scripts/xidel.sh

# Install some gems for supporting ruby scripts
RUN bash /opt/install-scripts/gems.sh

# This is for dev, you loser
RUN apk add --no-cache vim

# Copy over the podders themselves
COPY podders/iplayerpodder/* /opt/podders/iplayerpodder/
COPY podders/rinsefmpodder/* /opt/podders/rinsefmpodder/
COPY podders/soundcloudpodder/* /opt/podders/soundcloudpodder/
COPY podders/ytpodder/* /opt/podders/ytpodder/

# Copy over some of the utilities
COPY bin/make-rss /usr/bin/
RUN chmod +x /usr/bin/make-rss

COPY bin/clean-podcasts /usr/bin/
RUN chmod +x /usr/bin/clean-podcasts

COPY bin/podders /usr/bin/
RUN chmod +x /usr/bin/podders

COPY bin/print-data-header /usr/bin/
RUN chmod +x /usr/bin/print-data-header

COPY bin/yt2mp3 /usr/bin/
RUN chmod +x /usr/bin/yt2mp3

COPY bin/refresh-podcasts /usr/bin/
RUN chmod +x /usr/bin/refresh-podcasts

COPY bin/bs-soundcloud-client /usr/bin/
RUN chmod +x /usr/bin/bs-soundcloud-client

# Dat cronjob that makes it all happen
COPY cron/do_the_damn_thing.sh /etc/periodic/hourly/

# Dat cronjob that cleans up podcasts
COPY cron/clean_the_damn_thing.sh /etc/periodic/weekly/

# Make sure certain things are updated regularly
RUN ln -sf /opt/install-scripts/latest-youtube-dl.sh /etc/periodic/daily/
RUN ln -sf /opt/install-scripts/latest-get_iplayer.sh /etc/periodic/daily/
