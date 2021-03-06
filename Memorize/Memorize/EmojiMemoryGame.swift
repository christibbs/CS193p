//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Chris Tibbs on 12/1/20.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
  enum Theme {
    // Name, emoji set, amount of pairs, and theme color.
    case specified(String, [String], Int, Color)
    case unspecified
  }

  let themes: [Theme] = [
    .specified(
      "Sports",
      ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🎱", "🪀"].shuffled(),
      5,
      .blue
    ),

    .specified(
      "Food",
      ["🍏", "🥐", "🌽", "🥥", "🍊", "🍇", "🧇", "🥕", "🍔", "🍒"].shuffled(),
      6,
      .yellow
    ),

    .specified(
      "Presidents",
      ["🍊", "🍒", "👴🏻", "👨🏾‍🦱"].shuffled(),
      4,
      Color(UIColor.darkGray)
    ),

    .specified(
      "Animals",
      ["🐱", "🐰", "🦉", "🐻", "🐣", "🐒", "🐷", "🐋", "🐗", "🦍"].shuffled(),
      4,
      .red
    ),

    .specified(
      "Philly",
      ["🚃", "🦅", "🗑", "🔔", "💉", "↗️", "🥊"].shuffled(),
      6,
      .green
    ),

    .specified(
      "Families",
      ["👨‍👩‍👦", "👩‍👧‍👧", "👨‍👨‍👦‍👦", "👩‍👩‍👦‍👦", "👨‍👧‍👦"].shuffled(),
      5,
      .purple
    ),

    .unspecified,
  ]

  @Published private var model: MemoryGame<String>

  init() {
    let theme = themes[Int.random(in: 0 ..< themes.count)]

    switch theme {
    case let .specified(name, emojis, pairsCount, color):
      model = MemoryGame<String>(numberOfPairsOfCards: pairsCount) { pairIndex in
        emojis[pairIndex]
      }
      styling = (name, color)
    case .unspecified:
      let basicEmojis = [
        "❤️", "🥊", "🏀", "💰", "🍆", "🚀", "😎", "✌🏽", "🇺🇸", "👀", "🦉", "🏈",
      ].shuffled()
      let pairsCount = Int.random(in: 2 ... 5)
      model = MemoryGame<String>(numberOfPairsOfCards: pairsCount) { pairIndex in
        basicEmojis[pairIndex]
      }
      styling = ("Potpourri", .gray)
    }
  }

  func reset() {
    let theme = themes[Int.random(in: 0 ..< themes.count)]

    switch theme {
    case let .specified(name, emojis, pairsCount, color):
      model = MemoryGame<String>(numberOfPairsOfCards: pairsCount) { pairIndex in
        emojis[pairIndex]
      }
      styling = (name, color)
    case .unspecified:
      let basicEmojis = [
        "❤️", "🥊", "🏀", "💰", "🍆", "🚀", "😎", "✌🏽", "🇺🇸", "👀", "🦉", "🏈",
      ].shuffled()

      let pairsCount = Int.random(in: 2 ... 5)
      model = MemoryGame<String>(numberOfPairsOfCards: pairsCount) { pairIndex in
        basicEmojis[pairIndex]
      }
      styling = ("Potpourri", .gray)
    }
  }

  var styling: (name: String, color: Color)

  // MARK: - Access to the Model

  var cards: [MemoryGame<String>.Card] {
    return model.cards
  }

  var score: Int {
    return model.score
  }

  // MARK: - Intent(s)

  func choose(card: MemoryGame<String>.Card) {
    model.choose(card: card)
  }
}
