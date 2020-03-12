# pypi-mirror
本地 pypi 仓库镜像，可自定义上游镜像站 - local pypi mirror with diy mirror upstream.

** 快速搭建 **
``
---

## devpi 指令

+ 初始化

`devpi-server --init --serverdir /cache`

+ 运行仓库

`devpi-server --include-mirrored-files --serverdir=/cache --proxy-timeout=10 --host=0.0.0.0 --port=80`
