FROM cm2network/steamcmd:latest
LABEL maintainer="Zate <zate75@gmail.com>"

SHELL ["/bin/bash", "-c"]
USER root
WORKDIR /
RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y locales ca-certificates vim procps && \
    apt-get clean -y && \
    echo "${TZ}" > /etc/timezone && \
    locale-gen en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD entrypoint.sh .
USER steam
WORKDIR /home/steam
RUN /home/steam/steamcmd/steamcmd.sh \
    +login anonymous \
    +force_install_dir /home/steam/unturned \
    +app_update 1110390 \
    +quit
VOLUME /home/steam/unturned/Servers
# Need to copy Extras/Rock.Unturned to Modules/
EXPOSE 27015
EXPOSE 27016
EXPOSE 27017
ENTRYPOINT ["/entrypoint.sh"]
CMD ["unturned"]
#RUN /home/steam/unturned/Unturned_Headless.x86_64 -logfile 2>&1 -batchmode -nographics +LanServer/t-test
#  /home/steam/unturned/Unturned_Headless.x86_64 -logfile 2>&1 -batchmode -nographics +InternetServer/t-test
# docker run -it -v "$PWD":/gameserver/Servers/Dockerserver --env STEAM_USER=<username> --env STEAM_PWD=<password> ramdad/unturned:latest
