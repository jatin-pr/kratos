FROM golang:1.16-alpine

RUN apk --no-cache add ca-certificates git

WORKDIR /build

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=s390x go build -a -ldflags '-extldflags "-static"' -o /bin/kratos ./cmd/kratos

FROM scratch

COPY --from=0 /bin/kratos /bin/kratos

ENTRYPOINT ["/bin/kratos"]
