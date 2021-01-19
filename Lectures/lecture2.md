
# Lecture 2 :: MVVM and the Swift Type System

[![Stanford SwiftUI 2020](http://img.youtube.com/vi/4GjXq2Sr55Q/0.jpg)](https://www.youtube.com/watch?v=4GjXq2Sr55Q)

<br/>

---
## 🍎 MVVM
* SwiftUI에서 사용하는 디자인 패턴
* 과거 UIKit에서는 MVC를 많이 사용했다.

![image1](./img2/image1.png)

### Model
* UI 독립적 : SwiftUI를 import 하지 않는다.
* 데이터와 로직을 캡슐화한다.

### View
* 모델을 반영 : View 자체에서는 상태를 가지지 않으며, 모델의 상태를 반영한다.
* 데이터의 흐름 : (모델 -> 뷰) 뷰는 모델을 읽어오기만 하고, 변경할 수 없다.
* 선언적 : 간결한 코드로 선언되어 있을 뿐!
* 반응적 : 모델이 변경될 때 마다 반응하여 뷰가 자동으로 갱신된다.

### ViewModel
* 뷰를 모델에 바인딩 하는 역할
* 모델에 대한 모든것을 알고 있다. 뷰에 대해서는 알지 못한다.
* **모델의 변화를 알아챔** -> **모델을 뷰의 언어로 해석** -> **뷰 갱신(직접 대화 X)**
    - 뷰모델은 모델을 알고 있다. 모델의 변경사항이 발생하면 뷰모델이 알아챈다.
    - 뷰가 사용하기 좋도록 모델을 해석한다. 이 프로젝트에서 Model은 단순히 구조체(struct)이지만, 데이터베이스나 Http통신의 요청 결과값이 될 수도 있다. 복잡한 모델을 단순화하여 뷰가 필요한 정보만 뽑아내는 것이다.
    - 뷰모델을 뷰를 모른다. 뷰는 뷰모델을 구독하여, 변경사항이 있을 때 마다 뷰모델에게 물어봐서 자신을 변경한다.
* **Intent 처리** -> **모델 변경**
    - 뷰에서 이벤트가 발생하면 뷰모델의 Intent 함수를 호출한다.
    - 모델을 의도대로 변경한다. 모델이 struct라면 프로퍼티를 변경하는 것일 수도 있고, 데이터베이스라면 SQL문을 호출하는 것일수도 있다. 
* 이러한 양 방향의 흐름은 끊임없이 반복된다. (M->VM->V -> V->VM->M)

<br/>

--- 
## 🍎 Struct vs Class

### 공통점
- `let` 또는 `var`로 선언된 프로퍼티를 갖는다.
- 함수를 갖는다.
- init(생성자)를 갖는다. : 클래스 또는 구조체의 상태를 초기화 하는 함수를 말한다.

### 차이점
**Struct(구조체)**
- **value type** : 값의 복사본을 전달함
- **functional programming** : 함수형 프로그래밍
- 상속 불가능
- 모든 변수에 대해 초기값을 지정할 필요는 없다. **(initalizer 자유)**
- **mutable** 한 값은 **명시**해야 한다.
- **대부분의 데이터 구조**는 구조체로 구현되어 있다.

**Class(클래스)**
- **reference type** : 힙 영역에 저장되고, 포인터에 의해 전달됨
- **ARC** : 자동 레퍼런스(참조) 카운팅
- **object-oriented programming** : 객체지향 프로그래밍
- 상속 가능
- 변수를 가지고 있다면 반드시 초기화해주어야 한다. **(initalizer 필수)**
- 항상 mutable 하다. (변경 가능한 값이다.)
- 특수한 기능으로 사용
- SwiftUI의 MVVM 패턴에서 **ViewModel**은 반드시 **클래스**다 (많은 View들에게 공유되어야 하기 때문!)


> SwiftUI의 View는 클래스도, 구조체도 아닌 protocol이다.

<br/>

---
## 🍎 Generics
* 타입을 신경쓰고 싶지 않지만, Swift에서는 Type이 중요하다.
* Array의 경우 데이터를 저장하지만, 그 데이터의 타입은 Int가 될 수도 있고, String이 될수도 있다. 
* Array에 들어가는 변수, 함수의 반환형을 신경쓰지 않고 지정하는 방법이 제네릭이다.

### 정의 하기
* 꺾쇠 괄호 안에 임의의 타입을 만들어준다. (placeholder 같은 역할)
```
struct Array<Element> {
    ...
    func append(_ element: Element) 
}
```

### 선언 및 사용하기
* 꺾쇠 안의 타입이 정해지면, 따라오는 모든 반환형이 해당 타입처럼 취급된다.
* Int 형 배열을 선언하려면 꺾쇠 안에 `Ìnt`를 작성한다. 모든 `Element`가 `Int`로 취급된다.
    ```
    var a = Array<Int>()
    ```
* `a`는 Int형 배열로 정해졌으므로, `append(_:)`의 인자로 **Int형 데이터**만 올 수 있다.
    ```
    a.append(5)
    ```

<br/>

---
## 🍎 Functions as Types
* 변수의 타입을 함수로 지정할 수 있다.  
* **사용법** : (파라미터로 들어올 타입들) -> 반환 타입
> (Int, Int) -> Bool  // 파라미터는 Int형 2개, 반환형은 Bool  
> (Double) -> Void    // 파라미터는 Double형 1개, 반환형은 없음  
> () -> Array<String> // 파라미터 없음, 반환형은 String 배열  
> () -> Void          // 파라미터 없음, 반환형 없음  

<br/>

### 예시
```
func sum(_ op1: Int, _ op2: Int) -> Int {
    return op1 + op2
}
func sub(_ op1: Int, _ op2: Int) -> Int {
    return op1 - op2
}
```
```
var operation: (Int, Int) -> Int    // operation은 Int,Int형 파라미터와 Int를 반환하는 함수는 모두 대입 가능하다.

operation = sum
let result1 = operation(1,2)    // result1 = 3

operation = sub
let result2 = operation(5,1)    // result2 = 4
```
