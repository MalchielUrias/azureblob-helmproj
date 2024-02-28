FROM golang:1.21.3-alpine AS Build

# Set destination for COPY
WORKDIR /getblob

# Download Go modules
COPY go.mod go.sum ./

RUN go mod download

COPY . .

# Build
RUN CGO_ENABLED=0 GOOS=linux go build -o /getblob/build/getblob-app

# New Stage

FROM alpine:latest

COPY --from=Build /getblob/build/getblob-app /app/getblob

EXPOSE 8080

# CMD [ "/getblob/build/getblob-app" ]

# Set entrypoint
ENTRYPOINT ["/app/getblob"]