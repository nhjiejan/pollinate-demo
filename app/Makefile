NAME=pollinate-demo
VERSION=$(shell git rev-parse HEAD)
REPO=nhjiejan
PYFILES = app
SEMVER_VERSION=$(shell cat VERSION)

clean:
	rm -rf .eggs/ build/ dist/ logs/ *.egg-info/
	-find . -name '__pycache__' -prune -exec rm -rf "{}" \;
	-find . -name '*.pyc' -delete

lint:
	flake8 ${PYFILES}

format:
	yapf -r -i ${PYFILES}

build:
	docker build -t $(REPO)/$(NAME):$(VERSION) .

tag-latest: publish
	docker tag  $(REPO)/$(NAME):$(VERSION) $(REPO)/$(NAME):latest
	docker push $(REPO)/$(NAME):latest

publish: build
	@if docker run -e DOCKER_REPO=$(REPO)/$(NAME) -e DOCKER_TAG=$(VERSION) $(REPO)/$(NAME)/tag-exists; \
	  then echo "Tag $(VERSION) already exists!" && exit 1 ; \
	else \
	  docker push $(REPO)/$(NAME):$(VERSION); \
	fi

tag-semver: build
	docker tag $(REPO)/$(NAME):$(VERSION) $(REPO)/$(NAME):$(SEMVER_VERSION)
	@if docker run -e DOCKER_REPO=babylonhealth/$(NAME) -e DOCKER_TAG=$(VERSION) $(REPO)/$(NAME)/tag-exists; \
	  then echo "Tag $(VERSION) already exists!" && exit 1 ; \
	else \
	  docker push $(REPO)/$(NAME):$(SEMVER_VERSION); \
	fi

run:
	docker run \
		--name $(NAME) \
		-p 5000:5000 \
		-v $$(pwd):/opt/${NAME} \
		-d \
		$(REPO)/$(NAME):$(VERSION)