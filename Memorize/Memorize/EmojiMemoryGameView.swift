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

  private func body(for size: CGSize) -> some View {
    ZStack {
      if card.isFaceUp {
        RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
        RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
        Pie(
          startAngle: Angle.degrees(0 - 90),
          endAngle: Angle.degrees(110 - 90),
          clockwise: true
        ).padding(5).opacity(0.4)
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

  private let cornerRadius: CGFloat = 10.0
  private let edgeLineWidth: CGFloat = 3
  private let aspectRatio = CGSize(width: 2, height: 3)

  private func fontSize(for size: CGSize) -> CGFloat {
    min(size.width, size.height) * 0.5
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let game = EmojiMemoryGame()
    game.choose(card: game.cards[0])
    return EmojiMemoryGameView(viewModel: game)
  }
}
