IMAGE=oreshinya/cookie_auth_proxy
VERSION=1.0.0

.PHONY: build
build:
	docker build -t ${IMAGE}:${VERSION} .

.PHONY: up
up:
	docker run --env-file .env.local -p 8100:8100 ${IMAGE}:${VERSION}
