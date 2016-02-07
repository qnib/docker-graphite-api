###### pure graphite-api
FROM qnib/alpn-terminal

RUN apk update && \
    apk add py-pip libffi-dev gcc python-dev musl-dev cairo && \
    pip install --upgrade pip && \
    pip install graphite-api && \
    mkdir -p /var/lib/graphite && \
    # Remove some stuff - should be even less
    apk del gcc libffi-dev #binutils binutils-libs musl-dev python-dev 

ADD etc/graphite-api.yaml /etc/graphite-api.yaml

# gunicorn nginx
ADD etc/init.d/graphite-api /etc/init.d/
RUN apk add py-gunicorn nginx && \
    ln -s /etc/init.d/nginx /etc/runlevels/default/ && \
    ln -s /etc/init.d/graphite-api /etc/runlevels/default/ && \
    rm -rf /var/cache/apk/*
ADD etc/nginx/nginx.conf /etc/nginx/nginx.conf
ADD etc/consul.d/graphite-api.json /etc/consul.d/
ADD etc/nginx/conf.d/graphite-api.conf /etc/nginx/conf.d/
#ADD etc/supervisord.d/graphite-api.ini /etc/supervisord.d/graphite-api.ini
#ADD etc/supervisord.d/nginx.ini /etc/supervisord.d/nginx.ini
