env.production:
	@set -ex \
	; PGDIR=$$(grep "./postgr" docker-compose.yml | cut -d: -f1 | awk '{print $$2}') \
	; PGIMAGE=$$(grep 'image: postgres' docker-compose.yml | awk '{print $$2}') \
	; PGPASS=$$(cat /dev/urandom | tr -dc "a-zA-Z0-9" | fold -w 24 | head -n 1) \
	; mkdir -p $${PGDIR} \
	; docker run --rm --name postgres -v $${PWD}/$${PGDIR}:/var/lib/postgresql/data \
	    -e POSTGRES_PASSWORD=$${PGPASS} -d $${PGIMAGE} \
	; sleep 10 \
	; docker exec -it postgres psql -U postgres \
	    -c "CREATE USER mastodon WITH PASSWORD '$${PGPASS}' CREATEDB;" \
	; docker stop postgres \
	; sed -e "s/--PGPASS--/$${PGPASS}/" template-env > $@

mastodon-setup: env.production
	docker-compose run --rm web bundle exec rake mastodon:setup

docker-build:
	make -C docker
