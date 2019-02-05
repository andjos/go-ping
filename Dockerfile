
# STEP 1 build executable binary
FROM golang:latest as builder

# Create gouser - will be used later for higher security
RUN useradd -M -U gouser

#Copy source
WORKDIR /go/src/go-ping
COPY go-ping.go  .

#Get Deps
RUN go get -d -v

#build the binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -ldflags="-w -s" -o /go/bin/go-ping


# STEP 2 build a small image
# start from scratch
FROM scratch

COPY --from=builder /etc/passwd /etc/passwd

# Copy our static executable
COPY --from=builder /go/bin/go-ping /go/bin/go-ping

EXPOSE 8080/TCP
USER gouser
ENTRYPOINT ["/go/bin/go-ping"]
