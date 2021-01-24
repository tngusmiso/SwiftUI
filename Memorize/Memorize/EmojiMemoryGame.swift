//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by 임수현 on 2021/01/23.
//

import SwiftUI

// class는 힙에 있기 때문에 공유하기 쉽다.
class EmojiMemoryGame {
    private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: 2) { _ in "😀" }
    
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
     
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
