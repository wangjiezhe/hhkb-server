FROM golang:alpine
RUN apk update && \
    apk add curl && \
    curl -L "https://github.com/wangjiezhe/hhkb/archive/server.tar.gz" | gzip -d | tar xv && \
    cd hhkb-server && \
    env CGO_ENABLED=0 \
    go build -v -ldflags="-s -w" -o /hhkb

FROM alpine
COPY --from=0 /hhkb /hhkb
ENTRYPOINT /hhkb
