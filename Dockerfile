FROM golang:1.23-alpine AS builder

ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o cms-mail-service

FROM alpine:3.20

WORKDIR /app

COPY --from=builder /app/cms-mail-service .
COPY --from=builder /app/.env .
COPY --from=builder /app/helpers/mail_template.html ./helpers/

EXPOSE 8095

HEALTHCHECK CMD wget -qO- http://localhost:8095/health || exit 1

CMD ["./cms-mail-service"]
