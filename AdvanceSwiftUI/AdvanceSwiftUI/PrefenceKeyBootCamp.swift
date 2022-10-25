//
//  PrefenceKeyBootCamp.swift
//  AdvanceSwiftUI
//
//  Created by Vipal on 17/10/22.
//

import SwiftUI

struct PrefenceKeyBootCamp: View {
    @State private  var  text : String = "Hello, World!"
    var body: some View {
        NavigationView {
            VStack {
//                Text(text)
                
                SecondScreen(text:text )
                    .navigationTitle("Navigation Title")
                    
            }
           
        }
        .onPreferenceChange(MyPreferenceKey.self) { value in
            self.text = value
        }
       
     
    }
}

extension View {
    func customTitle (value : String) -> some View {
        preference(key: MyPreferenceKey.self, value: value)
    }
}
struct PrefenceKeyBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        PrefenceKeyBootCamp()
    }
}

struct SecondScreen: View {
    let text : String
    var body: some View {
     
            VStack {
                Text(text)
            }
            .customTitle(value: "NewTitle")
        //.preference(key: MyPreferenceKey.self,value: "Vipal")
     
    }
}
struct MyPreferenceKey: PreferenceKey {
    static var defaultValue: String = ""
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}
