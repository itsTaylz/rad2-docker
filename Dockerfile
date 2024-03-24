FROM ubuntu AS unzipper

RUN apt-get update && apt-get install -y wget unzip

WORKDIR /tmp

RUN wget https://mediafilez.forgecdn.net/files/5063/450/RAD2-Serverpack-1.9.zip

RUN unzip RAD2-Serverpack-1.9.zip

FROM adoptopenjdk/openjdk8

COPY --from=unzipper /tmp/RAD2-Serverpack-1.9 /srv/RAD2

WORKDIR /srv/RAD2

EXPOSE 25565

RUN rm eula.txt && echo "eula=true" > eula.txt

RUN chmod +x LaunchServer.sh

CMD [ "./LaunchServer.sh" ]