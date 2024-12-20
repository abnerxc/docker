# dnmp
Docker 一键部署 Nginx MySQL PHP7, 支持全功能特性,多种服务合集

#![Demo Image](./dnmp.png)

### 特点
1. 完全开放源代码
2. 支持多个PHP版本（php5.6，php7.0，php7.2）开关，并安装了主流的PHP扩展和插件
3. 支持多域名
4. 支持 HTTPS 和 HTTP/2.
5. PHP项目宿主机挂载.
6. MySQL数据宿主机挂载.
7. 所有配置文件宿主机挂载.
8. 所有日志宿主机挂载.
9. 内置PHP扩展安装命令.
10. 增加对redis，mongodb,ES等的支持



### 用法
1. 安装 `git`, `docker` and `docker-compose`;
    - docker-compose国内安装
    ```
    sudo curl -L https://get.daocloud.io/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /docker
    sudo chmod +x /docker
    ```
2. 克隆项目:
    ```
    $ git clone https://github.com/abner-xu/docker
    ```
3. 启动 docker-compose:
    ```
    $ docker-compose up
    ```
4. 浏览器打开 `localhost`, 可以看见:

![Demo Image](snapshot.png)

文件所在位置 `./www/site1/`.

5. 多版本PHP版本运行:
```angular2html
location ~ \.php$ {
        fastcgi_pass   php72:9000;
        fastcgi_index  index.php;
        include        fastcgi_params;
        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
    }
```
php72即7.2版本容器名称，可以针对不同的域名配置不同的运行版本

### HTTPS and HTTP/2
默认站点配置:
* http://www.site1.com (same with http://localhost)
* https://www.site2.com

 hosts文件修改 (at `/etc/hosts` on Linux and `C:\Windows\System32\drivers\etc\hosts` on Windows):
```
127.0.0.1 www.site1.com
127.0.0.1 www.site2.com
```
# 引用说明
项目引用自github用户yeszao  https://github.com/yeszao/dnmp 在此基础上进行升级和扩展


#查看所有容器ip
```
alias jhm='docker-compose -f /mnt/e/work/docker/jhm.yml up -d'
alias jhm-rs='docker-compose -f /mnt/e/work/docker/jhm.yml restart'
alias jhm-rm='docker-compose -f /mnt/e/work/docker/jhm.yml stop && docker-compose -f /mnt/e/work/docker/jhm.yml rm'
alias jhm-ps='docker-compose -f /mnt/e/work/docker/jhm.yml ps'
alias docker-ips='docker inspect --format='"'"'{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"'"' $(docker ps -aq)'
```

# win传linux文件shell字符处理 
`sed -i 's/\r$//' install.sh && chmod +x install.sh`
`sed -i 's/\r$//' wsl.sh && chmod +x wsl.sh`

# docker代理
1、参考https://github.com/cmliu/CF-Workers-docker.io
2、本地自建
~/.docker/config.json
```json
{
  "proxies": {
    "default": {
      "httpProxy": "http://192.168.208.1:7890",
      "httpsProxy": "http://192.168.208.1:7890",
      "noProxy": "127.0.0.0/8"
    }
  }
}
```

# 文件拷贝
```shell
scp root@192.168.78.11:/etc/yum.repos.d/*.repo .
scp install.sh root@192.168.78.11:/root
```

# ubuntu
sudo免密码
```shell
sudo vim /etc/sudoers
abner  ALL=(ALL:ALL) NOPASSWD:ALL
```
ubuntu挂载
```shell
#手动挂载
sudo vmhgfs-fuse .host:/ ~ -o allow_other -o uid=1000
#自动挂载
vim /etc/fstab 最后追加
.host:/ ~ fuse.vmhgfs-fuse allow_other,defaults 0 0
```

# wsl2 迁移安装
```shell
查看: wsl --list --verbose
删除: wsl --unregister Ubuntu-22.04
导入: wsl --import Ubuntu-22.04 G:\wmos\Ubuntu-22.04 G:\wmos\Ubuntu-22.04.tar
导出: wsl --export Ubuntu-22.04 G:\wmos\Ubuntu-22.04.tar
```

