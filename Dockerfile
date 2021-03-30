FROM kong/go-plugin-tool:2.0.4-alpine-latest AS builder

RUN mkdir -p /tmp/key-checker/

COPY . /tmp/key-checker/

RUN cd /tmp/key-checker/ && \
    go get github.com/Kong/go-pdk && \
    go mod init kong-go-plugin && \
    go get -d -v github.com/Kong/go-pluginserver && \
    go build github.com/Kong/go-pluginserver && \
    go build -buildmode plugin key-checker.go

FROM kong:2.0.4-alpine

RUN mkdir /tmp/go-plugins
COPY --from=builder  /tmp/key-checker/go-pluginserver /usr/local/bin/go-pluginserver
COPY --from=builder  /tmp/key-checker/key-checker.so /tmp/go-plugins
COPY config.yml /tmp/config.yml

USER root
RUN chmod -R 777 /tmp
RUN /usr/local/bin/go-pluginserver -version && \
    cd /tmp/go-plugins && \
    /usr/local/bin/go-pluginserver -dump-plugin-info key-checker
USER kong