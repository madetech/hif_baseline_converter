docker-build:
	docker-compose build

convert:
	docker-compose run --rm converter ./bin/baseline_converter $(BASELINE) $(URL)

shell:
	docker-compose run --rm converter

test:
	docker-compose run --rm converter bundle exec guard
