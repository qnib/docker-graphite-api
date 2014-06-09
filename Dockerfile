###### pure graphite-api
FROM qnib/terminal
MAINTAINER "Christian Kniep <christian@qnib.org>"

ADD yum-cache/graphite-api /tmp/yum-cache/graphite-api
RUN yum install -y /tmp/yum-cache/graphite-api/*

ADD etc/graphite-api.yaml /etc/graphite-api.yaml
RUN mkdir -p /var/lib/graphite

# gunicorn nginx
RUN yum install -y python-gunicorn nginx
ADD etc/nginx/nginx.conf /etc/nginx/nginx.conf
ADD etc/supervisord.d/graphite-api.ini /etc/supervisord.d/graphite-api.ini
ADD etc/supervisord.d/nginx.ini /etc/supervisord.d/nginx.ini


CMD /bin/supervisord -c /etc/supervisord.conf
