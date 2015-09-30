###### pure graphite-api
FROM qnib/terminal:fd22

RUN dnf install -y libffi-devel cairo && \
    curl -fsL test.tar.gz https://codeload.github.com/Dieterbe/graphite-api/legacy.tar.gz/support-templates2|tar xzf - -C /opt/ && \
    cd /opt/Dieterbe-graphite-api-b3f3cee/ && \
    python setup.py install

ADD etc/graphite-api.yaml /etc/graphite-api.yaml
RUN mkdir -p /var/lib/graphite

## Diamond
ADD etc/diamond/collectors/NginxCollector.conf /etc/diamond/collectors/NginxCollector.conf

# gunicorn nginx
RUN dnf install -y python-gunicorn nginx
ADD etc/nginx/nginx.conf /etc/nginx/nginx.conf
ADD etc/nginx/conf.d/*.conf /etc/nginx/conf.d/
ADD etc/supervisord.d/*.ini /etc/supervisord.d/
ADD etc/consul.d/*.json /etc/consul.d/
