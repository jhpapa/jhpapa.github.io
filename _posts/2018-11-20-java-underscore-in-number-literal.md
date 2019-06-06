---
layout: 'post'
title: '숫자 리터럴 구분자'
description: ''
date: '2018-11-20 22:00'
categories:
  - Java
tags:
  - Java
  - 문법
---

# 언더스코어(_) - 숫자 리터럴의 가독성을 올려주는 구분자

자바7부터 추가된 기능으로 숫자 리터럴에서 정해진 구분자(`_`)를 **숫자 사이에 사용**해 의미 있는 숫자끼리 그룹화 할 수 있습니다.
구분자를 사용하면 숫자를 읽을 때, **코드의 가독성을 올려준다**는 장점이 있습니다.

아래처럼 숫자를 표시할 때 3자리마다 구분자를 사용해주면 한눈에 파악하기 쉽습니다.

``` java
int thousand = 1_000; // 1000
int million = 1_000_000; // 1000000
```

진수 표기법 또한 구분자로 표시할 수 있습니다.

``` java
long bytes = 0b00000001_00000100; // 260
long hex = 0x10_FF_FE; // 1114110
```

## 예외

구분자는 **정해진 위치(숫자와 숫자 사이)에만 사용**할 수 있습니다.  
아래의 경우에는 구분자를 사용할 수 없습니다.

* 숫자의 시작과 끝
* 소수점 양 옆
* float의 접미사(F), long의 접미사(L)의 앞
* 진수를 표시하는 문자 위치 (0b, 0x ...)

``` java
// 숫자의 시작과 끝
int startOfNumber = _12; // 불가능
int endOfNumber = 12_; // 불가능

// 소수점 양 옆
float pi1 = 3_.1415F; // 불가능
float pi2 = 3._1415F; // 불가능

// 접미사 앞
long longNumber = 1234_L; // 불가능
float floatNumber = 1.23_F; // 불가능

// 진수를 표시하는 문자 위치
int hexValue = 0_x52; // 불가능
```

# 참고 자료

* [Oracle docs - Underscores in Numeric Literals](https://docs.oracle.com/javase/7/docs/technotes/guides/language/underscores-literals.html)
