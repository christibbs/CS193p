//
//  ContentView.swift
//  Memorize
//
//  Created by Chris Tibbs on 11/25/20.
//

import SwiftUI

struct ContentView: View {
  var viewModel: EmojiMemoryGame

  var body: some View {
    HStack {
      ForEach(viewModel.cards) { card in
        CardView(card: card).onTapGesture { viewModel.choose(card: card) }
      }
    }
    .padding()
    .foregroundColor(Color.orange)
    .font(viewModel.cards.count < 5 ? Font.largeTitle : Font.body)
  }
}

struct CardView: View {
  var card: MemoryGame<String>.Card

  var body: some View {
    ZStack {
      if card.isFaceUp {
        RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
        RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3.0)
        Text(card.content)
      } else {
        RoundedRectangle(cornerRadius: 10.0).fill()
      }
    }.aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(viewModel: EmojiMemoryGame())
  }
}
