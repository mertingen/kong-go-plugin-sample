# kong-go-plugin-sample

It adds an extra layer for security between consumers and producers. Consumers send a consumer-key in a query string and in this way we are able to identify the consumers. Without this parameter or wrong parameter won't be worked and they will get an error message regarding that.

We define the key for a specific consumer and it has to send this key as a query string. After that we are matching the key in query-string and pre-defined key in configuration file.

```
docker build -t kong-demo .
```

Images are built and we can run them as containers.

```
docker run -ti --rm --name kong-go-plugins \
  -e "KONG_DATABASE=off" \
  -e "KONG_GO_PLUGINS_DIR=/tmp/go-plugins" \
  -e "KONG_DECLARATIVE_CONFIG=/tmp/config.yml" \
  -e "KONG_PLUGINS=key-checker" \
  -e "KONG_PROXY_LISTEN=0.0.0.0:8000" \
  -p 8000:8000 \
  kong-demo
```
