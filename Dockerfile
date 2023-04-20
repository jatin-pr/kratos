# build stage
FROM golang:1.17 AS builder

RUN mkdir /build
WORKDIR /build

COPY . .

RUN make build-linux

# final stage
FROM --platform=linux/s390x debian@sha256:2b34dbd8a0e901d413b4f4bb30ee416fe0c4a4f4f9aefba84650f3cc3c3d3b71

COPY --from=builder /build/kratos /usr/local/bin/kratos

RUN make install

