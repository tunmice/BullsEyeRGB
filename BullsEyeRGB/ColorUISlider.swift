//
//  ColorUISlider.swift
//  BullsEye
//
//  Created by Tunmice on 26/08/2021.
//  Copyright © 2021 Ray Wenderlich. All rights reserved.
//

import SwiftUI
import UIKit

struct ColorUISlider: UIViewRepresentable {
  var color: UIColor
  @Binding var value: Double
  
  func makeCoordinator() -> ColorUISlider.Coordinator {
    Coordinator(value: $value)
  }
  
  func makeUIView(context: Context) -> UISlider {
    let slider = UISlider(frame: .zero)
    slider.thumbTintColor = color
    slider.value = Float(value)
    slider.addTarget(context.coordinator,
      action: #selector(Coordinator.valueChanged(_:)), for: .valueChanged)
    return slider
  }

  func updateUIView(_ view: UISlider, context: Context) {
    view.value = Float(self.value)
    view.alpha = CGFloat(Float(self.value))
  }
  
  class Coordinator: NSObject {
    // 1
    var value: Binding<Double>
    // 2
    init(value: Binding<Double>) {
      self.value = value
    }
    // 3
    @objc func valueChanged(_ sender: UISlider) {
      self.value.wrappedValue = Double(sender.value)
//      self.value.value = Double(sender.value)
    }
  }

 

}

struct ColorUISlider_Previews: PreviewProvider {
    static var previews: some View {
      ColorUISlider(color: .red, value: .constant(0.5))
    }
}
