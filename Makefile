export MIRROR_URL := https://pypi.tuna.tsinghua.edu.cn/simple/

build:
	docker build \
		-t pypi-mirror \
		-f config/Dockerfile .


up:
	docker run -itd --rm \
	--name pypi-mirror \
	-p 0.0.0.0:8080:3141 \
	-v $$(pwd)/cache:/cache \
	-e MIRROR_URL=$(MIRROR_URL) \
	-e CACHE_DIR=/cache \
	pypi-mirror

down:
	docker stop pypi-mirror

sh:
	docker run -it --rm \
	--name pypi-mirror \
	--entrypoint /bin/sh \
	pypi-mirror

# testcases
test-devpi:
	docker run -it --rm \
	--name test-pypi-mirror \
	-e MIRROR_URL=$(MIRROR_URL) \
	-e CACHE_DIR=/cache \
	pypi-mirror

test-userdefine-command:
	docker run -it --rm \
	--name test-pypi-mirror \
	-e MIRROR_URL=$(MIRROR_URL) \
	-e CACHE_DIR=/cache \
	-e COMMAND="--include-mirrored-files --serverdir=/cache --proxy-timeout=10 --host=0.0.0.0" \
	pypi-mirror