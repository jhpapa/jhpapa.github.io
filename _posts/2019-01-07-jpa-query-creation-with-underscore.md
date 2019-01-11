---
layout: 'post'
title: 'JPA Property Expressions 쿼리 생성시 참조타입 탐색 경로 지정하기'
description: 'JPA Property Expressions으로 쿼리 생성시 참조타입 탐색 경로 지정하기'
date: '2019-01-07 03:33:23 +0900'
categories:
  - JPA
tags:
  - JPA
  - Java
---

> 테스트 코드는 [GitHub](https://github.com/hongsii/blog-code/tree/master/jpa-underscore-test)에서 확인할 수 있습니다.

커뮤니티에서 JPA 관련 질문글에 답변하면서 알게된 내용을 테스트하고 정리해보려고 합니다.

> "스네이크 표기법인 컬럼으로 Repository에서 쿼리를 생성하는데 에러가 발생한다."

자바에서는 카멜 표기법이 네이밍 컨벤션이지만, 질문 작성자는 스네이크 표기법인 프로퍼티로 쿼리를 생성할 때, 에러가 발생하고 있었습니다. 아래는 질문글에 작성된 엔티티의 일부 내용입니다.

``` java
@Entity
public class App {

	@Id
	@GeneratedValue(strategy =  GenerationType.IDENTITY)
	private int id;

	@Column
	private int project_id; // 에러가 나는 프로퍼티
}
```

아래와 같이 Repository를 만들고 애플리케이션을 실행해 조회 메소드를 호출하게 되면 에러가 발생합니다.

``` java
public interface AppRepository extends JpaRepository<App, Integer>{

	List<App> findByProject_id(int project_id); // 실행시 에러
}
```

원인을 찾기 위해 글에 첨부된 로그를 확인해보니 눈에 띄는게 하나 있었습니다.  

```
Failed to create query for method AppRepository.findByProject_id(int)!
No property id found for type Project! Traversed path: App.project.
```

해당 메소드의 쿼리를 생성하는데 실패하면서 `No property id found for type Project! Traversed path: App.project.`가 발생했습니다. 로그 그대로 해석하면 Project 타입의 id 프로퍼티를 찾을 수 없다고 합니다.  

위와 같은 에러가 왜 발생햇는지 검색해보니 관련된 내용을 [Spring Data JPA Doc](https://docs.spring.io/spring-data/jpa/docs/current/reference/html/#repositories.query-methods.query-property-expressions)에서 찾을 수 있었습니다. 로그와 같은 에러가 발생한 이유는 Spring-Data-JPA에서 언더스코어(_)가 **프로퍼티을 찾기 위한 탐색 경로를 지정하는 예약어***이기 때문입니다.

## JPA의 예약어 언더스코어(_)

### JPA 쿼리 생성 - Property Expressions 로직

Property Expressions으로 쿼리를 생성할 때, 조건에 해당하는 프로퍼트를 찾을 수 없으면 카멜 표기법으로 머리와 꼬리를 구분해 프로퍼티를 찾아가는 로직이 존재합니다.예를 들어, `Person`이 `Address`를 프로퍼티로 가지고, `Address`가 `ZipCode`를 프로퍼티로 가지고 있다고 가정하겠습니다.  
그럼 `Address`의 `ZipCode` 프로퍼티로 조회하고 싶을 때, `findByAddressZipCode`라고 메소드명을 짓는다면 쿼리가 실행될 때 `Person`의 `AddressZipCode` 라는 프로퍼티를 찾습니다. 해당 프로퍼티가 없다면 카멜 표기법의 끝부터 대문자를 기준으로 머리 부분과 꼬리 부분으로 나눠 머리에 해당하는 프로퍼티를 찾고 그 객체에서 꼬리 프로퍼티를 찾습니다. 
프로퍼티를 찾지 못했기 때문에 다음 로직에서 머리는 `AddressZip`가 되고 꼬리는 `Code`가 됩니다. 그럼 `Person` 의 `AddressZip`을 찾아서 `AddressZip`의 `Code` 프로퍼티를 찾습니다. 그래도 없다면 카멜표기법이 끝날 때 까지 계속 앞의 내용을 반복합니다. 다음 머리는 `Address`, 꼬리는 `ZipCode`가 됩니다. 이후에는 카멜 표기법이 존재하지 않기 때문에 쿼리 생성이 실패합니다.  
앞의 로직으로 쿼리를 만들기 위해 객체를 탐색할 때, 혹시나 `addressZip`이라는 프로퍼티가 `Person` 객체에 존재한다면 `addressZip`을 탐색 경로로 설정해 원치 않는 경로가 설정돼 실패하게 됩니다. 이러한 **모호성을 해결하기 위해 언더스코어를 사용**할 수 있습니다.  

생성 로직을 확인하기 위해 테스트를 위해 `Person`, `Address` 객체를 만듭니다.

``` java
@Entity
public class Person {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@Column
	private String addressZip; // 모호성을 확인하기 위한 프로퍼티

	@Embedded
	private Address address;

	public Person(Address address) {
		this.address = address;
	}

	public Address getAddress() {
		return address;
	}
}
```

``` java
@Embeddable
public class Address {

	private String zipCode;

	public Address() {}
	public Address(String zipCode) {
		this.zipCode = zipCode;
	}

    // ... equals and hashcode ...
}
```

이제 Repository를 만들고 실행하기 위한 테스트코드를 작성합니다.

``` java
// Repository
public interface PersonRepository extends JpaRepository<Person, Long> {

	Person findByAddressZipCode(String zipCode); // Property Expressions 로직 확인을 위한 메소드
}

// 테스트 코드
@RunWith(SpringRunner.class)
@DataJpaTest
public class PersonRepositoryTest {

	@Autowired
	private PersonRepository personRepository;

	@Test
	public void ZipCode로_사람_조회() {
		personRepository.saveAll(asList(
				new Person(new Address("11111")),
				new Person(new Address("99999"))
		));

		Person savedPerson = personRepository.findByAddressZipCode("99999");

		assertThat(savedPerson.getAddress()).isEqualTo(new Address("99999"));
	}
}
```

테스트를 실행하게 되면 `addressZipCode`를 먼저 검색하고 없다면 로직에 따라 `addressZip`을 찾는데 `Person.addressZip` 프로퍼티가 존재하기 때문에 해당 프로퍼티가 탐색 경로로 선택돼 에러가 발생합니다.

![test-fail](/images/jpa-underscore-test-fail.png)

이제 명시적으로 탐색 경로를 나타내서 모호성을 해결해보겠습니다.

``` java
public interface PersonRepository extends JpaRepository<Person, Long> {

	Person findByAddress_ZipCode(String zipCode); // 언더스코어로 탐색 경로 지정
}
```

탐색경로를 지정한 메소드로 테스트를 실행하면 정상적으로 `Address`의 `zipCode`를 조건으로 선택하는 것을 확인할 수 있습니다.

![test-success](/images/jpa-underscore-test-success.png)


### 결론

언더스코어는 이미 `Spring Data JPA`의 **탐색 경로를 설정하는 예약어**이기 때문에 Property Expressions에 사용하면 안됩니다. 스네이크 표기법을 사용하기보단 자바의 네이밍 컨벤션인 카멜 표기법을 사용하는 것을 추천합니다.  
객체 그래프를 탐색하는 조건의 경우 `_`를 사용하면 객체 그래프 탐색 경로를 지정할 수 있습니다. (사용하지 않아도 탐색 경로 설정 로직에 따라 객체 그래프를 탐색하겠지만, 모호한 경우가 있을 수 있으니 명시적으로 탐색 경로를 지정해주는게 좋다고 생각합니다.)


----------------------------------

# 참고

* [Spring Data JPA - 4.4.3. Property Expressions](https://docs.spring.io/spring-data/jpa/docs/current/reference/html/#repositories.query-methods.query-property-expressions)
