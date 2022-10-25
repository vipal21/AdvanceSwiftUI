//
//  AppNavBar.swift
//  AdvanceSwiftUI
//
//  Created by Vipal on 17/10/22.
//

import SwiftUI

struct AppNavBar: View {
    var body: some View {
   
        CustomNavView {
            ZStack {
                Color.green
                    .ignoresSafeArea()
                CustomNavLink(destination: Text("Destinamtion")
                    .customNavigationTitle("New Title2")
                    .customNavigationSubTitle("SubTitle2")
                
                
                )
                {
                    Text("Navigation")
                }

            }
            .customNavBarItems(title: "title", subTitle: "sub title", backcuttonHidden: true)
//            .customNavigationTitle("New Title")
//            .customNavigationSubTitle("SubTitle")
//            .customNavigationBackbuttonHidden(true)
        }
    }
}

struct AppNavBar_Previews: PreviewProvider {
    static var previews: some View {
        AppNavBar()
    }
}
extension AppNavBar {
    private var defaultNavView : some View{
        NavigationView {
            ZStack {
                Color.green
                    .ignoresSafeArea()
                NavigationLink(destination: Text("Screen2")) {
                    Text("Screen2")
                        .navigationBarBackButtonHidden(false)
                }
            
            }
            NavigationLink(destination: Text("Screen2")) {
                Text("Screen1")
            }
        }
    }
    }

