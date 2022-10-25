//
//  CustomNavView.swift
//  AdvanceSwiftUI
//
//  Created by Vipal on 18/10/22.
//

import SwiftUI

struct CustomNavView <Content : View>: View {
    let content : Content
    init(@ViewBuilder content:()-> Content) {
        self.content = content()
    }
    var body: some View {
       
        NavigationView {
            CustomNavBarContinerView {
                content

            }
            .navigationBarBackButtonHidden(true)
           
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CustomNavView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavView{
            Color.red
                .ignoresSafeArea()
        }
    }
}
