IMAGE=oreshinya/cookie_auth_proxy
VERSION=1.0.2

.PHONY: build
build:
	docker build -t ${IMAGE}:${VERSION} . --platform linux/amd64

.PHONY: up
up:
	docker run --env-file .env.local -p 8100:8100 ${IMAGE}:${VERSION}

.PHONY: push
push:
	docker push ${IMAGE}:${VERSION}
