IMAGE=mast-fozz
VERSION=1.0

docker-build: Dockerfile
	env BUILDKIT_PROGRESS=plain \
	  docker build $(REBUILDFLAGS) -f Dockerfile \
	    --rm -t $(IMAGE):$(VERSION) -t $(IMAGE):latest .

rebuild:
	make REBUILDFLAGS="--no-cache"
