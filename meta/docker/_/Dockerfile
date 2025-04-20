FROM debian:stable-slim AS pocketbase-downloader
RUN apt-get update && apt-get install -y curl unzip
WORKDIR /wd
COPY .pb-version .pb-version
COPY ./meta/pocketbase ./meta/pocketbase
RUN ./meta/pocketbase/install.sh
RUN bash -c 'source ./meta/pocketbase/config.sh && cp $PB_BIN pocketbase'

FROM debian:stable-slim AS release
WORKDIR /app
COPY --from=pocketbase-downloader /wd/pocketbase pocketbase
COPY src/server/pb_migrations src/server/pb_migrations
CMD [ "./pocketbase", "--dir", "/data" , "serve", "--http", "0.0.0.0:80" ]
