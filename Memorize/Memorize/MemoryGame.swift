//
//  MemoryGame.swift
//  Memorize
//
//  Created by 임수현 on 2021/01/23.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    func choose(card: Card) {
        print("card choosen : \(card)")
    }
    struct Card {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
