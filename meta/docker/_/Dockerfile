ARG NODE_VERSION="0.0.0"

FROM debian:stable-slim AS pocketbase-downloader
RUN apt-get update && apt-get install -y curl unzip
WORKDIR /wd
COPY .pb-version .pb-version
COPY ./meta/pocketbase ./meta/pocketbase
RUN ./meta/pocketbase/install.sh
RUN bash -c 'source ./meta/pocketbase/config.sh && cp $PB_BIN pocketbase'

FROM node:${NODE_VERSION}-slim AS ui-builder
WORKDIR /wd
COPY src/ui/package.json src/ui/package.json
COPY src/ui/package-lock.json src/ui/package-lock.json
RUN cd src/ui && npm ci
COPY src/ui/src src/ui/src
COPY src/ui/builder.mjs src/ui/builder.mjs
COPY src/ui/tsconfig.json src/ui/tsconfig.json
ARG HP_VERSION
ENV HP_VERSION="$HP_VERSION"
RUN cd src/ui && node builder.mjs build

FROM debian:stable-slim AS release
WORKDIR /app
COPY --from=pocketbase-downloader /wd/pocketbase pocketbase
COPY --from=ui-builder /wd/src/ui/dist pb_public
COPY src/server/pb_migrations pb_migrations
CMD [ "./pocketbase", "--dir", "/data", "--migrationsDir", "/app/pb_migrations", "serve", "--http", "0.0.0.0:80" ]
