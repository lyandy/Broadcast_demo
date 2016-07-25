# Broadcast_demo
One demo to show how to implement video broadcast And how to configure RTMP server on Linux

### __Reference__

* __IJKMediaFramework__

  We use this framework to pull RTMP video stream. You need to compile the framework by its source codes. You can also download it that I have compiled from [this link](http://pan.baidu.com/s/1gf9Fajp).

* __LFLiveKit__

  We use this framework to push RTMP video stream.


---

### Server Configure on Linux

_The linux version is Ubuntu lastest released_

`sudo -i`

`apt-get update`

`cd ~`

`mkdir src`

`cd src/`

`wget http://nginx.org/download/nginx-1.11.2.tar.gz`

`wget http://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.37.tar.gz`

`apt-get install unzip`

`apt-get install zlib1g-dev`

`apt-get install openssl`

`apt-get install libssl-dev`

_Download the [nginx-rtmp-module](https://github.com/arut/nginx-rtmp-module)_    

`mv /home/andy/Downloads/nginx-rtmp-module-master.zip ./
`

`tar zvxf nginx-1.11.2.tar.gz`

`tar zvxf pcre-8.37.tar.gz`

`unzip nginx-rtmp-module-master.zip`

`./configure --with-pcre=../pcre-8.37 --add-module=../nginx-rtmp-module-master --with-http_ssl_module`

`make`

`make install`

`cd /usr/local/nginx/conf`

`vi nginx.conf`

_In the nginx.conf file, add the codes below the last `"}"`_

    rtmp {
      server {
        listen 1935;
        application rtmplive {
          live on;
          record off;
        }
      }
    }

_Add the specific port in the firewall exceptions_

`sudo ufw allow 80/tcp`

`sudo ufw allow 1935/tcp`

_Start ngnix server_

`cd /usr/local/nginx/sbin/`

`./nginx`

---

### __You can also refer to these articals and git repositories below__

* [快速集成iOS基于RTMP的视频推流](http://www.jianshu.com/p/8ea016b2720e)

* [iOS视频直播初窥:高仿<喵播APP>](http://www.jianshu.com/p/b8db6c142aad)

* [nginx-rtmp-server](https://github.com/loonghere/nginx-rtmp-server)


---

### __Attention__

* When you pod `ReactiveCocoa` framework in Object-C project , the `LFLiveKit` framework failed to compile. More info just refer this issue discussion __[pod 引入 ReactiveCocoa 的时候，LFLiveKit编译失败 #18](https://github.com/LaiFengiOS/LFLiveKit/issues/18)__

* If you use CentOS or SuseOS as your lunix server, you need install gcc module addtionally. So please check before you install just as command `gcc --version`

### __Last__

Before you run , you need pod install first : ）
