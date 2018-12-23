---
layout: 'post'
title: '자바 어노테이션'
description: ''
date: '2018-12-12 22:30'
categories:
  - Java
tags:
  - Java
  - 문법
---

# 어노테이션(Annotation)

어노테이션은 **메타데이터(Metadata)**입니다. 여기서 메타데이터란 **다른 데이터를 설명하기 위한 데이터**입니다. 그래서 어노테이션은 **코드를 설명하기 위한 데이터**라고 정의할 수 있습니다.

아래는 자바에서 제공하는 기본 어노테이션인 `@Override`를 사용한 코드입니다.

``` java
@Override
public String toString() {
    return "재정의된 메소드";
}
```

흔히 클래스를 상속받거나 인터페이스를 구현하여 메소드를 재정의할 때 붙이는 어노테이션입니다. 이 것을 지운다고 해서 컴파일 에러가 나거나 프로그램이 정상적으로 동작하거나 하지 않습니다. 실행에는 전혀 영향을 미치지 않죠. 단지 메소드가 재정의되었다는 것만 알려주는 용도로만 사용됩니다.

그럼 어노테이션을 붙임으로써 얻을 수 있는 장점은 무엇일까요?
이 경우는 컴파일러에게 메소드가 재정의된 것을 알려주면 컴파일러는 사용자가 잘못된 오버라이드 (메소드명에 오타가 있다던가 메소드 시그니쳐를 다르다던가)를 했을 때, 컴파일 에러를 발생시켜 사용자가 이를 고칠 수 있게 도와줍니다.  
이처럼 어노테이션은 클래스, 필드, 메소드 등등에 코드에 대한 부가설명 및 컴파일 단계에서 도움을 주는 역할로 사용됩니다.

## 내장 어노테이션

자바에서는 몇가지 어노테이션을 기본적으로 제공합니다.  
`java.lang` 패키지에 속하며, 총 5개의 어노테이션이 있습니다.

* `@Override` : 상위 타입에 정의된 메소드를 재정의했다는 것을 알리기 위해 사용합니다.
* `@Deprecated` : 사용하면 위험한 코드를 나태거나 이보다 더 나은 코드가 존재하기 때문에 사용하면 안된다는 것을 나타내기 위해 사용합니다.
* `@SuppressWarnings` : 이미 인지한 컴파일러의 경고를 제거하기 위해 사용합니다.

다음은 자바 7, 8에 추가로 만들어진 어노테이션입니다.

* `SafeVarargs` : 생성자나 메소드의 가변인자 파라미터가 안전하게 사용된다는 것을 나타내기 위해 사용합니다. (자바 7)
* `FunctionalInterface` : 인터페이스를 함수형 프로그래밍인 람다 방식으로 사용하기를 추천하는 용도로 사용합니다. (자바 8)

위의 내장 어노테이션뿐만 아니라 **사용자가 원하는 형태의 다양한 어노테이션을 만들 수 있습니다.**

## 커스텀 어노테이션

커스텀 어노테이션와 관련된 소스는 `java.lang.annotation` [패키지](https://docs.oracle.com/javase/8/docs/api/java/lang/annotation/package-summary.html)에 속해있습니다.  
커스텀 어노테이션을 정의하려면 `@interface`로 선언해주면 됩니다. `@`는 인터페이스와 어노테이션을 구분하기 위한 기호입니다. interface에 기호를 붙여주는 형태기 때문에 공백을 넣어 `@ interface`도 가능하지만, 표준 스타일을 맞추기 위해 붙여주는게 좋습니다.

``` java
public @interface MyAnnotation {}
```

어노테이션 타입은 바이트코드로 컴파일시 항상 `java.lang.annotation.Annotation`이 슈퍼인터페이스가 됩니다.

``` java
public interface MyAnnotation extends java.lang.annotation.Annotation {}
```

### 어노테이션 내용 정의

어노테이션 타입은 다음과 같은 내용을 인터페이스 내에 작성할 수 있습니다.

> 일반 선언 : [추상메소드선언자] 타입 명칭() [DefaultValue];  
> 배열 선언 : [추상메소드선언자] 타입 명칭() [] [DefaultValue];

* [...]와 같은 내용은 옵션으로 생략할 수 있습니다.
* 여러 값을 하나의 선언에 넣기 위해선 명칭() []와 같이 배열 선언을 해줘야 합니다.
* 내용 작성시 public abstract 키워드를 붙여줄 수 있지만, class로 컴파일될 때 컴파일러가 붙여 주기 때문에 선언하지 않아도 됩니다.

위와 같은 내용 정의 외에도 상수, enum, class, interface, annotation를 선언할 수 있습니다.

``` java
public @interface MyCustom {
    // 내용 정의
    String name() default "Custom annotation";
    // 상수
    int CONSTANT = 1;
    // enum
    enum Status {STOP, RUNNING, FINISHED}
    // class
	class InnerClass {}
	// interface
	interface  InnerInterface {}
	// annotation
	@interface InnerAnnotation {}    
}
```

1가지의 내용만 정의하는 경우에는 관례적으로 명칭을 `value()` 라고 사용합니다.  
`default`를 생략할 경우에는 **반드시 어노테이션 사용시 값을 입력**해줘야 합니다.

``` java
@interface SingleElement {
    String value();
}

@SingleElement // 컴파일 에러
public class MyClass {}

@SingleElement("foo") // 올바른 사용
public class MyClass {}

// 사용시 값 입력을 생략해도 된다면 default 사용
// 추가로 필요한 경우에 입력할 수 있음
@interface SingleElement {
    String value() default "foo";
}
```

### 잘못된 내용 선언

자기 자신을 타입으로 받는 경우 컴파일 에러 `"Cyclic annotation element type"` 발생

``` java
@interface SelfRef { SelfRef value(); }
```

그리고 어노테이션끼리 서로를 타입으로 받는 경우에도 컴파일 에러가 발생합니다.

``` java
@interface Ping { Pong value(); }
@interface Pong { Ping value(); }
```

### 미리 정의된 메타 어노테이션

커스텀 어노테이션 작성시 어노테이션을 설명하기 위한 메타 어노테이션이 있습니다.  
메타 어노테이션은 아래와 같이 5개가 존재합니다.

* `@Documented` : javadoc 및 기타 문서툴에 의해 문서화될 때 해당 어노테이션이 표시됩니다.
* `@Target` : 어노테이션 사용 대상을 지정할 수 있습니다.
* `@Retention` : 어노테이션 유지 범위를 지정할 수 있습니다.
* `@Inherited` : 자식클래스에서 부모클래스에 선언된 어노테이션을 상속받을 수 있습니다.
* `@Repeatable` : 동일한 어노테이션을 여러개 선언할 수 있게 합니다.

#### @Target

**어노테이션을 사용할 수 있는 대상(위치)를 나타내는 어노테이션**입니다. 만약, Target에 선언된 대상과 다른 대상에 어노테이션을 적용할 경우 컴파일 에러가 발생합니다.  
타입으로 enum인 `ElementType[]`을 받습니다. 아래는 ElementType에 선언된 요소입니다.

* `TYPE` : class, interface, annotation, enum 에만 사용 가능
* `FIELD` : 필드, enum 상수에만 사용 가능
* `METHOD` : 메소드에만 사용 가능
* `PARAMETER` : 파라미터에만 사용 가능
* `CONSTRUCTOR` : 생성자에만 사용 가능
* `LOCAL_VARIABLE` : 지역변수에만 사용 가능
* `ANNOTATION_TYPE` : 어노테이션에만 사용 가능
* `PACKAGE` : 패키지에만 사용 가능

아래는 자바8 부터 추가되었습니다.

* `TYPE_PARAMETER` : 타입 파라미터(T, E와 같은)에만 사용 가능
* `TYPE_USE` : [JLS의 15가지 타입](https://docs.oracle.com/javase/specs/jls/se8/html/jls-4.html#jls-4.11)과 타입 파라미터에 사용 가능 

``` java
// 필드에만 MyCustom 어노테이션 사용 가능
@Target(ElementType.FIELD)
public @interface MyCustom {}

// 필드와 메소드에만 MyCustom 어노테이션 사용 가능
@Target({ElementType.FIELD, ElementType.METHOD})
public @interface MyCustom {}
```

#### @Retention

어노테이션이 어느 시점까지 유지되는지를 나타낼 수 있습니다. 
enum `RetentionPolicy`에 3가지의 정책이 있습니다. `@Retention`을 생략한다면 `RetnetionPolicy.CLASS`가 적용됩니다.

* CLASS : 컴파일러에 의해 class 파일까지만 적용됩니다.
* RUNTIME : class로 변경하는 시점뿐만 아니라 JVM이 실행되어 동작할 때도 적용됩니다. **리플렉션**으로 어노테이션을 조회할 수 있습니다.
* SOURCE : 컴파일 시점에 컴파일러에 의해 제거됩니다.

``` java
// 클래스 파일에 어노테이션이 기록됨
@Retention(RetentionPolicy.CLASS)
public @interface MyCustom {}

// 클래스 파일에 기록될 뿐만 아니라 실행시에도 JVM에 적재돼 유지됨
@Retention(RetentionPolicy.RUNTIME)
public @interface MyCustom {}
```
#### @Inherited

부모클래스에 선언된 어노테이션이 자식클래스에 상속됩니다.  
테스트를 위해 아래와 같이 `@NonInheritedAnnotation`, `@InheritedAnnotation` 두개를 만듭니다.

``` java
@Inherited
@Retention(RetentionPolicy.RUNTIME)
@interface InheritedAnnotation {}

@Retention(RetentionPolicy.RUNTIME)
@interface NonInheritedAnnotation {}
```

다음과 같이 A, B, C 클래스를 만듭니다.

``` java
@NonInheritedAnnotation
class A {}

@InheritedAnnotation
class B extends A {}

class C extends B {}
```

위에서 만든 클래스가 각 어노테이션을 가지고 있는지 출력해보면 C는 B를 상속하고 있으며, B에 적용된 어노테이션은 `@Inherited`가 있기 때문에 C에도 적용됩니다.
B, C는 A의 서브클래스이지만, A의 어노테이션은 상속되지 않습니다.

``` java
System.out.println("Non inherited A : " + new A().getClass().getAnnotation(NonInheritedAnnotation.class));
System.out.println("Non inherited B : " + new B().getClass().getAnnotation(NonInheritedAnnotation.class));
System.out.println("Non inherited C : " + new C().getClass().getAnnotation(NonInheritedAnnotation.class));
System.out.println("inherited A : " + new A().getClass().getAnnotation(InheritedAnnotation.class));
System.out.println("inherited B : " + new B().getClass().getAnnotation(InheritedAnnotation.class));
System.out.println("inherited C : " + new C().getClass().getAnnotation(InheritedAnnotation.class));

Non inherited A : @NonInheritedAnnotation()
Non inherited B : null
Non inherited C : null
inherited A : null
inherited B : @InheritedAnnotation()
inherited C : @InheritedAnnotation()
```

#### @Repeatable

동일한 어노테이션을 여러개 선언할 경우 기존에는 컴파일 에러가 발생하지만, `@Repeatable`로 여러개 선언할 수 있게 만들 수 있습니다.

``` java
@Repeatable(Roles.class) // 컴파일시 Roles에 여러개의 Role을 컴파일러가 저장
@interface Role {

	String value();
}

@interface Roles {

	Role[] value();
}

@Role("Role1")
@Role("Role2")
class Repeat {}
```

### 커스텀 어노테이션 적용

실제 커스텀 어노테이션을 만들고 사용해보겠습니다.  
유저를 생성할 때, 자동으로 생성일시를 설정해주는 어노테이션을 만들겠습니다.  
런타임시 필드에 사용할 수 있는 `@CreatedTime` 어노테이션을 아래와 같이 만들어줍니다.

``` java
@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
@interface CreatedTime {}
```

`User` 클래스에 `createdTime` 이라는 필드를 만들고 어노테이션을 적용합니다.

``` java
class User{

	private String name;
	private String password;
	@CreatedTime
	private LocalDateTime createdTime;

	public User(String name, String password) {
		this.name = name;
		this.password = password;
	}

	@Override
	public String toString() {
		return "User{" +
				"name='" + name + '\'' +
				", password='" + password + '\'' +
				", createdTime=" + createdTime +
				'}';
	}
}
```

`setCreatedTime` 메소드에서 리플렉션을 통해 `User` 클래스의 필드를 조회해 `@CreatedTime`이 있는 필드에 현재 시간을 설정해줍니다.

``` java
public class AnnotationTest {

	public static void main(String[] args) throws Exception {
		User newUser = new User("이름", "비밀번호"); // 유저 생성

		System.out.println("before : " + newUser);
		setCreatedTime(newUser); // 생성일시 설정
		System.out.println(" after : " + newUser);
	}

	public static void setCreatedTime(Object target) throws Exception {
		Class<?> clazz = target.getClass();
		Arrays.stream(clazz.getDeclaredFields()) // 클래스의 필드 조회
				.filter(field -> Objects.nonNull(field.getDeclaredAnnotation(CreatedTime.class))) // @CreatedTime이 적용된 필드만 필터
				.forEach(field -> {
					try {
						field.setAccessible(true); // private 필드에 접근하기 위해 Accessible을 true로 설정
						field.set(target, LocalDateTime.now()); // 필드에 현재 시간 설정
					} catch (IllegalAccessException e) {
						e.printStackTrace();
					}
				});
	}
}
```

실행이 끝나면 생성일시가 설정된 것을 볼 수 있습니다.

``` java
before : User{name='이름', password='비밀번호', createdTime=null}
 after : User{name='이름', password='비밀번호', createdTime=2018-12-12T23:31:06.172}
```

---------

# 참고

* [How Do Annotations Work in Java?](https://dzone.com/articles/how-annotations-work-java)
* [위키백과 - 자바 어노테이션](https://ko.wikipedia.org/wiki/%EC%9E%90%EB%B0%94_%EC%96%B4%EB%85%B8%ED%85%8C%EC%9D%B4%EC%85%98)
* [The Java™ Language Specification - Section 9.6](https://docs.oracle.com/javase/specs/jls/se7/html/jls-9.html#jls-9.6)
