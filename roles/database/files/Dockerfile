FROM debian:bookworm-slim

RUN apt update && apt -y install mariadb-server

COPY ./script.sh /tmp/script.sh

RUN chmod +x /tmp/script.sh

ENTRYPOINT ["/bin/bash", "/tmp/script.sh"]