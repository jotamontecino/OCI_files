.PHONY: build-node-dev
build-node-dev:
	./nodejs/nodejs-dev.sh
.PHONY: build-node-prod
build-node-prod:
	./nodejs/nodejs-prod.sh
.PHONY: build-node
build-node: build-node-dev build-node-prod