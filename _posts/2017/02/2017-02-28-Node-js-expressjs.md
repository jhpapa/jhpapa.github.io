---
layout: post
title: "expressjs"
date: 2017-02-22 00:07
image: ''
description: 'Node.js expressjs'
tags:
- Node.js
categories:
- Programming
---

# express.js 란?
빠르고 쉽게 node.js를 위한 웹 어플리케이션을 생성할 수 있는 웹프레임워크이다.

<br/>
## node.js의 기본 http 통신
{% highlight javascript %}

const http = require('http');

const hostname = '127.0.0.1';
const port = 3000;

const server = http.createServer((req, res) => {  // 익명 함수(args) => {todo}
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello World\n');
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});

{% endhighlight %}

<br/>
## express.js의 기본 http 통신
{% highlight javascript %}
var express = require('express')
var app = express()

app.get('/', function (req, res) {
  res.send('Hello World!')
})

app.listen(3000, function () {
  console.log('Example app listening on port 3000!')
})
{% endhighlight %}

<br/>
## express generator
express.js의 scafold 코드(샘플코드 및 구조) 생성시켜준다.<br/>
자동으로 express 관련 폴더 및 기본 소스 생성.<br/>

> $ express testWeb

<br/>

>   create : testWeb
   create : testWeb/package.json
   create : testWeb/app.js
   create : testWeb/public
   create : testWeb/public/javascripts
   create : testWeb/public/images
   create : testWeb/routes
   create : testWeb/routes/index.js
   create : testWeb/routes/users.js
   create : testWeb/public/stylesheets
   create : testWeb/public/stylesheets/style.css
   create : testWeb/views
   create : testWeb/views/index.jade
   create : testWeb/views/layout.jade
   create : testWeb/views/error.jade
   create : testWeb/bin
   create : testWeb/bin/www

>   install dependencies:
     $ cd testWeb && npm install // 해당 명령어를 입력해 dependencies 생성

>   app을 실행시키기 위한 세 가지 방법:
     1. $ DEBUG=testweb:* npm start
     2. $ npm start
     3. $ node ./bin/www

[express 실행화면]({{ site.url }}/assets/img/post_image/{{ page.date | date: "%Y" }}/{{ page.date | date: "%m" }}/express_index.png) 
>    브라우저에 localhost:3000 입력하게 되면 express가 실행되는 것을 확인할 수 있다.



## pm2
Node.js 프로세스 관리 도구. 서버가 문제가 생길 경우 자동으로 서버를 재시작시켜주거나, pm2로 지정한 파일이 변경되었을 경우에 자동으로 서버를 재시작해주는 도구이다.

> $ npm install -g pm2 // pm2 설치
> $ pm2-dev start  {serverName}.js // pm2에서 node 실행방법

위와 같이 js 파일명만 적어준다면 App name은 파일명이 되지만 `--name`을 준다면 지정한 이름으로 App name이 설정된다.
