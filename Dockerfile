FROM golang AS building

LABEL maintainer="medvedev.yp@gmail.com"

ENV exporter_version 0.17.0

RUN curl -LO https://github.com/prometheus/node_exporter/releases/download/v${exporter_version}/node_exporter-${exporter_version}.linux-amd64.tar.gz \
    && tar -xvzf node_exporter-${exporter_version}.linux-amd64.tar.gz  \
    && cp node_exporter-${exporter_version}.linux-amd64/node_exporter /tmp/

FROM alpine

COPY --from=building /tmp/node_exporter /usr/local/bin/

CMD ["/usr/local/bin/node_exporter"]
EXPOSE 9100
