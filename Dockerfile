FROM debian:wheezy

ENV PATH $PATH:/opt/nodejs/bin

ENV VERSION v0.12.0

RUN apt-get update
RUN apt-get install -y wget supervisor

RUN mkdir /opt/nodejs && \
	wget -O - "http://www.nodejs.org/dist/${VERSION}/node-${VERSION}-linux-x64.tar.gz" | tar --directory=/opt/nodejs --strip-components=1 -x -z

COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

WORKDIR /app
ONBUILD ADD package.json /app/
ONBUILD RUN npm install
ONBUILD ADD . /app

ENV NODE_ENV production

CMD []
ENTRYPOINT ["/usr/bin/supervisord"]
