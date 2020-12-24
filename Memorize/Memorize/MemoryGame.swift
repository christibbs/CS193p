//
//  MemoryGame.swift
//  Memorize
//
//  Created by Chris Tibbs on 11/30/20.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
  var cards: [Card]

  var indexOfFaceUpCard: Int? {
    get { cards.indices.filter { cards[$0].isFaceUp }.only }

    set {
      for index in cards.indices {
        cards[index].isFaceUp = index == newValue
      }
    }
  }

  mutating func choose(card: Card) {
    print("card tapped: \(card)")
    if let chosenIndex = cards.firstIndex(matching: card),
      !cards[chosenIndex].isFaceUp,
      !cards[chosenIndex].isMatched {
      if let potentialMatchIndex = indexOfFaceUpCard {
        if cards[chosenIndex].content == cards[potentialMatchIndex].content {
          cards[chosenIndex].isMatched = true
          cards[potentialMatchIndex].isMatched = true
        }
        cards[chosenIndex].isFaceUp = true
      } else {
        indexOfFaceUpCard = chosenIndex
      }
    }
  }

  init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
    cards = [Card]()
    for pairIndex in 0 ..< numberOfPairsOfCards {
      let content = cardContentFactory(pairIndex)
      cards.append(Card(content: content, id: pairIndex * 2))
      cards.append(Card(content: content, id: pairIndex * 2 + 1))
    }
    cards.shuffle()
  }

  struct Card: Identifiable {
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    var content: CardContent
    var id: Int
  }
}
