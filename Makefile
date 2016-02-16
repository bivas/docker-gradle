SHELL := /bin/bash

base-7:
	docker build -t bivas/gradle:7-onbuild -f Dockerfile.jdk7 .

base-8:
	docker build -t bivas/gradle:8-onbuild -f Dockerfile.jdk8 .

build-7: base-7
	for f in $$(ls | grep jdk7-gradle); do \
		pushd $$f ;\
		VERSION=$$(echo $$f | cut -f3 -d"-") ;\
		docker build -t bivas/gradle:7-$${VERSION} . ;\
		popd ;\
	done

build-8: base-8
	for f in $$(ls | grep jdk8-gradle); do \
		pushd $$f ;\
		VERSION=$$(echo $$f | cut -f3 -d"-") ;\
		docker build -t bivas/gradle:8-$${VERSION} . ;\
		popd; \
	done
