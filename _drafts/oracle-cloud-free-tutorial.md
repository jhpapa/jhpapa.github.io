---
layout: 'post'
title: 'Oracle cloud free tier 사용하기'
description: '평생 공짜로 쓸 VM 얻기'
date: '2020-01-29 22:11:25 +0900'
categories:
  - Programming
tags:
  - Programming
  - Cloud
---

오라클에서 VM 2개를 평생 무료(!) 쓸 수 있는 VM을 제공해준다고 하여 사용하기 위한 방법을 정리해봤습니다.

## 계정 생성

[Oracle Cloud](https://www.oracle.com/kr/cloud/free/)에 접속하면 대문부터 무료라고 표시돼있습니다.
대문의 "무료로 시작하기" 버튼을 클릭하면 계정 생성을 시작합니다. 계정 생성 시 다음과 같은 정보를 입력해야 합니다.

- 이메일
- 사용 목적 및 이름, 도시, 주소 등 개인정보, 사용할 Region (Seoul Region이 존재합니다.)
- 휴대폰 인증 (전화번호 입력 시 01012345678이 아닌 1012345678과 같이 입력해야 합니다.)
- 신용카드 정보 (VISA, MASTER, AMEX)

마지막 단계인 신용카드 입력 시, 1불 결제 후 취소로 유효한 카드인지 확인합니다.  


## VM 인스턴스 생성

아래의 절차를 진행하면 무료 인스턴스를 얻을 수 있습니다.

1. SSH Key Pair 생성
2. VM 인스턴스 생성
3. 클라우드 네트워크 생성
4. 인스턴스 실행


### SSH Key Pair 생성

인스턴스 접속 시 사용할 Key Pair를 생성해야 합니다.

*Mac*

맥은 터미널에서 `ssh-keygen` 명령어를 사용해 생성할 수 있습니다.
