//
//  SetGame.swift
//  Solo Set
//
//  Created by Chris Tibbs on 1/18/21.
//

import Foundation

struct SetGame {
  private(set) var cards = [Card]()
  private var indexesOfSelectedCards = [Int]() {
    didSet {
      if indexesOfSelectedCards.count == 0 {
        return
      }
      if indexesOfSelectedCards.count == 3 {
        let doWeHaveASet = hasSet
        if doWeHaveASet {
          score += 10
        } else {
          score -= 5
        }
        for index in indexesOfSelectedCards {
          cards[index].isSelected = false
          cards[index].isMatched = doWeHaveASet
        }
        indexesOfSelectedCards.removeAll()
      }
    }
  }
  
  var score: Int = 0
  var nextCardIndex = 0
  
  var hasSet: Bool {
    assert(indexesOfSelectedCards.count == 3,
           "`hasSet` shouldn't be called without 3 selected cards")
    let cardA = cards[indexesOfSelectedCards[0]]
    let cardB = cards[indexesOfSelectedCards[1]]
    let cardC = cards[indexesOfSelectedCards[2]]
    
    if cardA.color == cardB.color {
      if cardB.color == cardC.color {
        return false
      }
    } else {
      if cardA.color.rawValue + cardB.color.rawValue + cardC.color.rawValue != 6 {
        return false
      }
    }
    
    if cardA.shape == cardB.shape {
      if cardB.shape == cardC.shape {
        return false
      }
    } else {
      if cardA.shape.rawValue + cardB.shape.rawValue + cardC.shape.rawValue != 6 {
        return false
      }
    }
    
    if cardA.opacity == cardB.opacity {
      if cardB.opacity == cardC.opacity {
        return false
      }
    } else {
      if cardA.opacity.rawValue + cardB.opacity.rawValue + cardC.opacity.rawValue != 6 {
        return false
      }
    }
    
    if cardA.number == cardB.number {
      if cardB.number == cardC.number {
        return false
      }
    } else {
      if cardA.number.rawValue + cardB.number.rawValue + cardC.number.rawValue != 6 {
        return false
      }
    }
    
    return true
  }
  
  init() {
    for color in Card.Color.allCases {
      for shape in Card.Shape.allCases {
        for opacity in Card.Opacity.allCases {
          for number in Card.Number.allCases {
            cards.append(Card(color: color, shape: shape, opacity: opacity, number: number))
          }
        }
      }
    }
    cards.shuffle()
  }
  
  // MARK: Intent
  
  mutating func deal(cardAmount: Int = 12) -> [Card] {
    if nextCardIndex >= cards.count {
      return [Card]()
    }
    
    let actualAmountDealt = min(cardAmount, cards.count - nextCardIndex)
    let dealtCards = cards[nextCardIndex..<(nextCardIndex + actualAmountDealt)]
    nextCardIndex += actualAmountDealt
    return Array(dealtCards)
    
  }
  
  mutating func select(_ card: Card) {
    guard let indexOfChosenCard = cards.firstIndex(matching: card) else {
      assertionFailure("Card \(card) chosen, but this card doesn't exist.")
      return
    }
    cards[indexOfChosenCard].isSelected = true
    indexesOfSelectedCards.append(indexOfChosenCard)
  }
  
  // MARK: Card
  
  struct Card: Identifiable, CustomStringConvertible {
    var id: Int {
      return color.rawValue * 1000
        + shape.rawValue * 100
        + opacity.rawValue * 10
        + number.rawValue * 1
    }
    
    enum Color: Int, CaseIterable  {
      case red = 1
      case yellow = 2
      case blue = 3
    }
    
    enum Shape: Int, CaseIterable {
      case diamond = 1
      case circle = 2
      case rectangle = 3
    }
    
    enum Opacity: Int, CaseIterable {
      case clear = 1
      case half = 2
      case full = 3
    }
    
    enum Number: Int, CaseIterable {
      case one = 1
      case two = 2
      case three = 3
    }
    
    var color: Color
    var shape: Shape
    var opacity: Opacity
    var number: Number
    var isSelected = false
    var isMatched = false
    
    var description: String {
      return "\(id)"
    }
  }
}


