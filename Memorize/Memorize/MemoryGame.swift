//
//  MemoryGame.swift
//  Memorize
//
//  Created by Chris Tibbs on 11/30/20.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
  var cards: [Card]
  var score = 0

  var indexOfFaceUpCard: Int? {
    get { cards.indices.filter { cards[$0].isFaceUp }.only }

    set {
      for index in cards.indices {
        cards[index].isFaceUp = index == newValue
      }
    }
  }

  let scoreIncrementForMatch = 2
  let scoreDecrementForSeenCard = 1

  private var seenCardIds = Set<Int>()

  mutating func choose(card: Card) {
    print("card tapped: \(card)")
    if let chosenIndex = cards.firstIndex(matching: card),
      !cards[chosenIndex].isFaceUp,
      !cards[chosenIndex].isMatched {
      if let potentialMatchIndex = indexOfFaceUpCard {
        if cards[chosenIndex].content == cards[potentialMatchIndex].content {
          // Match.
          cards[chosenIndex].isMatched = true
          cards[potentialMatchIndex].isMatched = true
          score += scoreIncrementForMatch
        } else {
          // Mismatch.
          if seenCardIds.contains(cards[chosenIndex].id) ||
            seenCardIds.contains(cards[potentialMatchIndex].id) {
            score -= scoreDecrementForSeenCard
          }
          seenCardIds.insert(cards[chosenIndex].id)
          seenCardIds.insert(cards[potentialMatchIndex].id)
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
