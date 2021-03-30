# kong-go-plugin-sample

It adds an extra layer for security between consumers and producers. Consumers send a consumer-key in a query string and in this way we are able to identify the consumers. Without this parameter or wrong parameter won't be worked and they will get an error message regarding that.

We define the key for a specific consumer and it has to send this key as a query string. After that we are matching the key in query-string and pre-defined key in configuration file.
