//
//  CustomNavLink.swift
//  AdvanceSwiftUI
//
//  Created by Vipal on 18/10/22.
//

import SwiftUI
//public struct NavigationLink<Label, Destination> : View where Label : View, Destination : View
struct CustomNavLink <Label : View, Destination: View> : View {
    
    let destination :Destination
    let label :Label
    
    init(destination: Destination, @ViewBuilder label: () -> Label){
        self.destination = destination
        self.label = label()
        
    }
    var body: some View {
        
        
        
        NavigationLink {
            CustomNavBarContinerView {
               destination
            }
            .navigationBarBackButtonHidden(true)
        } label: {
            label
            
        }


    }
}

struct CustomNavLink_Previews: PreviewProvider {
    static var previews: some View {
        
            CustomNavView {
                CustomNavLink(destination: Text("destination")) {
                    Text("Click Me")
                
            }
              
        }
      
          
        
    }
}
