//
//  GenericsBootcamp.swift
//  AdvanceSwiftUI
//
//  Created by Vipal on 14/10/22.
//

import SwiftUI


struct GenericView<T : View> : View {
    var content : T
    var title : String
    var body: some View {
        Text (title)
        content
    }
}
struct GenericsBootcamp: View {
 
    
    var body: some View {
        VStack {
            GenericView(content: Text("kharva"), title: "Vipal")
           
        }
    }
}

struct GenericsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GenericsBootcamp()
    }
}
