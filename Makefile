dev:
	pnpm run dev

build:
	pnpm run build

deploy:
	docker-compose up --remove-orphans --build	