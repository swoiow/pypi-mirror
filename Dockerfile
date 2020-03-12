FROM python:slim

ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 /usr/local/bin/dumb-init
RUN chmod +x /usr/local/bin/dumb-init

ARG DEVPI_VAR=5.4.0

WORKDIR /app

ARG MIRROR_URL=https://pypi.tuna.tsinghua.edu.cn/simple/
ENV MIRROR_URL=${MIRROR_URL}
ENV PIP_INDEX_URL=${MIRROR_URL}

RUN pip install -q --no-cache-dir "devpi-server==${DEVPI_VAR}"

COPY entrypoint.py entrypoint.py

EXPOSE 3141

ENTRYPOINT ["dumb-init", "--"]

CMD ["python", "entrypoint.py"]
