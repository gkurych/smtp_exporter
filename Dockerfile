ARG ARCH="amd64"
ARG OS="linux"
FROM quay.io/prometheus/busybox-${OS}-${ARCH}:latest
LABEL maintainer="Tester"

ARG ARCH="amd64"
ARG OS="linux"
COPY smtp_exporter  /bin/smtp_exporter
COPY smtp.yml       /etc/smtp_exporter/config.yml

EXPOSE     9125 
ENTRYPOINT  [ "/bin/smtp_exporter" ]
CMD         [ "--config.file=/etc/smtp_exporter/config.yml" ]

