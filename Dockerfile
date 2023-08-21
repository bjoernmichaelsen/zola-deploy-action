FROM debian:bullseye-slim AS base

LABEL "com.github.actions.name"="Zola Deploy to Pages"
LABEL "com.github.actions.description"="Build and deploy a Zola site to GitHub Pages"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="green"

# Set default locale for the environment
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV ZOLA_VERSION v0.16.1
ENV ZOLA_FILENAME zola-v0.16.1-x86_64-unknown-linux-gnu.tar.gz

RUN apt-get update && apt-get install -y wget

FROM base as download
RUN wget -q \
"https://github.com/getzola/zola/releases/download/${ZOLA_VERSION}/${ZOLA_FILENAME}" 
COPY ${ZOLA_FILENAME}.sha1 /${ZOLA_FILENAME}.sha1
RUN sha1sum -c ${ZOLA_FILENAME}.sha1
RUN tar xzf ${ZOLA_FILENAME} -C /usr/local/bin

FROM base as runtime
RUN apt-get install -y git
COPY --from=download /usr/local/bin/zola /usr/local/bin
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
