//
//  ProtocolBootCamp.swift
//  AdvanceSwiftUI
//
//  Created by Vipal on 20/10/22.
//

import SwiftUI

struct DefaultTheam : ColorThemeProtocol {
    let primary:Color = .blue
    let secondary:Color = .white
    let tertiary:Color = .gray
}
struct AlterTheam : ColorThemeProtocol {

    
    let primary:Color = .red
    let secondary:Color = .green
    let tertiary:Color = .yellow
}
protocol ColorThemeProtocol {
    var primary:Color { get }
    var secondary:Color { get }
    var tertiary:Color { get }
}

protocol Titletext : ButtonPress {
    var title : String{
        get
    }

}
protocol ButtonPress {
    func buttonPress()
}
class DefaultDataSource:Titletext {
    func buttonPress() {
        print("buttonPress")
    }
    
    var title : String = "Text"
}
class AlterDataSource:Titletext {
    func buttonPress() {
        print("buttonPress")
    }
    
    var title : String = "New TextText"
}
struct ProtocolBootCamp: View {
 
    let theam : ColorThemeProtocol
    let defaultDataSource : Titletext
    var body: some View {
        ZStack {
            theam.primary.ignoresSafeArea()
            Text(defaultDataSource.title)
                .font(.headline)
                .foregroundColor(theam.secondary)
                .padding()
                .background(theam.primary)
                .cornerRadius(10)
                .onTapGesture {
                    defaultDataSource.buttonPress()
                }
        }
    }
}

struct ProtocolBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        ProtocolBootCamp(theam: DefaultTheam(), defaultDataSource: DefaultDataSource())
    }
}
