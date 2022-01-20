FROM golang:1.14.6-alpine3.12 as builder
COPY go.mod go.sum /Users/nuna/DEVELOPMENT/go_workspace/src/github.com/teten-nugraha/go-chi-simple/
WORKDIR /Users/nuna/DEVELOPMENT/go_workspace/src/github.com/teten-nugraha/go-chi-simple
RUN go mod download
COPY . /Users/nuna/DEVELOPMENT/go_workspace/src/github.com/teten-nugraha/go-chi-simple
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o build/go-chi-simple github.com/teten-nugraha/go-chi-simple

FROM alpine
RUN apk add --no-cache ca-certificates && update-ca-certificates
COPY --from=builder /Users/nuna/DEVELOPMENT/go_workspace/src/github.com/teten-nugraha/go-chi-simple/build/go-chi-simple /usr/bin/go-chi-simple
EXPOSE 8080 8080
ENTRYPOINT ["/usr/bin/go-chi-simple"]