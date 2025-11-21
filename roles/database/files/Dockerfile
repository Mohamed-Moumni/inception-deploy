FROM debian:bookworm-slim

RUN apt update && apt -y install mariadb-server

COPY ./script.sh /tmp/docker_build/script.sh

RUN chmod +x /tmp/docker_build/script.sh

ENTRYPOINT ["/bin/bash", "/tmp/docker_build/script.sh"]