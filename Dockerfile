FROM golang:1.25 AS builder

WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 go build -o smokeping_prober

FROM scratch

COPY --from=builder /app/smokeping_prober /bin/

VOLUME [ "/config" ]
ENV GOMAXPROCS=1
EXPOSE 9374
ENTRYPOINT  [ "/bin/smokeping_prober" ]
CMD [ "--config.file", "/config/config.yml" ]
