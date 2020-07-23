---
layout: 'post'
title: '특정 버전의 레디스 설치'
description: ''
date: '2020-07-22 23:46:44'
categories:
  - Database
tags:
  - Redis
---

# 레디스 설치

> 아래 글은 `CentOS 7.7`, `Redis 4.0.14` 를 기준으로 작성되었습니다.

## 준비

레디스를 설치하기 위해 소스 파일을 다운로드 받습니다. (릴리즈 버전은 [여기](http://download.redis.io/releases/)에서 확인할 수 있습니다.)  
다운로드가 끝나면 아카이브를 푼 뒤, 해당 디렉토리로 이동합니다.

``` shell
# 설치 파일 다운로드
$ curl -O  http://download.redis.io/releases/redis-4.0.14.tar.gz

# 아카이브 풀기
$ tar -xvf redis-4.0.14.tar.gz

# 디렉토리 이동
$ cd redis-4.0.14
```

## 컴파일

다운로드 받은 소스를 컴파일을 하기 위해선 `make`, `cc` 명령어가 필요합니다.  


``` shell
# which 명령어로 설치돼 있는지 확인합니다. 아래와 같이 나오면 명령어가 설치돼 있습니다.
$ whcih make
/usr/bin/make
$ which cc
/usr/bin/cc


# 없다면 설치
$ yum install make
$ yum install gcc
```

이제 `make` 를 입력해 소스를 컴파일합니다.

``` shell
# 컴파일 시작
$ make

cd src && make all
make[1]: Entering directory `/home/test/redis-4.0.14/src'
    CC Makefile.dep
make[1]: *** Deleting file `Makefile.dep'

...

Hint: It's a good idea to run 'make test' ;)

make[1]: Leaving directory `/home/test/redis-4.0.14/src`
```

## 레디스 명령어 복사

컴파일이 끝났다면 `make install` 을 입력해 `redis-server`, `redis-cli` 명령어를 복사해줍니다.

``` shell
# redis-server / redis-cli 명령어 복사
$ make install

cd src && make install
make[1]: Entering directory `/root/redis-4.0.14/src'

Hint: It's a good idea to run 'make test' ;)

    INSTALL install
    INSTALL install
    INSTALL install
    INSTALL install
    INSTALL install
make[1]: Leaving directory `/root/redis-4.0.14/src'
```

이제 명령어를 사용할 수 있게 되었습니다.



## 레디스 서버 설치

레디스 서버 설치를 위해 `utils/install_server.sh` 를 실행합니다. 별다른 설정을 하지 않는다면 모두 엔터를 입력해 줍니다.  

``` shell
$ utils/install_server.sh

Welcome to the redis service installer
This script will help you easily set up a running redis server

Please select the redis port for this instance: [6379]
Selecting default: 6379
Please select the redis config file name [/etc/redis/6379.conf]
Selected default - /etc/redis/6379.conf
Please select the redis log file name [/var/log/redis_6379.log]
Selected default - /var/log/redis_6379.log
Please select the data directory for this instance [/var/lib/redis/6379]
Selected default - /var/lib/redis/6379
Please select the redis executable path [/usr/local/bin/redis-server]
Selected config:
Port           : 6379
Config file    : /etc/redis/6379.conf
Log file       : /var/log/redis_6379.log
Data dir       : /var/lib/redis/6379
Executable     : /usr/local/bin/redis-server
Cli Executable : /usr/local/bin/redis-cli
Is this ok? Then press ENTER to go on or Ctrl-C to abort.
Copied /tmp/6379.conf => /etc/init.d/redis_6379
Installing service...
Successfully added to chkconfig!
Successfully added to runlevels 345!
Starting Redis server...
Installation successful!
```

설치가 끝나면 레디스 서버가 실행 중인 것을 확인할 수 있습니다.

``` shell
$ ps aux | grep redis

root      3928  0.1  0.1  41736  3968 ?        Ssl  15:27   0:00 /usr/local/bin/redis-server 127.0.0.1:6379
root      3935  0.0  0.0   9104   860 pts/1    S+   15:31   0:00 grep --color=auto redis
```

## 확인

`redis-cli` 로 접속해 동작을 잘하는지 확인합니다.

``` shell
$ redis-cli

127.0.0.1:6379> ping
PONG
```

## 외부 접속 허용

설정 파일은 위에서 설정한 포트로 `/etc/redis/$PORT.conf` 형식으로 생성됩니다. 설정 파일을 열어서 bind 속성을 찾아 수정해줍니다. 수정 후, 레디스를 재시작해주면 설정이 적용됩니다.

``` shell
$ vim /etc/redis/6379.conf

...

# bind 127.0.0.1 을 아래와 같이 수정 후, 저장
bind 0.0.0.0

...

$ /etc/init.d/redis_6379 restart
```

# 참고

* [Redis Quick Start](https://redis.io/topics/quickstart)
