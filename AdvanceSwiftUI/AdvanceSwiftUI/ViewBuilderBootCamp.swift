//
//  ViewBuilderBootCamp.swift
//  AdvanceSwiftUI
//
//  Created by Vipal on 14/10/22.
//

import SwiftUI

struct ViewBuilderBootCamp: View {
    var body: some View {
        VStack {
            HeaderView(title: "Title 1")
            HeaderView(title: "Title 1",description: "123")
            GenericHeaderView(title: "Vipal") {
                Text("Hello")
            }
//            GenericHeaderView(title: "123", content: Text("hello"))
//            GenericHeaderView(title: "123", content: Image(systemName: "heart.fill"))
//            GenericHeaderView(title: "123", content:
//                                    HStack(content: {
//                                    Text("hello")
//                                    Image(systemName: "heart.fill")
//                                }))
            Spacer()
        }
    }
}

struct ViewBuilderBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        ViewBuilderBootCamp()
    }
}
struct GenericHeaderView <CustomType : View>: View {
    var title : String
    let content : CustomType
    init(title:String, @ViewBuilder content : () -> CustomType) {
        self.title = title
        self.content = content()
    }


    var body: some View {
        VStack (alignment: .leading) {
            Text(title)
                .font(.largeTitle)
            content
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
            
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding()
    }
}
struct HeaderView: View {
    var title : String
    var description : String?
    var body: some View {
        VStack (alignment: .leading) {
            Text(title)
                .font(.largeTitle)
            if let description = description {
                Text(description)
                    .font(.callout)
            }
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding()
    }
}
