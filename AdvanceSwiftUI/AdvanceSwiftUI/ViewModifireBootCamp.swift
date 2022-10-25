//
//  ViewModifireBootCamp.swift
//  AdvanceSwiftUI
//
//  Created by Vipal on 13/10/22.
//

import SwiftUI

struct MyButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .cornerRadius(10)
            .shadow(radius: 10)
    }
    
}
struct MyButtonWithColor: ViewModifier {
    var backgroundColor : Color
    func body(content: Content) -> some View {
        content
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
    }
    
}
extension View {
    func mybutton() -> some View{
        modifier(MyButtonStyle())
    }
    func myButtonWithColor(backgroundColor : Color) -> some View {
        modifier(MyButtonWithColor(backgroundColor: backgroundColor))
    }
    
}
struct ViewModifireBootCamp: View {
    var body: some View {
        VStack (spacing: 10) {
            Text("Button")
                .modifier(MyButtonStyle())
                .font(.headline)
                .bold()
            .padding()
            Text("Button2")
                .mybutton()
            
            Text("Button2")
                .myButtonWithColor(backgroundColor: .red)
                .padding()
            Text("Button2")
                .myButtonWithColor(backgroundColor: .yellow)
                .padding()
        }
            
    }
}

struct ViewModifireBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifireBootCamp()
    }
}
