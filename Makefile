BINARY_NAME=smtp_exporter
export GOPATH                  ?= $(shell pwd)/go
DOCKER_IMAGE_TAG        ?= $(subst /,-,$(shell git rev-parse --abbrev-ref HEAD))


all: build strip
build:
# GOARCH=amd64 GOOS=linux go build -o ${BINARY_NAME}-linux main.go
#	GOARCH=amd64 GOOS=linux CGO_ENABLED=0 go build -o ${BINARY_NAME} -ldflags "-linkmode 'external' -extldflags '-static'"
	CGO_ENABLED=0 go build -o ${BINARY_NAME} -ldflags="-extldflags=-static"

clean:
	go clean

clean-mod:
	go clean -modcache
	@rm -rf ./go

strip:
	strip ${BINARY_NAME}

docker:
	docker build --no-cache -t local/smtp_exporter:${DOCKER_IMAGE_TAG} .
	docker image save local/smtp_exporter:${DOCKER_IMAGE_TAG} | gzip >smtp_exporter_${DOCKER_IMAGE_TAG}.tgz
	docker rmi local/smtp_exporter:${DOCKER_IMAGE_TAG}

.PHONY: all clean clean-mod strip docker
