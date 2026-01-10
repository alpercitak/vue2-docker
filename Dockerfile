FROM node:25-alpine AS build

WORKDIR /app

RUN npm i -g pnpm
COPY pnpm-lock.yaml ./
RUN pnpm fetch

COPY package.json ./
RUN pnpm i --offline

COPY . .
RUN pnpm run build

FROM nginx:1.29.4-alpine-slim AS deploy

WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=build /app/dist .
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]