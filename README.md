# pypi-mirror
本地 pypi 仓库镜像，可自定义上游镜像站 - local pypi mirror with custom mirror upstream.

### 快速搭建

`make build up`

或者

```
docker run -itd --rm \
--name pypi-mirror \
-p 0.0.0.0:3141:3141 \
-v $PWD/cache:/cache \
-e MIRROR_URL=https://pypi.tuna.tsinghua.edu.cn/simple/ \
-e CACHE_DIR=/cache \
pylab/pypi-mirror

```

### 常见的 PyPI 镜像源

  + ` https://pypi.tuna.tsinghua.edu.cn/simple/ `
  + ` https://mirrors.aliyun.com/pypi/simple/ `
  + ` https://pypi.doubanio.com/simple/ `

### 测试

+ 测试 pip 安装

    `pip install -i http://localhost:8080/root/pypi devpi-server`
    
+ 测试 images

    `make test-devpi`
    
    `make test-userdefine-command`

---

## devpi 指令

+ 初始化

`devpi-server --init --serverdir /cache`

+ 运行仓库

`devpi-server --include-mirrored-files --serverdir=/cache --proxy-timeout=10 --host=0.0.0.0 --port=80`


## Nginx Upstream

  ```
  location /simple/ {
      proxy_http_version 1.1;
      proxy_pass http://127.0.0.1:3141/root/pypi/;
  }
  ```


## Issue

### SSL error
  
  - 方法一：
  
    使用 `--trusted-host` 参数
    
    ``` pip install --trusted-host domain.com package-name```
    

  - 方法二：
    
    1. 购买域名 
    2. 使用[amce.sh](https://github.com/acmesh-official/acme.sh)生成证书 
    3. 用cloudflare设置dns到本地的机器。
  