FROM --platform=linux/s390x golang:1.17.5-alpine3.14 AS build
WORKDIR /build
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=s390x go build -a -ldflags '-extldflags "-static"' -o /bin/kratos ./cmd/kratos

FROM --platform=linux/s390x alpine:3.14
RUN apk --no-cache add ca-certificates
COPY --from=build /bin/kratos /bin/kratos
ENTRYPOINT ["/bin/kratos"]
