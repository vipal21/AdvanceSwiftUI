//
//  CustomNavBarContinerView.swift
//  AdvanceSwiftUI
//
//  Created by Vipal on 18/10/22.
//

import SwiftUI

struct CustomNavBarContinerView <Content : View>: View {
    let content : Content
    @State private var showBackButton : Bool = true
    @State private var title :String = ""
    @State private var subTitle:String? = nil
    
    init(@ViewBuilder content : () -> Content) {
        self.content = content()
    }
    var body: some View {
        VStack (spacing:0) {
            CustomNavbarView(showBackButton: showBackButton, title: title, subTitle: subTitle)
            content
                .frame(maxWidth: .infinity,maxHeight: .infinity)
        }
        .onPreferenceChange(CustomNavBarTitlePrefrenceKey.self) { value in
            self.title = value
        }
        .onPreferenceChange(CustomNavBarSubTitlePrefrenceKey.self) { value in
            self.subTitle = value
        }
        .onPreferenceChange(CustomNavBarBackButtonPrefrenceKey.self) { value in
            self.showBackButton = !value
        }
       
    }
}

struct CustomNavBarContinerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarContinerView {
            ZStack {
                Color.green
                    .ignoresSafeArea()
                Text("Hello")
                    .foregroundColor(.white)
                    .customNavigationTitle("New Title")
                    .customNavigationSubTitle("SubTitle")
                    .customNavigationBackbuttonHidden(true)

                    }
        }
        
    }
}
