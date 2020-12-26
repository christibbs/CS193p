//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Chris Tibbs on 11/25/20.
//

import SwiftUI

struct EmojiMemoryGameView: View {
  @ObservedObject var viewModel: EmojiMemoryGame

  var body: some View {
    VStack {
      HStack {
        Text(viewModel.styling.name)
          .font(.largeTitle)
        Spacer()
        Button(action: { viewModel.reset() }, label: {
          Text("New Game")
        })
      }.padding()
      Grid(viewModel.cards) { card in
        CardView(card: card).onTapGesture {
          viewModel.choose(card: card)
        }
        .padding(5)
      }.padding().foregroundColor(viewModel.styling.color)
      Text("Score: \(viewModel.score)").font(.body)
    }
    .padding()
  }
}

struct CardView: View {
  var card: MemoryGame<String>.Card

  var body: some View {
    GeometryReader { geometry in
      body(for: geometry.size)
    }
  }

  func body(for size: CGSize) -> some View {
    ZStack {
      if card.isFaceUp {
        RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
        RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
        Text(card.content)
      } else {
        if !card.isMatched {
          RoundedRectangle(cornerRadius: cornerRadius).fill()
        }
      }
    }
    .aspectRatio(aspectRatio, contentMode: .fit)
    .font(Font.system(size: fontSize(for: size)))
  }

  // MARK: - Drawing Constants

  let cornerRadius: CGFloat = 10.0
  let edgeLineWidth: CGFloat = 3
  let aspectRatio = CGSize(width: 2, height: 3)

  func fontSize(for size: CGSize) -> CGFloat {
    min(size.width, size.height) * 0.6
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
  }
}
