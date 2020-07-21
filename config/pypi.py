#!/usr/bin/env python
# -*- coding: utf-8 -*-

from os import environ, path, listdir

from devpi_server import main as app
from devpi_server.init import init as init_app

split_print = lambda x: print(x + "\n" + "=" * 50)
DEFAULT_MIRROR_URL = "https://pypi.tuna.tsinghua.edu.cn/simple/"
MIRROR_URL = environ.get("MIRROR_URL", DEFAULT_MIRROR_URL)

split_print("")
split_print(f"[*] Get current pypi mirror from env: {MIRROR_URL}")

# Hard Patch
COED_MIRROR_URL = "https://pypi.org/simple/"
MAIN_FILE = app.__file__

fin = open(MAIN_FILE, "rt")
data = fin.read()
data = data.replace(f"{COED_MIRROR_URL}", f"{MIRROR_URL}")
fin.close()

fin = open(MAIN_FILE, "wt")
fin.write(data)
fin.close()

# Soft Patch
app._pypi_ixconfig_default["mirror_url"] = f"{MIRROR_URL}"

CACHE_DIR = environ.get("CACHE_DIR", "/cache")
if not path.exists(CACHE_DIR) or not listdir(CACHE_DIR):
    init_command = f"--init " \
                   f"--serverdir={CACHE_DIR}"

    split_print(f"[Run init] command: {init_command}")
    init_app(argv=init_command.split(" "))

runtime_command = f"--include-mirrored-files " \
                  f"--serverdir={CACHE_DIR} " \
                  f"--proxy-timeout=10 " \
                  f"--host=0.0.0.0"

runtime_command = environ.get("COMMAND", runtime_command)
split_print(f"[*] Run devpi command: {runtime_command}")
app.main(runtime_command.split(" "))
