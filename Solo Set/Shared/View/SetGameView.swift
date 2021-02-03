//
//  SetGameView.swift
//  Shared
//
//  Created by Chris Tibbs on 1/15/21.
//

import SwiftUI

struct SetGameView: View {
  @ObservedObject var viewModel: SetGameViewModel
  
    var body: some View {
      Grid(viewModel.visibleCards) { card in
        CardView(card: card).onTapGesture {
          viewModel.select(card)
        }
      }
    }
  
  init(viewModel: SetGameViewModel) {
    self.viewModel = viewModel
  }
}

struct CardView: View {
  var card: SetGame.Card
  
  var body: some View {
    GeometryReader { geometry in
      body(for: geometry.size)
    }.background(card.isSelected ? Color.gray : Color.white)
  }
  
  @ViewBuilder
  private func body(for size: CGSize) -> some View {
    HStack {
      ForEach(0..<card.number.rawValue) {_ in
        if card.opacity == .clear {
          ShapeView(card.shape, justStroke: card.opacity == .clear).foregroundColor(colorForCard(card)).padding(4)
        } else if card.opacity == .full {
          ShapeView(card.shape, justStroke: card.opacity == .clear).foregroundColor(colorForCard(card)).padding(4)
        } else {
          ShapeView(card.shape, justStroke: card.opacity == .clear).foregroundColor(colorForCard(card)).opacity(0.3)
        }
      }
    }.cardify().padding(10)
  }
  
  func symbolForCard<T: Shape>(_ card: SetGame.Card) -> T {
    if card.shape == .circle {
      return Circle() as! T
    } else if card.shape == .rectangle {
      return Rectangle() as! T
    } else if card.shape == .diamond {
      return Diamond() as! T
    } else {
      assertionFailure()
      return Capsule() as! T
    }
  }
  
  func colorForCard(_ card: SetGame.Card) -> Color {
    switch card.color {
    case .blue:
      return Color.blue
    case .red:
      return Color.red
    case .yellow:
      return Color.yellow
    }
  }
}

struct ShapeView: View {
  var shapeType: SetGame.Card.Shape
  var justStroke: Bool
  
  init(_ shapeType: SetGame.Card.Shape, justStroke: Bool = false) {
    self.shapeType = shapeType
    self.justStroke = justStroke
  }
  
  var body: some View {
    GeometryReader { geometry in
      body(for: geometry.size)
    }
  }
  
  @ViewBuilder
  private func body(for size: CGSize) -> some View {
    switch shapeType {
    case .circle:
      justStroke ? Circle().stroke() as! Circle : Circle()
    case .rectangle:
      justStroke ? Rectangle().stroke() as! Rectangle : Rectangle()
    case .diamond:
      justStroke ? Diamond().stroke() as! Diamond : Diamond()
    }
  }
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
      SetGameView(viewModel: SetGameViewModel())
    }
}
