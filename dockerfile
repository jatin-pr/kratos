# Start from the official Golang image
# This image will pull the latest version of Golang
FROM golang:latest AS builder

# Set the current working directory inside the container
WORKDIR /build

# Copy the entire project directory into the container
COPY . .

# Download all dependencies
RUN go mod download

# Build the binary
RUN go build -o main .

# Start from a fresh Alpine image
FROM alpine:latest

# Copy the binary from the builder image into the Alpine image
COPY --from=builder /build/main /usr/bin/app

# Expose port 8080
EXPOSE 8080

# Set the entrypoint of the container to the binary
ENTRYPOINT ["app"]
