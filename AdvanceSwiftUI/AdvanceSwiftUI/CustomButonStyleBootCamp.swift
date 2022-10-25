//
//  CustomButonStyleBootCamp.swift
//  AdvanceSwiftUI
//
//  Created by Vipal on 13/10/22.
//

import SwiftUI

struct MybuttonStyle : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0 )
    }
}
struct MybuttonStyle2 : ButtonStyle {
    var opacity : CGFloat
    var scaleSize : CGFloat
    init(opacity: CGFloat, scaleSize: CGFloat) {
        self.opacity = opacity
        self.scaleSize = scaleSize
    }
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? opacity : 1.0)
            .scaleEffect(configuration.isPressed ? scaleSize : 1.0 )
    }
}
extension View {
    func createButtonWith(opacity: CGFloat, scaleSize: CGFloat) -> some View {
        buttonStyle(MybuttonStyle2(opacity:opacity , scaleSize: scaleSize))
    }
}
struct CustomButonStyleBootCamp: View {
    var body: some View {
        Button {
            
        } label: {
            Text("Button1")
                .font(.headline)
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(20)
                .padding()
               
        }
        .createButtonWith(opacity: 0.9, scaleSize: 0.9)
      //  .buttonStyle(MybuttonStyle())
      //  .buttonStyle(.plain)
      //  .buttonStyle(.automatic)
      //  .buttonStyle(.bordered)
       // .buttonStyle(.borderedProminent)
       // .buttonStyle(.borderless)

       
    }
}

struct CustomButonStyleBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        CustomButonStyleBootCamp()
    }
}
