FROM golang:1.23-alpine AS build

WORKDIR /app

ENV GO111MODULE=on
ENV GOOS=linux
ENV GOARCH=amd64

COPY . .

RUN go mod download
RUN go build -o go-api

FROM alpine:3.14

WORKDIR /app

RUN adduser -D user

COPY --from=build /app/go-api ./go-api

RUN chown user:user go-api

USER user
EXPOSE 3000

CMD ["./go-api"]
