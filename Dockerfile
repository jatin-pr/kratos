FROM --platform=linux/amd64 golang:1.17.5-buster as builder

WORKDIR /build

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
    make \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/ory/kratos.git .

RUN make install

FROM --platform=linux/s390x debian:buster-slim

COPY --from=builder /usr/local/bin/kratos /usr/local/bin/kratos

EXPOSE 4434

CMD ["kratos", "serve", "config.yml"]

