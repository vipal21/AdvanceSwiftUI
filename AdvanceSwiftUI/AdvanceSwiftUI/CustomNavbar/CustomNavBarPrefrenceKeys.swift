//
//  CustomNavBarPrefrenceKeys.swift
//  AdvanceSwiftUI
//
//  Created by Vipal on 18/10/22.
//

import Foundation
import SwiftUI

struct CustomNavBarTitlePrefrenceKey : PreferenceKey {
    static var defaultValue: String = ""
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
    
}
struct CustomNavBarSubTitlePrefrenceKey : PreferenceKey {
    static var defaultValue: String? = ""
    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = nextValue()
    }
    
}
struct CustomNavBarBackButtonPrefrenceKey : PreferenceKey {
    static var defaultValue: Bool = false
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
    
}
extension View {
    func customNavigationTitle(_ title :String) -> some View{
        preference(key: CustomNavBarTitlePrefrenceKey.self, value: title)
    }
    func customNavigationSubTitle(_ subTitle :String?) -> some View{
        preference(key: CustomNavBarSubTitlePrefrenceKey.self, value: subTitle)
    }
    func customNavigationBackbuttonHidden(_ hide :Bool) -> some View{
        preference(key: CustomNavBarBackButtonPrefrenceKey.self, value: hide)
    }
    func customNavBarItems (title:String = "" , subTitle : String? = nil , backcuttonHidden : Bool = false) -> some View {
       self
        .customNavigationTitle(title)
        .customNavigationSubTitle(subTitle)
        .customNavigationBackbuttonHidden(backcuttonHidden)
        
    }
    
}
//@State private var showBackButton : Bool = true
//@State private var title :String = "title"
//@State private var subTitle:String? = "subTitle"
