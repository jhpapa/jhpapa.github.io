---
layout: 'post'
title: 'JVM 메모리 구조 정리'
description: 'JVM 메모리 구조 (Run-Time Data Areas) 정리'
date: '2018-12-20 21:12 +0900'
categories:
  - Java
tags:
  - Java
  - JVM
---

# JVM 메모리 구조 (Run-Time Data Areas)

JVM의 메모리는 크게 쓰레드별로 생성되는 데이터 영역과 전체 쓰레드가 공유하는 데이터 영역으로 나뉘며, Run-Time Data Areas라고 부릅니다.

![JVM 메모리 구조](/assets/images/post/jvm-memory-structure.jpg)

## 쓰레드별 데이터 영역

쓰레드의 데이터 영역은 쓰레드가 생성될 때, 생성되며, 쓰레드가 종료되면 해제됩니다.

### PC(Program Counter) Register

쓰레드마다 PC Register가 존재합니다. 하나의 메소드 코드를 JVM의 쓰레드라고 하며, 쓰레드가 실행되면 이 메소드가 실행됩니다. 현재 실행된 쓰레드의 메소드가 네이티브 메소드가 아니면 PC Resiter에 **JVM 명령 주소가 저장**됩니다. (JVM 명령은 1 byte의 opcode와 0개 이상의 피연산자로 구성되어 있으며, 바이트 코드 내에서 볼 수 있는 aload_0 과 같은 형태)  
만약 실행 중인 쓰레드의 메소드가 네이티브 메소드면 바이트 코드의 명령어가 없기 때문에  PC Register가 비어있거나 정의되지 않습니다.

### JVM Stacks

쓰레드마다 JVM Stack이 존재하며, 쓰레드가 생성될 때 같이 생성됩니다. 일반적인 스택과 동일한 구조와 동작을 하며, Stack Frame을 저장합니다. Stack Frame은 로컬 변수, 일부 실행 결과, 메소드 호출 또는 반환 등을 저장합니다. Frame을 push(저장)하거나 pop(제거)하는 동작만 수행합니다.

* 쓰레드가 허락된 스택 용량보다 많은 계산을 필요로 하면 `StackOverflowError`가 발생합니다.
* 실행 중인 쓰레드의 스택을 확장할 만큼 충분한 메모리가 없거나, 새로 생성될 쓰레드에게 메모리가 부족해 스택을 할당할 수 없는 경우 `OutOfMemoryError`가 발생합니다.

### Native Method Stacks

자바 이외의 언어(C, C++, 어셈블리 등)로 작성된 코드를 실행할 때, Native Method Stack이 할당되며, 일반적인 C 스택을 사용합니다.

* JVM Stacks과 동일한 기준으로 `StackOverflowError`와 `OutOfMemoryError`가 발생합니다.

-----------------------------------

## 전체 쓰레드가 공유하는 데이터 영역

전체 쓰레드가 공유하는 데이터 영역은 JVM이 시작될 때 생성되고, JVM이 종료되면 해제됩니다.

### Heap

Heap은 클래스의 인스턴스와 배열이 할당되는 영역입니다. 할당된 객체는 직접 해제가 불가능 하며, 오직 가비지 컬렉터에 의해 해제됩니다.  

* 가비지 컬렉터가 사용할 수 있는 것보다 많은 Heap이 필요하면 `OutOfMemoryError`가 발생합니다.

### Method Area

Method Area는 클래스의 필드, 메소드 정보, static 변수, 메소드와 생성자의 바이트코드, 각 클래스, 인터페이스에 관련된 런타임 상수풀이 저장됩니다.   
Method Area는 논리적으로 힙의 일부분이지만, 일반적으로 가바지 컬렉션 대상이 아니지만, JVM 벤더가 가비지 컬렉션 여부를 선택할 수 있습니다.  
Method Area는 JVM 벤더마다 다르지만, HotSpot에선 Permanent Generation 이라고 불립니다. Java 8 부터는 HotSpot에서 JRockit과 일치시키는 과정으로 PermGen 영역을 삭제하고, Heap에 interned String과 static 변수를 저장하도록 변경했습니다. 그리고 Metaspace라는 새로운 네이티브 메모리 영역을 만들고 해당 영역에 클래스 메타데이터를 저장합니다.

# 참고

* [Java Virtual Machine Specification- Chapter 2. The Structure of the Java Virtual Machine](https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-2.html#jvms-2.11)
* [Java JVM Run-time Data Areas](https://javapapers.com/core-java/java-jvm-run-time-data-areas/)
* [JVM Internals - Run-time Constant Pool](http://blog.jamesdbloom.com/JVMInternals.html#constant_pool)
* [StackOverflow - What is a native pointer and returnAddress?](https://stackoverflow.com/questions/38672839/what-is-a-native-pointer-and-returnaddress)
* [StackOverflow - Where are static methods and static variables stored in Java?](https://stackoverflow.com/questions/8387989/where-are-static-methods-and-static-variables-stored-in-java)
* [StackOverflow - What is the purpose of the Java Constant Pool?](https://stackoverflow.com/questions/10209952/what-is-the-purpose-of-the-java-constant-pool)
* [JEP 122: Remove the Permanent Generation](http://openjdk.java.net/jeps/122)
