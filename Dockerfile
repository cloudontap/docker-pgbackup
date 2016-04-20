FROM debian:jessie

RUN apt-get update && apt-get install -y --no-install-recommends \
        postgresql-client curl less groff jq python python-pip \
        && rm -rf /var/lib/apt/lists/* \
	&& apt-get clean -y
        && pip install --upgrade awscli s3cmd \
        && mkdir /root/.aws

COPY get-metadata /usr/local/bin/get-metadata

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
