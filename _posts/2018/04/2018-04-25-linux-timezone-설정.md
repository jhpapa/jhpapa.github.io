---
layout: post
title: Ubuntu Timezone 설정
description: ''
date: '2018-04-25 02:05'
categories:
  - Linux
tags:
  - Linux
  - Ubuntu
---

AWS EC2 서버의 시간대가 한국 시간대와 맞지 않아서 타임존을 변경한 내용을 정리했습니다.  

## 타임존 조회
서버의 설정된 타임존 및 시간을 조회하고 싶다면 다음과 같이 입력합니다.

``` shell
$ more /etc/timezone
Etc/UTC

$ date
Tue Apr 24 16:58:10 UTC 2018
```

## 타임존 설정

타임존을 새롭게 설정하는 방법은 간단합니다. 아래의 명령어를 입력하면 타임존 설정 화면이 나옵니다.

``` shell
$ sudo dpkg-reconfigure tzdata
```

설정 화면에서 설정할 지역을 선택합니다. `Asia`를 선택해줍니다.
![timezone-1]({{ site.url }}/assets/images/post_image/2018/04/timezone-1.png)

다음 화면에서 `S`를 입력 후, `Seoul`을 찾아서 선택해줍니다.
![timezone-2]({{ site.url }}/assets/images/post_image/2018/04/timezone-2.png)

그리고 다시 타임존을 조회하면 정상적으로 시간대가 나오는 것을 확인할 수 있습니다.

``` shell
$ more /etc/timezone
Asia/Seoul

$ date
Wed Apr 25 01:58:32 KST 2018
```

-------------------

## 참고
* [Setting timezone from terminal](https://askubuntu.com/questions/323131/setting-timezone-from-terminal/323163)
