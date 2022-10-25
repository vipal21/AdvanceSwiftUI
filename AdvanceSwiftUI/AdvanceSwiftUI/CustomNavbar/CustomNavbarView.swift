//
//  CustomNavbarView.swift
//  AdvanceSwiftUI
//
//  Created by Vipal on 18/10/22.
//

import SwiftUI

struct CustomNavbarView: View {
    @Environment(\.presentationMode) var presentationMode
    let showBackButton : Bool
    let  title :String
    let   subTitle:String?
    var body: some View {
        HStack {
            if showBackButton{
                backButton
            }
            
            Spacer()
            titleSection
            Spacer()
            if showBackButton{
                backButton
                    .opacity(0)
            }
        }
        .foregroundColor(.white)
        .font(.headline)
        .padding()
        .background(Color.blue)
        .accentColor(.white)
        
     
        
    }
}
extension CustomNavbarView{
    private var backButton : some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
            
        }
    }
    private var titleSection : some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
            if let subTitle = self.subTitle {
                Text(subTitle)
            }
           
        }
    }
   
}
struct CustomNavbarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomNavbarView(showBackButton: true, title: "title",subTitle:"subTitle")
            Spacer()
        }
  
    }
}
