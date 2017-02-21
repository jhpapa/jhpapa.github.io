---
layout: post
title: "Node.js"
date: 2017-02-22 00:07
image: '/post_image'
description: 'Node.js 란?'
tags:
- Node.js
categories:
- Programming
---

# Node.js 란?
V8(자바스크립트 엔진)로 만들어진 Server-Side Platform이다.
Non-block I/O와 싱글 스레드 이벤트 루프를 이용하여 높은 처리 성능을 가지고 있다.

Node.js의 [공식 홈페이지](https://nodejs.org/ko/)의 내용에 따르면
> Node.js®는 Chrome V8 JavaScript 엔진으로 빌드된 JavaScript 런타임입니다. Node.js는 이벤트 기반, 논 블로킹 I/O 모델을 사용해 가볍고 효율적입니다. Node.js의 패키지 생태계인 npm은 세계에서 가장 큰 오픈 소스 라이브러리 생태계이기도 합니다.

## 장점
1. 개발하기가 쉽다.
2. 비동기 I/O 처리(Non-blocking)
 - Node.js 라이브러리의 모든 API는 Non-blocking이기 때문에 데이터가 반환될 때까지 기다리지 않고 다음 API를 실행한다. 이전에 실행한 결과값이 반환되면 이벤트 루프를 통해 결과값을 받아온다.
3. 싱글 스레드 / 뛰어난 확장성
 - 이벤트 루프로 인해 서버가 멈추지 않고 반응하도록 해준다.
 - Node.js는 한 개의 스레드만 사용하지만, Apache 같은 웹서버보다 많은 요청을 처리할 수 있다.

## 단점
1. No Silver Bullet
 - 아무리 성능이 좋다해도 프로그램을 잘못 짜게 되면 퍼포먼스가 이슈가 발생
 - 싱글 스레드를 이용하기 때문에 하나의 작업 자체에서 시간이 오래 걸리면 전체적으로 성능이 저하된다.
2. Callback Hell
 - 이벤트를 콜백 함수 중심으로 코드가 중첩되면서 가독성이 매우 떨어진다.
3. 에러(예외처리)가 발생하면 서버가 다운된다. (pm2/watch dog 등 처리 가능)
 - 사전에 에러를 처리하는 것이 더 좋다.
4. 멀티코어인 곳에서도 하나의 코어밖에 이용할 수 없다.
 - 싱글스레드라서 코어가 많아도 하나의 코어로만 작업을 하기 때문에 CPU 최적화를 할 수 없다.
5. V8 엔진은 GC와 같은 형태로 메모리 관리를 하기 때문에 GC가 일어나면 CPU 사용률이 순간적으로 증가해 서버가 멈출 수 있다.

단점들이 존재하지만 아주 많은 모듈을 보유한 npm을 이용할 수 있고, 빠르게 개발할 수 있다는 장점때문에 사용할 만한 가치가 있으며, 많은 사람들이 이용하고 있다.

--------------------------------

# 설치 방법

### Windows
1. [공식 홈페이지](https://nodejs.org/ko/)에서 설치 파일을 다운로드.
2. 다운로드 받은 파일 실행 후, 설치
3. cmd창을 열어서 node --version 커맨드 입력.
4. Node.js의 버전이 뜬다면 설치 완료.

### Linux
$ wget https://nodejs.org/dist/v6.9.5/node-v6.9.5-linux-x64.tar.xz
$ tar xvf node-v6.9.5-linux-x64.tar.xz
$ cd node-v6.9.5-linux-x64/bin 경로를 ./bash_profile에 path 추가
 - .bash_profile은 사용자 계정에서 환경 설정하는 파일이다.
 - 해당 파일은 자신의 홈디렉토리에 존재한다.
 - path를 설정하면 어디서든 node.js의 명령어 사용 가능.
$ node --version
 - 버전이 뜬다면 설치 완료.


-------------------------------


## NPM
 Node Package Manager의 약자로 Node.js의 모듈을 패키지화하여 간단하게 설치 및 관리할 수 있다. <br/>
[NPM 공식 홈페이지](http://npmjs.org)에서 인기 있는 모듈과 여러 정보를 얻을 수 있다.

 > npm

 을 입력하면 입력 가능한 커맨드를 확인할 수 있다.<br/>
 npm이 설치 되었는지 확인하려면 cmd창에
 > npm -v

 입력하여 버전이 뜬다면 설치가 되어있다.
 Node.js를 설치하면 자동으로 설치된다.

 모듈을 설치하는 방법은

 > npm install 모듈명

 그 외에 주요 명령어는

 > npm help : 도움말<br/>
 > npm list / npm ls : 모듈 리스트<br/>
 > npm list installed : 설치된 모듈 목록 확인<br/>
 > npm update 모듈명 : 모듈을 최신버전으로 업데이트<br/>
 > npm uninstall 모듈명 : 모듈 제거




--------------------------------
<br/><br/>




### 참고문서
* https://okdevtv.com/mib/nodejs
* http://www.nodebeginner.org/index-kr.html#how-to-not-do-it
