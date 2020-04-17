FROM i386/ubuntu:14.04
EXPOSE 27015/udp
RUN apt-get update && \
	apt-get install -y gcc unzip realpath nano && \
	useradd -m -d /home/cs -s /bin/bash cs
COPY ./files /home/cs
RUN bash -c "cd /home/cs/ ; bash ./install.sh" && \
	chown cs:cs /home/cs -R 
USER cs
CMD bash /home/cs/hlds_l/start.sh
