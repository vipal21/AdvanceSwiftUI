//
//  ViviewRepresentableBoothCamp.swift
//  AdvanceSwiftUI
//
//  Created by Vipal on 19/10/22.
//

import SwiftUI

struct BasicUIViewRepresentable : UIViewRepresentable {
 
  
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
struct BasicUITextFiledRepresentable : UIViewRepresentable {
    @Binding var text: String
    let placeHolder:String
    let placeHolderColor:UIColor
    
    func makeUIView(context: Context) -> some UITextField {
        let txtfiled =  getTextFiled()
        txtfiled.delegate = context.coordinator
        return txtfiled
    }
    //From swiftUI to UI
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.text = text
    }
    private func getTextFiled () -> UITextField {
        let textFiled = UITextField(frame: .zero)
        let attributedString = NSAttributedString(string: placeHolder, attributes: [.foregroundColor : placeHolderColor])
        return textFiled
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    //From UI to swiftUI
    class Coordinator :NSObject, UITextFieldDelegate{
        @Binding var text: String
        init(text: Binding<String>) {
            self._text = text
        }
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}
struct UIViewRepresentableBoothCamp: View {
    @State private var text : String = ""
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            BasicUITextFiledRepresentable(text: $text, placeHolder: "Type Here", placeHolderColor: UIColor.red)
           // TextField("TypeHere", text: $text)
           /// BasicUIViewRepresentable()
        }
       
    }
}

struct UIViewRepresentableBoothCamp_Previews: PreviewProvider {
    static var previews: some View {
        UIViewRepresentableBoothCamp()
    }
}
