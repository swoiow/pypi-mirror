	FROM python:alpine

ARG MIRROR=mirrors.tuna.tsinghua.edu.cn
ARG SOURCES="/etc/apk/repositories"
RUN sed -i 's/http/https/g' $SOURCES \
    && sed -i 's/dl-cdn.alpinelinux.org/'$MIRROR'/g' $SOURCES

ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 /usr/local/bin/dumb-init
RUN chmod +x /usr/local/bin/dumb-init

COPY --from=caddy:alpine /usr/bin/caddy /usr/local/bin/caddy
RUN chmod +x /usr/local/bin/caddy

ARG DEVPI_VAR=5.4.0

WORKDIR /app

ARG MIRROR_URL=https://pypi.tuna.tsinghua.edu.cn/simple/
ENV MIRROR_URL=${MIRROR_URL}
ENV PIP_INDEX_URL=${MIRROR_URL}

RUN pip install --no-cache-dir \
    https://github.com/swoiow/libs/raw/master/cffi/cffi-1.14.0-cp38-cp38-linux_x86_64.whl \
    https://github.com/swoiow/libs/raw/master/argon2_cffi/argon2_cffi-19.2.0-cp38-cp38-linux_x86_64.whl && \
    pip install --no-cache-dir -q "devpi-server==${DEVPI_VAR}"

COPY config config
COPY entrypoint.sh entrypoint.sh

EXPOSE 80 443 3141

ENTRYPOINT ["dumb-init", "--"]

CMD ["/bin/sh", "entrypoint.sh"]

