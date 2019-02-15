FROM golang:alpine AS builder

WORKDIR /go/src/icecast_exporter

RUN apk add --no-cache git

COPY . /go/src/icecast_exporter

RUN go get .

FROM alpine

COPY --from=builder /go/bin/icecast_exporter /icecast_exporter

EXPOSE 9100
USER nobody
ENTRYPOINT ["/icecast_exporter"]