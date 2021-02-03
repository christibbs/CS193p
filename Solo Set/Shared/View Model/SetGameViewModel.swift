//
//  SetGameViewModel.swift
//  Solo Set
//
//  Created by Chris Tibbs on 1/19/21.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
  var numberOfVisibleCards: Int
  
  @Published var model: SetGame
  
  var visibleCards: [SetGame.Card] {
    // First n unmatched.
    let unmatchedCards = model.cards.filter { (card) -> Bool in
      !card.isMatched
    }
    return Array(unmatchedCards[..<numberOfVisibleCards])
  }
  
  init() {
    self.model = SetGame()
    self.numberOfVisibleCards = defaultCardAmount
  }
  
  // MARK: Intent
  
  func select(_ card: SetGame.Card) {
    model.select(card)
  }
  
  func addThree() {
    numberOfVisibleCards += 3
  }
  
  // MARK: Control panel
  
  let defaultCardAmount = 12
}
