.PHONY: build
build:
	docker run \
		--rm \
		-v $(PWD)/work:/src \
		-u $(id -u):$(id -g) \
		trzeci/emscripten \
		emcc helloworld.cpp -s WASM=1 -o helloworld.html

.PHONY: run
run:
	docker run \
		--rm \
		-v $(PWD)/work:/work \
		-w /work \
		-it \
		node:14-alpine \
		node helloworld.js

.PHONY: web
web:
	docker run \
		--rm \
		-p 3000:80 \
		-v $(PWD)/work:/usr/share/nginx/html:ro \
		nginx:alpine