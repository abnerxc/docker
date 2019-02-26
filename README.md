项目引用自github[1:]https://github.com/yeszao/dnmp dnmp 
# dnmp
Docker 一键部署 Nginx MySQL PHP7, 支持全功能特性,多种服务合集

#![Demo Image](./dnmp.png)

### 特点
1. 完全开放源代码
2. 支持多个PHP版本（php5.4，php5.6，php7.2）开关。
3. 支持多域名
4. 支持 HTTPS 和 HTTP/2.
5. PHP项目宿主机挂载.
6. MySQL数据宿主机挂载.
7. 所有配置文件宿主机挂载.
8. 所有日志宿主机挂载.
9. 内置PHP扩展安装命令.


### 用法
1. 安装 `git`, `docker` and `docker-compose`;
    - docker-compose国内安装
    ```
    sudo curl -L https://get.daocloud.io/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /docker
    sudo chmod +x /docker
    ```
2. 克隆项目:
    ```
    $ git clone https://github.com/yeszao/dnmp.git
    ```
4. 启动 docker-compose:
    ```
    $ docker-compose up
    ```
5. 浏览器打开 `localhost`, 可以看见:

![Demo Image](snapshot.png)

文件所在位置 `./www/site1/`.

### 其他版本PHP?
默认使用PHP版本:
```
$ docker-compose up
```
使用其他版本PHP:
```
$ docker-compose -f docker-compose54.yml up
$ docker-compose -f docker-compose56.yml up
```
我们不需要改变任何其他文件，如Nginx的配置文件或php.ini，一切将在当前环境下精细的工作（除了代码兼容性错误）。

> Notice: We can only start one php version, for they using same port. We must STOP the running project then START the other one.

### HTTPS and HTTP/2
默认站点配置:
* http://www.site1.com (same with http://localhost)
* https://www.site2.com

 hosts文件修改 (at `/etc/hosts` on Linux and `C:\Windows\System32\drivers\etc\hosts` on Windows):
```
127.0.0.1 www.site1.com
127.0.0.1 www.site2.com
```





## linux极限内存系统技巧说明
1.  安装系统实用了boot2docker.ios 内存系统
2.  系统自带了docker环境但是没有安装docker-compose，使用本git目录下的docker-compose即可实现
3.  系统没有root密码无法使用ssh登陆，可切换到docker/tcuser 账号密码登陆