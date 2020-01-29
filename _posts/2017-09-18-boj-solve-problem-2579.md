---
layout: "post"
title: "2579번 - 계단 오르기"
description: ""
date: "2017-09-18 23:37"
categories:
- 알고리즘
tags:
- DP
- BOJ
- Algorithm
- 알고리즘
---

# BOJ 다이나믹 프로그래밍 알고리즘 풀이
## [2579번 - 계단 오르기](https://www.acmicpc.net/problem/1149) <br/>

계단별로 점수가 주어져있고 해당 계단을 밟으면 점수를 얻는다. <br/>
계단 오른 뒤 얻을 수 있는 총 점수의 최대값 구하기. <br/>

#### 규칙
1. 계단은 한 번에 한 계단씩 또는 두 계단씩 오를 수 있다. 즉, 한 계단을 밟으면서 이어서 다음 계단이나, 2계단 다음으로 오를 수 있다.
2. 연속된 세 개의 계단을 모두 밟아서는 안된다. 단, 시작점은 계단에 포함되지 않는다.
3. 마지막 도착 계단은 반드시 밟아야 한다.

#### 해결
1. 3번을 밟으면 안되기 때문에 마지막 계단을 밟았을 때, 2가지의 경우의 수가 존재 <br/>
2-1. 마지막 계단 바로 전 계단을 밟았을 경우는 그 전 계단을 밟을 수 없다. (N-3 -> N-1 -> N)
2-2. N-2 -> N-1 -> N을 밟았다면 그전에 연속되었을 가능성이 존재하기 때문에 안됨
3. 마지막 2번째 전 계단을 밟았을 때

### [풀이한 코드](https://github.com/hongsii/Algorithms/blob/master/src/BOJ/DP/Problem_2579.java)