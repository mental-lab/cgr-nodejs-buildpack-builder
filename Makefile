REGISTRY      ?= ghcr.io/mental-lab
BUILD_IMAGE    = $(REGISTRY)/chainguard-node-build:latest
RUN_IMAGE      = $(REGISTRY)/chainguard-node-run:latest
BUILDER_LOCAL  = chainguard-node-builder:local

.PHONY: build-stack build-builder test push-stack clean

build-stack:
	docker build -t $(BUILD_IMAGE) -f stack/build.Dockerfile stack/
	docker build -t $(RUN_IMAGE) -f stack/run.Dockerfile stack/

build-builder: build-stack
	pack builder create $(BUILDER_LOCAL) --config builder.toml --pull-policy if-not-present

test: build-builder
	pack build test-node-cgr \
		--builder $(BUILDER_LOCAL) \
		--path test-app \
		--pull-policy if-not-present

push-stack:
	docker push $(BUILD_IMAGE)
	docker push $(RUN_IMAGE)

clean:
	-docker rmi $(BUILD_IMAGE) $(RUN_IMAGE) $(BUILDER_LOCAL) \
		test-node-cgr 2>/dev/null
