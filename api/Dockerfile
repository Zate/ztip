FROM golang:latest as builder
WORKDIR /go/src/github.com/zate/itip/api/
ADD *.go ./
RUN ls -al
RUN go mod init github.com/Zate/itip/api && go mod tidy
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o itip

FROM bitnami/redis:6.0-debian-10

USER root
RUN mkdir /itip
WORKDIR /itip
COPY --from=builder /go/src/github.com/zate/itip/api/itip .
COPY geodb/GeoLite2-City.mmdb geodb/
COPY startup.sh .
RUN chmod 755 /itip/startup.sh 
RUN chown -R 1001:1001 /itip
USER 1001
EXPOSE 8080
CMD ["/itip/startup.sh"]