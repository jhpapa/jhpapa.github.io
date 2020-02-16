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

커서 위치의 문자를 감싸려면 `ys` 명령어를 사용합니다.

``` text
ys<motion|text-object><additional-character>
```

* motion : w, b, h, j, k 과 같은 이동키
* text-object : aw, iw, as, is와 같은 단축키
