---
layout: 'post'
title: 'Git push/fetch 내부 동작 정리'
description: 'Refs, Refspec, Push, Fetch 설명'
date: '2018-11-08 01:11'
categories:
  - Git
tags:
  - Git
---

# 시작

git push와 관련된 질문에 답변하기 위해 찾아보던 중 알게된 내용에 대해 정리해보려고 합니다.

> error: src refspec master does not match any.
> error: failed to push some refs to '저장소 URL'

이러한 오류가 발생한 이유에 대해 이해하기 위해선 `git push --help`에 나온 push 사용법부터 시작해야합니다.

```
git push [option...] [<repository> [<refspec>...]]
```

흔히 `git push [리모트 저장소명] [푸시할 브랜치명]`으로 사용을 하는데요. 여기선 푸시할 브랜치명이 **refspec** 이라고 표시가 되어있습니다.  
refspec은 그럼 무엇일까요?

## Refs

Refspec을 알기 위해선 먼저 Refs가 무엇인지를 알아야 합니다. git은 모든 커밋을 **Key-Value** 형태로 관리하며, key는 **SHA-1으로 만들어진 40자리의 해시값**입니다.  
이러한 해시값만 알면 저장된 커밋을 조회할 수 있지만, 사람이 일일이 해시값을 기억하기 어렵기 때문에 외우기 쉬운 이름의 파일에 해시값이 저장되어있습니다. 이런 파일을 `References`라고 부르며 약자로 `Refs`라고 합니다.  
모든 refs는 `.git/refs`에 저장됩니다. 그리고 하위에는 heads, remotes, tags 디렉토리가 존재합니다.

```
$ pwd
test-repo/.git/refs
$ ls
heads remotes tags
$ ls test-repo/.git/refs/heads
master
$ cat test-repo/.git/refs/heads/master
4c009fbb5847d4b4d3a32984a1004259c15c8ada
```

.git/refs/heads 디렉토리 내에는 master 라는 파일만 존재합니다. 파일을 읽어보면 해시값이 출력되는데 이 파일이 바로 refs 입니다.  
master 라는 이름이 친숙하게 느껴지시죠? 우리가 흔히 아는 master 브랜치가 바로 이 refs입니다. git에서는 어떤 특정한 작업을 가리키는 refs를 **브랜치** 라고 부릅니다.

확인을 위해 브랜치 명령어를 사용하지 않고 branch1을 직접 만들어 보겠습니다. 아래의 명령어로 해시값의 refs를 생성할 수 있습니다.

```
git update-ref refs/heads/branch1 4c009fbb5847d4b4d3a32984a1004259c15c8ada
```

master 밖에 없었지만 명령어가 실행되면 branch1 이라는 refs가 생성됩니다.

![manual-branch](/images/git-push1.png)

그리고 `git branch -a` 명령어로 조회해보면 branch1이 생성된 것을 확인할 수 있습니다.

![2manual-branch](/images/git-push2.png)

## Refspec

이제 간단한 예와 함께 refspec을 설명하겠습니다. 리모트 저장소를 추가하는 명령어를 실행하고 나면 `.git/config` 파일 하단에 추가한 리모트 저장소의 정보가 추가됩니다.

```
$ git remote add origin https://github.com/hongsii/test-repo.git
$ cat .git/config
[core]
...(생략)...
[remote "origin"]
    url = https://github.com/hongsii/test-repo.git
    fetch = +refs/heads/*:refs/remotes/origin/*
```

이 정보에는 저장소의 url과 fetch 규칙이 추가되어있습니다. fetch 규칙에 사용된 `+refs/heads/*:refs/remotes/origin/*`가 바로 **refspec** 입니다.

refspec은 저장소의 refs를 매핑하는 방법을 나타내며, `+`와 `<src>:<dst>`로 구성됩니다.  

* `+`는 **fetch가 적용될 방식**이라고 생각하면 됩니다. +가 있다면 fast-forward 상태가 아니여도 리모트로부터 업데이트(이 경우는 merge commit이 발생)를 받아올 수 있습니다. 생략 가능하며, 생략한다면 fast-forward 상태가 아닐 때는 업데이트를 받을 수 없습니다.
* `<src>`는 source 패턴으로 git은 패턴과 일치하는 리모트 저장소의 references만 fetch 받을 수 있습니다.
    * 기본적으로 refs/heads/* 로 설정되며, 모든 로컬 저장소의 refs로 리모트 저장소의 fetch를 받아옵니다.
* `<dst>`는 destination 패턴으로 리모트 저장소에 매핑된 로컬 저장소의 refs가 저장됩니다.
    * 리모트 저장소는 로컬 저장소의 refs를 매핑해 refs/remotes/리모트저장소명/*으로 refs를 저장해둡니다. (로컬 저장소의 refs와 동일한 해시값을 가집니다.)

 로컬 저장소의 커밋 히스토리를 보고 싶다면 아래의 명령어를 입력하면 모두 동일하게 로컬 저장소의 히스토리를 보여줍니다.

```
# 로컬 저장소 커밋 히스토리 조회
$ git log master
$ git log heads/master
$ git log refs/heads/master
```

원격 저장소의 히스토리 또한, 동일한 방식으로 조회할 수 있습니다.

```
$ git log origin/master
$ git log remotes/origin/master
$ git log refs/remotes/origin/master
```

이제 어느정도 refspec이 무엇인지 감이 좀 오시나요? 다시 push로 돌아가보겠습니다.  

```
$ git push origin master
```

우리가 위와 같은 명령어를 입력하면 git이 master를 `refs/heads/master:refs/heads/master` 로 확장합니다.
콜론을 기준으로 왼쪽(src)은 푸시하기를 원하는 브랜치의 refs이며, 오른쪽(dst)은 리모트에 푸시가 될 때 업데이트될 브랜치의 refs입니다.  
이처럼 dst는 생략이 가능하며, 생략한 경우는 git이 src에 맞춰 푸시합니다.
여기서 `+`를 앞쪽에 붙여줄 경우 fast-forward가 아니더라도 리모트의 refs를 업데이트하게 만들 수 있습니다.

만약 src를 생략할 경우에는 리모트 저장소에 있는 브랜치가 삭제됩니다.

```
# 리모트의 master 브랜치 삭제
git push origin :master
```

## 오류 원인 및 해결

이제 오류가 난 원인에 대해서 다시 한번 보겠습니다.

> error: src refspec master does not match any.
> error: failed to push some refs to '저장소 URL'

.git/refs/heads 디렉토리에 master라는 refs가 존재하지 않기 때문에 푸시를 할 수가 없다고 나는 에러입니다. 지금 같은 상황을 해결하기 위해선
다른 refs로 푸시를 하거나 원하는 커밋으로 refs를 생성해야 합니다.

```
$ git push origin HEAD:master

또는

$ git update-ref refs/heads/{브랜치명} {원하는 커밋 해시값}
$ git push origin {생성한 refs}:master

만약 refs 자체가 존재하지 않는 경우에는 새로운 커밋을 하나 만들어주면 됩니다.
$ git show-ref
$ touch README.md
$ git add .
$ git commit -m "Initial commit"
$ git push origin master
```

위와 같은 명령어를 수행하면 문제를 해결할 수 있습니다.

## HEAD

문제를 해결하면서 HEAD를 사용했는데 HEAD는 사용자의 활성화된 브랜치를 가리키고 있는 **symbolic refs**입니다.  
HEAD 파일의 위치는 `.git` 디렉토리 아래에 위치하고 있습니다.

```
$ cat test-repo/.git/HEAD
ref: refs/heads/master
```

HEAD는 해시값을 직접 저장하지 않고 해시값이 저장된 refs를 간접 참조하고 있습니다. 그렇기 때문에 사용자가 checkout으로 브랜치를 활성화시킬 때마다 HEAD의 참조가 변경됩니다.

# 참고

* [Git - Refspec](https://git-scm.com/book/en/v2/Git-Internals-The-Refspec)
* [Stack Overflow - What is "Refspec"](https://stackoverflow.com/questions/44333437/git-what-is-refspec)
