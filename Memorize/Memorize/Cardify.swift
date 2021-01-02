//
//  Cardify.swift
//  Memorize
//
//  Created by Chris Tibbs on 1/1/21.
//

import SwiftUI

struct Cardify: ViewModifier {
  var isFaceUp: Bool

  func body(content: Content) -> some View {
    ZStack {
      if isFaceUp {
        RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
        RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
        content

      } else {
        RoundedRectangle(cornerRadius: cornerRadius).fill()
      }
    }.aspectRatio(aspectRatio, contentMode: .fit)
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
