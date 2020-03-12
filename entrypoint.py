#!/usr/bin/env python
# -*- coding: utf-8 -*-

from os import environ
import devpi_server

DEFAULT_MIRROR_URL = "https://pypi.org/simple/"
PATCH_FILE = f"{environ['patch_file']}"

fin = open(PATCH_FILE, "rt")
data = fin.read()
data = data.replace(f"{DEFAULT_MIRROR_URL}", f"{environ['MIRROR_URL']}")
fin.close()

fin = open(PATCH_FILE, "wt")
fin.write(data)
fin.close()
