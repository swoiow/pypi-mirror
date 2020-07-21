#!/usr/bin/env bash

set -x;
#cp -f config/nginx/nginx.conf /etc/nginx/nginx.conf && \
#cp -f config/nginx/default.conf /etc/nginx/conf.d/default.conf && \
#nginx && \
caddy run -config config/caddy/Caddyfile && \
python config/pypi.py