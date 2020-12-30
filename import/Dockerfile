FROM golang:latest as builder
WORKDIR /go/src/github.com/zate/itip/import/
COPY main.go .
RUN go mod init github.com/Zate/itip/import && go mod tidy
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o intel-import .

FROM scratch
WORKDIR /
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /go/src/github.com/zate/itip/import/intel-import .
COPY feeds.yaml .
EXPOSE 8080
CMD ["/intel-import"]