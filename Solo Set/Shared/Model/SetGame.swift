//
//  SetGame.swift
//  Solo Set
//
//  Created by Chris Tibbs on 1/18/21.
//

import Foundation

struct SetGame {
  private(set) var cards = [Card]()
  var score: Int = 0
  var nextCardIndex = 0
  
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
  
  func deal(cardAmount: Int = 12) -> [Card] {
    let actualAmountDealt = min(cardAmount, cards.count - nextCardIndex)
    return [Card]()
    
  }
  
  struct Card: Identifiable {
    var id: Int {
      return color.rawValue * 1000
        + shape.rawValue * 100
        + opacity.rawValue * 10
        + number.rawValue * 1
    }
    
    enum Color: Int, CaseIterable  {
      case red
      case yellow
      case blue
    }
    
    enum Shape: Int, CaseIterable {
      case diamond
      case circle
      case rectangle
    }
    
    enum Opacity: Int, CaseIterable {
      case clear
      case half
      case full
    }
    
    enum Number: Int, CaseIterable {
      case one
      case two
      case three
    }
    
    var color: Color
    var shape: Shape
    var opacity: Opacity
    var number: Number
    var isChosen = false
  }
}


