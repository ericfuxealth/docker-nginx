all: build

build:
	@docker build --tag=xealth/nginx-stream .

release: build
	@docker build --tag=sameersbn/nginx:$(shell cat VERSION) .

push: build
	@docker push xealth/nginx-stream
