//
//  ContentView.swift
//  BullsEyeRGB
//
//  Created by Tunmice on 24/08/2021.
//

import SwiftUI

struct ContentView: View {
    
    let rTarget = Double.random(in: 0..<1)
    let gTarget = Double.random(in: 0..<1)
    let bTarget = Double.random(in: 0..<1)
    @State var rGuess: Double
    @State var gGuess: Double
    @State var bGuess: Double
    @State var showAlert = false
    @ObservedObject var timer = TimeCounter()
    func computeScore() -> Int {
      let rDiff = rGuess - rTarget
      let gDiff = gGuess - gTarget
      let bDiff = bGuess - bTarget
      let diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
      return Int((1.0 - diff) * 100.0 + 0.5)
    }
    

    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack {
                        Color(red: rTarget, green: gTarget, blue: bTarget)
                           
                        self.showAlert ? Text("R: \(Int(rTarget * 255.0))"
                          + "  G: \(Int(gTarget * 255.0))"
                          + "  B: \(Int(bTarget * 255.0))")
                        
                          : Text("Match this color")
                        
                            
                    }
                    
                    VStack {
                        ZStack {
                            Color(red: rGuess, green: gGuess, blue: bGuess)
                            
                            Text(String(timer.counter))
                                .foregroundColor(.black)
                              .padding(.all, 5)
                              .background(Color.white)
                              .mask(Circle())
                        }
                            
                        Text("R: \(Int(rGuess * 255.0))"
                          + " G: \(Int(gGuess * 255.0))"
                          + " B: \(Int(bGuess * 255.0))")
                            
                    }
                }
               
                VStack {
                    ColorSlider(value: $rGuess, textColor: .red)
                    ColorSlider(value: $bGuess, textColor: .blue)
                    ColorSlider(value: $gGuess, textColor: .green)
                }.padding(.horizontal)
                
                Button(action: {self.showAlert = true
                    self.timer.killTimer()
                }) {
                    Text("Hit me!")
                        .foregroundColor(.red)
                }.alert(isPresented: $showAlert) {
                    Alert(title: Text("Your Score"),
                          message: Text(String(computeScore())))
                  }.padding()
                
            }
        }
    
//        .padding(5)
        
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)
       
          .previewLayout(.fixed(width: 568, height: 320))
//
    }
}

struct ColorSlider: View {
  @Binding var value: Double
  var textColor: UIColor
  var body: some View {
    HStack {
      Text("0").foregroundColor(Color(textColor))
      ColorUISlider(color: textColor, value: $value)
        

     
      Text("255").foregroundColor(Color(textColor))
    }
    // .padding(.horizontal)
  }
}
