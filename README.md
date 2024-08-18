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
sed -i 's/\r$//' install.sh

# docker代理
~/.docker/config.json
```json
{
  "proxies": {
    "default": {
      "httpProxy": "http://127.0.0.1:7890",
      "httpsProxy": "http://127.0.0.1:7890",
      "noProxy": "*.test.example.com,.example.org,127.0.0.0/8"
    }
  }
}
```

# VMware虚拟机nat地址映射
- 软件顶部编辑->虚拟网络编辑器->打开nat设置，选择NAT模式，修改子网IP:10.0.0.0
- 端口转发添加：网关ip 10.0.0.2
- 映射：10.0.0.128，端口22