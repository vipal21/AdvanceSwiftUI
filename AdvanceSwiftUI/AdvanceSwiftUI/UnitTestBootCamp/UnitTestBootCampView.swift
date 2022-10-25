//
//  UnitTestBootCamp.swift
//  AdvanceSwiftUI
//
//  Created by Vipal on 20/10/22.
//

/*
 1. Unit test : Test Business logic of your application
 2. UI test : Test UI of application
 */
import SwiftUI


struct UnitTestBootCampView: View {
    @StateObject private var vm : UnitTestBootCampViewModel
    init(isPremium:Bool) {
        _vm = StateObject(wrappedValue: UnitTestBootCampViewModel(isPremium: isPremium))
    }
    var body: some View {
        VStack {
            ForEach(vm.data , id: \.self) { item in
                Text(item.description)
            }
        }
//        Text(vm.isPremium.description)
    }
}

struct UnitTestBootCampView_Previews: PreviewProvider {
    static var previews: some View {
        UnitTestBootCampView(isPremium: true)
    }
}
