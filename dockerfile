FROM golang:1.17-alpine AS build

RUN apk add --no-cache git

WORKDIR /build

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=s390x go build -ldflags="-w -s" -o kratos ./cmd/kratos

FROM scratch

COPY --from=build /build/kratos /usr/local/bin/kratos

ENTRYPOINT [ "kratos" ]
