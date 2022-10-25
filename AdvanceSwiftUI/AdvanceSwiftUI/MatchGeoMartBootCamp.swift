//
//  MatchGeoMartBootCamp.swift
//  AdvanceSwiftUI
//
//  Created by Vipal on 13/10/22.
//

import SwiftUI

struct MatchGeoMartBootCamp: View {
    @State private var showRect : Bool = false
    @Namespace private var  namespace
    var body: some View {
        VStack {
            if(showRect)
            {
                RoundedRectangle(cornerRadius: 20)
                .matchedGeometryEffect(id: "start", in: namespace)
                    .frame(width: 100,height: 100)
            }
            Spacer()
            if(!showRect){
                RoundedRectangle(cornerRadius: 20)
                .matchedGeometryEffect(id: "start", in: namespace)
                    .frame(width: 300,height: 300)
            }
               
                    //.offset(x:0,y: showRect ? UIScreen.main.bounds.height - 300 : 0)
            
          
            Spacer()
            Text("Click Me")
                .onTapGesture {
                    withAnimation(.easeInOut){
                        showRect.toggle()
                    }
                       
                }
        }
    }
}

struct MatchGeoMartBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        MatchGeoMartBootCamp2()
    }
}
struct MatchGeoMartBootCamp2: View {
    let arrOptions : [String] = ["Option1","Option2","Option3"]
    @State private var selecatedOption = ""
    @Namespace private var  namespace
    var body: some View {
        HStack {
            ForEach(arrOptions, id: \.self) { item in
                ZStack {
                    if   self.selecatedOption == item {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.red.opacity(0.7))
                            .matchedGeometryEffect(id: "option", in: namespace)
                    }
                   
                    Text(item)
                      
                }
                .frame(height: 55)
                .padding()
                .onTapGesture {
                    withAnimation(.spring()){
                        self.selecatedOption = item
                    }
                   
                }
            }.frame(maxWidth: .infinity)
            
        }
    }
}
