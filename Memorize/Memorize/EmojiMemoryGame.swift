//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Chris Tibbs on 12/1/20.
//

import SwiftUI

class EmojiMemoryGame {
  private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()

  static func createMemoryGame() -> MemoryGame<String> {
    let emojis = ["❤️", "🥊","🏀", "💰", "🍆"].shuffled()
    let pairsCount = Int.random(in: 2...5)
    return MemoryGame<String>(numberOfPairsOfCards: pairsCount) { pairIndex in
      emojis[pairIndex]
    }
  }

  // MARK: - Access to the Model

  var cards: [MemoryGame<String>.Card] {
    return model.cards.shuffled()
  }

  // MARK: - Intent(s)

  func choose(card: MemoryGame<String>.Card) {
    model.choose(card: card)
  }
}
