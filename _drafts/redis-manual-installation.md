---
layout: 'post'
title: '레디스 수동 설치'
description: ''
date: '2020-07-22 23:46:44'
categories:
  - Database
tags:
  - Redis
---

아래 글은 `CentOS 7.7`, `Redis 4.0.14` 기준으로 작성되었습니다.

## 레디스 설치 준비

레디스를 설치하기 위한 파일을 다운로드 받습니다. (다운로드 받을 수 있는 버전은 [여기](http://download.redis.io/releases/)에서 확인할 수 있습니다.
다운로드 받은 파일을 푼 뒤, 해당 디렉토리로 이동합니다.

``` shell
# 설치 파일 다운로드
$ curl -O  http://download.redis.io/releases/redis-4.0.14.tar.gz

# 아카이브 풀기
$ tar -xvf redis-4.0.14.tar.gz

$ cd redis-4.0.14
```
