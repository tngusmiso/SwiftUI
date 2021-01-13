
# Lecture 1 :: Course Logistics and Introduction to SwiftUI

[![Stanford SwiftUI 2020](http://img.youtube.com/vi/jbtqIBpUG7g/0.jpg)](https://www.youtube.com/jbtqIBpUG7g) 

## 🍎 UIKit vs SwiftUI
- **UIKit** : Event-Driven
- **SwiftUI** : State-Driven

<br/>

----
## 🍎 프로젝트 생성
* SwiftUI 기반의 프로젝트를 생성하려면, Interface를 SwiftUI 로 선택해야 한다.
![image1](./img1/image1.png)

<br/>

* 프로젝트 생성 후 XCode화면이다.  
여기서 중요한 부분은 중앙 좌측의 **코드에디터**, 우측의 **Preview 화면**이다.  
코드의 결과는 **시뮬레이터**를 재생해서 확인 하는 방법도 있지만, UI의 작은 변화는 **Preview 화면**에서 거의 **실시간으로 업데이트** 되며, 업데이트가 중단된(pause) 경우 `Resume` 버튼을 눌러 다시 실시간 업데이트를 볼 수 있다.
![image1](./img1/image2.png)

> 특정 뷰에 해당하는 코드에 마우스 커서를 가져다 대면, Preview에 파란 사각형으로 해당 영역이 포커스 된다.!

<br/>

----
## 🍎 기본 코드 이해하기
```
import SwiftUI

struct ContentView: View {
    var body: some View {
        return Text("Hello, world!")
    }
}
```

<br/>

### import SwiftUI
* SwiftUI를 사용하기 위한 구문이다. 기존의 UI
* import SwiftUI를 하면 Foundation 까지 포함되어 있다.

<br/>

### View
* 사각형 화면에 보여지는 뷰를 말한다. (Text 포함)
* View 내에서 swips, taps, pinches 등의 이벤트가 발생한다.
* `ContentView`는 View로 작동하며, 스크린에 표시되는 하얀 사각형(최상단) 뷰를 의미한다.

<br/>

### var
* 프로퍼티를 선언하는 키워드이다.
* `ContentView`는 View 타입의 struct(구조체)이므로, 프로퍼티를 갖는다.

<br/>

### body
* View를 레고조각이라고 생각하면, 하나의 뷰는 **여러개의 뷰의 조합(Combiner)**로 구성될 수 있다.
* 레고 조각들로 모여서 만들어진 뷰의 본체를 의미하는 프로퍼티.
* 뒤에 중괄호({}, 클로저 형태)가 오므로 메모리에 저장되지 않고 매번 계산되는 **computed property**이다.

<br/>

### Text
* View처럼 동작하는 구조체이다. (View를 상속받았다고 이해할 수도 있지만)
* Text는 문자열로 구성되므로, 생성자의 인자로 String 문자열을 넘겨준다.

<br/>

### some View
* View 처럼 작동하는 타입들 중 어느 타입이든 될 수 있다는 것을 의미한다.
* `body`가 Text를 반환하고 있으므로, `body`는 **Text**로 동작한다.  

<br/>

----
## 🍎 카드 만들기
![image3.png](./img1/image3.png)  
둥근 모서리와 주황색 테두리를 가진 사각형 안에 유령 이모지를 넣은 카드를 만들어보자.

<br/>

### Text 이모지 넣는 법 
`⌃` + `⌘` + `Space`  
'ghost'를 검색해서 원하는 이미지를 찾을 수 있다. 👻
````
Text("👻")
````

<br/>

### 둥근 사각형
```
RoundedRectangle(cornerRadius: 10.0) 
```
인자로 오는 cornerRadius는 CGFloat형이며, 값의 단위는 pt이다.

<br/>

### ZStack
View 와 View를 겹쳐서 쌓을 때 사용한다.
RoundedRectangle 위에 Text를 쌓고 싶을때 다음과 같이 구현한다.
````
ZStack(content: {
    RoundedRectangle(cornerRadius: 10.0)
    Text("👻")
})
````

<br/>

### 주황색 테두리
```
RoundedRectangle(cornerRadius: 10.0).stroke().foregroundColor(.orange)
```

`.stroke()`  
- Shape(도형)을 채우는 대신 **테두리**를 그린다.
- Shape는 도형을 그리는 클래스 (Rectangle, Circle, Capsule, BezierPath 등)
- 인자로 lineWidth값을 넣을 수 있다.

`.foregroundColor(_:)`
- 모든 View에서 호출할 수 있다.
- 전경색 (테두리, 글자 색상 등)
- ZStack에서 foreground를 호출하면, ZStack에 들어있는 모든 뷰의 전경색을 한꺼번에 설정할 수 있다.
    ```
    ZStack(content: {
        RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
        Text("👻")
    })
        .foregroundColor(.orange)
        ```

<br/>

### padding
`.padding()`
- View 내부의 여백을 의미한다.
- ZStack에 padding을 주면 모든 뷰에 여백을 줄 수 있다.
- 인자를 넘기지 않으면 default: 10pt
    ```
    ZStack(content: {
        ...
    })
        .padding()
        .foregroundColor(.orange)
    ```

<br/>

### 도형에 색 채우기
`.fill()`
- 인자를 빈 값으로 두면 foreground 색상으로 채운다.
- 인자로 Color 값을 넘기면 그 색상으로 채워진다.
    ```
    RoundedRectangle(cornerRadius: 10.0).fill(.white)
    ```

<br/>

### Text 폰트 사이즈
`.font()`
````
Text("👻").font(Font.largeTitle)
````
* ZStack에 한번에 적용해도 된다.
    ```
    ZStack(content: {
        ...
    })
        .padding()
        .foregroundColor(.orange)
        .font(Font.largeTitle
    ```

</br>

---
## 🍎 똑같은 뷰를 반복적으로 배치하는 방법
### HStack(alingment: spacing: content:)
* Horizontal (가로) 방향의 스택을 의미한다.
* HStack의 `content`안에 나열된 뷰가 가로로 배치된다.
* `alignment`, `spacing`은 선택적으로 사용할 수 있다.
    * `alingment` : 정렬
    * `spacing` : 뷰 사이의 간격 (default: 10pt의 여백)

### ForEach(_: content:)
* 시퀀스로 반복적인 뷰를 만들 떄 사용한다.
* 첫 번째 인자로 시퀀스 또는 Range를 넣는다.
* `content` : 반복적으로 생성할 뷰를 넣는다.

```
HStack(content: {
    ForEach(0..<4, content: {
        ZStack(content: {
            ...
        })
    }
}
```

<br/>

---
## 🍎 코드를 깔끔하게 줄이는 몇가지 방법

1. 클로저(또는 함수) 내에 코드가 딱 반환문 한 줄일 경우, 키워드 return은 생략 가능하다.
    ````
    var body: some View {
        return Text("Hello, world!")
    }
    ````
    ````
    var body: some View {
        Text("Hello, world!")
    }
    ````

2. 함수의 마지막 인자를 클로저로 받을 경우, 소괄호 밖에 작성해도 된다.
    ```
    HStack(spacing: 0, content: {...})
    ```
    ```
    HStack(spacing: 0) {...}
    ```

3. 함수의 인자가 클로저 하나밖에 없을 때는 소괄호까지 생략 가능하다.
    ```
    HStack() {...}
    ```
    ```
    HStack {...}
    ```

**⬇️ 깔끔해진 코드**
```
var body: some View {
    HStack {
        ForEach(0..<4) { _ in
            ZStack {
                RoundedRectangle(cornerRadius: 10.0).fill().foregroundColor(.white)
                RoundedRectangle(cornerRadius: 10.0).stroke()
                Text("👻")
            }
        }
    }.padding()
    .foregroundColor(.orange)
    .font(.largeTitle)
}
```
<br/>

---
## 🍎 카드 모양의 View를 별도의 구조체로 분리하자
반복적으로 사용 될 View이므로 별도의 구조체로 분리해서 관리하자.  
그리고 카드의 뒷면과 앞면이 있기 때문에 상태를 표시하는 변수도 추가하자.  

```
struct CardView: View {
    var isFaceUp: Bool
    var body: some View {
        if isFaceUp {
            ZStack {
                RoundedRectangle(cornerRadius: 10.0).fill().foregroundColor(.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                Text("👻")
            }
        } else {
            RoundedRectangle(cornerRadius: 10.0).fill().foregroundColor(.orange)
        }
    }
}
```
