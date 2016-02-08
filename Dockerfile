###### pure graphite-api
FROM qnib/alpn-syslog

ADD etc/init.d/graphite-api /etc/init.d/
RUN apk update && \
    # Graphite-API
    apk add py-pip libffi-dev gcc python-dev musl-dev cairo && \
    pip install --upgrade pip && \
    pip install graphite-api && \
    ln -s /etc/init.d/graphite-api /etc/runlevels/default/ && \
    mkdir -p /var/lib/graphite && \
	# gunicorn & nginx
    apk add py-gunicorn nginx && \
    ln -s /etc/init.d/nginx /etc/runlevels/default/ && \
    # Remove some stuff - should be even less
    apk del gcc libffi-dev binutils binutils-libs musl-dev python-dev  && \
    rm -rf /var/cache/apk/*
ADD etc/graphite-api.yaml /etc/graphite-api.yaml

ADD etc/nginx/nginx.conf /etc/nginx/nginx.conf
ADD etc/consul.d/graphite-api.json /etc/consul.d/
ADD etc/nginx/conf.d/graphite-api.conf /etc/nginx/conf.d/
