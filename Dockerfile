FROM python:slim

ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 /usr/local/bin/dumb-init
RUN chmod +x /usr/local/bin/dumb-init

ARG DEVPI_VAR=5.4.0

ARG MIRROR_URL=https://pypi.tuna.tsinghua.edu.cn/simple/
ENV MIRROR_URL=${MIRROR_URL}
ENV PIP_INDEX_URL=${MIRROR_URL}
COPY patch.py /tmp/patch.py
RUN pip install -q --no-cache-dir "devpi-server==${DEVPI_VAR}" && \
    export patch_file=$(find /usr/local/lib -name "main.py"| grep devpi_server) && \
    python /tmp/patch.py

ENTRYPOINT ["dumb-init", "--"]
