FROM golang:1.23-alpine AS builder

# Set the GOOS and GOARCH for cross-compilation
ENV GOOS=linux
ENV GOARCH=amd64

WORKDIR /app

COPY . .

RUN go build -o /bin/golang-docker

FROM debian:stable-slim

COPY --from=builder /bin/golang-docker /bin/golang-docker
ENV PORT=8080
CMD ["/bin/golang-docker"]
