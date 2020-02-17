---
layout: 'post'
title: 'Vim에서 단어 또는 영역을 감싸기'
description: ''
date: '2020-02-15 23:15:33'
categories:
  - Vim
tags:
  - Vim
---

# vim-surround

Vim에서 [vim-surround](https://github.com/tpope/vim-surround) 플러그인을 사용하면 손쉽게 괄호, 따옴표, HTML 태그 등으로 감쌀 수 있습니다.

## 설치

`vim-plug`, `Vundle` 과 같은 플러그인 매니저를 사용한다면 아래와 같이 추가해 플러그인을 설치합니다.

```
# vim-plug
Plug 'tpope/vim-surround'

---

# Vundle
Plugin 'tpope/vim-surround'
```

플러그인 매니저를 사용하지 않는다면 [링크](https://github.com/tpope/vim-surround#installation)를 참고해 설치합니다.

## 사용법

### 감싸기 

`ys` 명령어를 사용하면 입력한 문자로 감쌀 수 있습니다.

``` text
ys<motion|text-object><감쌀 문자>
```

* [motion](http://vimdoc.sourceforge.net/htmldoc/motion.html) : w, b, h, j, k와 같이 커서를 움직이는 행동
* [text-object](http://vimdoc.sourceforge.net/htmldoc/motion.html#object-motions) : aw, iw, as, is와 같이 사전에 정의해둔 컨텍스트


``` text
# World 위에 커서를 위치한 후, ysiw) 입력
Hello, (World)

# 감쌀 때 양옆에 공백을 추가하고 싶다면 ysiw( 입력
Hello, ( World )

```

### 변경

`cs` 명령어를 사용하면 감싸고 있는 문자를 입력한 문자로 바꿀 수 있습니다.

``` text
cs<감싼 문자><바꿀 문자>
```

커서가 있는 위치를 기준으로 감싼 문자를 찾습니다.

``` text
# 소괄호 () 에 커서를 두고 cs)] 를 입력
Hello, (World)
-> Hello, [World]
```
