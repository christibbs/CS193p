//
//  MemoryGame.swift
//  Memorize
//
//  Created by Chris Tibbs on 11/30/20.
//

import Foundation

struct MemoryGame<CardContent> {
  var cards: [Card]

  func choose(card: Card) {
    print("card chosen: \(card)")
  }

  init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
    cards = [Card]()
    for pairIndex in 0 ..< numberOfPairsOfCards {
      let content = cardContentFactory(pairIndex)
      cards.append(Card(content: content, id: pairIndex * 2))
      cards.append(Card(content: content, id: pairIndex * 2 + 1))
    }
  }

  struct Card: Identifiable {
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    var content: CardContent
    var id: Int
  }
}
