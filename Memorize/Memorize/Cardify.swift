//
//  Cardify.swift
//  Memorize
//
//  Created by Chris Tibbs on 1/1/21.
//

import SwiftUI

struct Cardify: AnimatableModifier {
  var rotation: Double

  var isFaceUp: Bool {
    rotation < 90
  }

  init(isFaceUp: Bool) {
    rotation = isFaceUp ? 0 : 180
  }

  var animatableData: Double {
    get { return rotation }
    set { rotation = newValue }
  }

  func body(content: Content) -> some View {
    ZStack {
      Group {
        RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
        RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
        content
      }.opacity(isFaceUp ? 1 : 0)
      RoundedRectangle(cornerRadius: cornerRadius).fill()
        .opacity(isFaceUp ? 0 : 1)
    }
    .aspectRatio(aspectRatio, contentMode: .fit)
    .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
  }

  private let cornerRadius: CGFloat = 10.0
  private let edgeLineWidth: CGFloat = 3
  private let aspectRatio = CGSize(width: 2, height: 3)
}

extension View {
  func cardify(isFaceUp: Bool) -> some View {
    modifier(Cardify(isFaceUp: isFaceUp))
  }
}
