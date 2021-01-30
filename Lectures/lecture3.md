# Lecture 3 :: Reactive UI + Protocols + Layout

[![Stanford SwiftUI 2020](http://img.youtube.com/vi/SIYdYpPXil4/0.jpg)](https://www.youtube.com/watch?v=SIYdYpPXil4)

<br/>

---
## 🍎 선언형 프로그래밍
* UIKit에서는 주로 **명령형 프로그래밍**을 사용하였다. 뷰가 그려진 후 상태를 변경하였다.  
* SwiftUI는 **선언형**으로 구현한다. 뷰를 그릴 때 이러한 설정을 가진 상태로 그릴 것이라고 선언하는 것이다.
* 예를 들어, View의 폰트를 바꾸는 것이 아니라, 애초에 "View를 그릴 때 이 폰트를 사용하여 그리겠다!" 라고 선언하는 것이다.

또한, 특정 시간에 해당하는 것이 아니라 뷰를 그리는 모든 순간에 적용된다.
SwiftUI는 코드가 아닌 시스템에 의해 호출된다.


<br/>

---
## 🍎 카드가 선택되었을 때 뒤집기
모델은 struct로 되어있다! 즉, 함수의 인자로 들어오면 **값의 복사**가 이루어진다.

뷰에서 카드가 터치되면, 뷰모델(`EmojiMemoryGame`)을 통해 모델(`MemoryGame`)의 `choose(card:)`함수가 호출된다. `card.isFaceUp`을 변경시키고 싶지만, 여기서 인자로 들어온 `card`는 복사된 값이다! 따라서 `card`의 내부를 변경할 수 없다...


<br/>

1. 카드의 실제 메모리에 접근하기 위해 카드 배열 `cards`로부터 인자로 들어온 `card`의 인덱스를 찾는 함수를 구현해보자
    * Card 구조체는 `Identifiable`을 채택하고 있으므로, `id`를 통해 식별 가능하다.
    * cards를 전체 탐색해도 찾지 못했을 경우, 별도로 처리해주어야 한다. 하지만 일단 에러가 발생하지 않도록 두고, **TODO** 마크를 통해 나중에 수정해주자!
    
    ```
    func index(of card: Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0   // TODO: bogus!
    }
    ```

<br/>

2. 인덱스로 직접 접근하여 `isFaceUp` 프로퍼티를 변경시키자

    ```
    func choose(card: Card) {
        let chosenIndex: Int = self.index(of: card)
        let chosenCard: Card = cards[chosenIndex]
        chosenCard.isFaceUp = !chosenCard.isFaceUp // ERROR!
    }
    ```
    * `chosenCard` 또한 변수에 **복사된 값**이 저장되므로 의도와 맞지 않다.
    * 인덱스를 찾은 카드 자체에서 연산을 수행하자.


    <br/>

    <br/>

    ```
    func choose(card: Card) {
        let chosenIndex: Int = self.index(of: card)
        cards[chosenIndex].isFaceUp = !cards[chosenIndex].isFaceUp // Error!
    }
    ```
    * `cards[chosenIndex]`는 구조체 프로퍼티의 값이다.
    * 구조체 자신의 내부를 변경하는 내부함수는 `mutating` 키워드를 사용해야 한다.

    <br/>
    
    ```
    mutating func choose(card: Card) {
        let chosenIndex: Int = self.index(of: card)
        cards[chosenIndex].isFaceUp = !cards[chosenIndex].isFaceUp
    }
    ```

<br/>

**모델**이 변경되었을 때 **뷰모델**이 알기 위해서는 뷰모델이 `ObservableObject` 프로토콜을 채택해야 한다. 모델에는 `@Published` 키워드를 붙여주고, 모델이 변경되는 시점에서 `objectWillChange.send()`를 호출해준다.
```
class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    ...
    func choose(card: MemoryGame<String>.Card) {
        objectWillChange.send()
        model.choose(card: card)
    }
}
```

<br/>
<br/>


**뷰모델**이 `objectWillChange.send()`를 호출하는 시점을 **뷰**가 알기 위해서는 뷰가 가지고있는 뷰모델에 `@ObservedObject` 키워드를 붙여주어야 한다. `objectWillChange.send()`가 호출될 때 마다 뷰가 다시 그려지게 된다!
```
struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
   ...
} 
```
