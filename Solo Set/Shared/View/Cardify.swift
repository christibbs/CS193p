//
//  Cardify.swift
//  Solo Set
//
//  Created by Chris Tibbs on 1/19/21.
//

import SwiftUI

struct Cardify: ViewModifier {
  
  func body(content: Content) -> some View {
    ZStack {
      RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
      RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
      content
    }
  }
  
  private let cornerRadius: CGFloat = 10.0
  private let edgeLineWidth: CGFloat = 3
}

extension View {
  func cardify() -> some View {
    modifier(Cardify())
  }
}
