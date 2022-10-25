//
//  UIViewControllerRepresentableBootCamp.swift
//  AdvanceSwiftUI
//
//  Created by Vipal on 19/10/22.
//

import SwiftUI


struct UIViewControllerRepresentableBootCamp: View {
    @State private var showScreen : Bool = false
    @State private var image : UIImage? = nil
    var body: some View {
        VStack {
            Text("Hi")
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300,height: 300)
            }
            Button("Button") {
                showScreen.toggle()
            }.sheet(isPresented: $showScreen) {
//                BasicUIViewControllerRepresentableBootCamp(lblText: "Hello")
                UIImagePickerController1(image: $image, showScreen: $showScreen)
            }
        }
    }
}
struct UIViewControllerRepresentableBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerRepresentableBootCamp()
    }
}

struct BasicUIViewControllerRepresentableBootCamp : UIViewControllerRepresentable {
    let lblText : String

    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = MyVC()
        vc.lblText = lblText
        return vc
    }
    //SWIFTUI to UIKIT
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    //UIKIT to SWIFTUI
    func makeCoordinator() -> () {
        
    }
    
}
struct UIImagePickerController1 : UIViewControllerRepresentable
   
{
    @Binding var image : UIImage?
    @Binding  var showScreen : Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc  = UIImagePickerController()
        vc.allowsEditing = false
        vc.delegate = context.coordinator
        return vc
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(image: $image, showScreen: $showScreen)
    }
    class Coordinator : NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
        @Binding var image: UIImage?
        @Binding  var showScreen : Bool
        
        init(image: Binding<UIImage?>,showScreen: Binding<Bool>) {
            self._image = image
            self._showScreen = showScreen
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            guard let newImage = info[.originalImage] as? UIImage else {return}
            
            image = newImage
            showScreen = false
        }
    }
}


class MyVC : UIViewController{
    var lblText : String = ""
    override func viewDidLoad() {
        super .viewDidLoad()
            let lable  =  UILabel()
            lable.text = lblText
            
            view.addSubview(lable)
            lable.frame = view.frame
        
    }
}
