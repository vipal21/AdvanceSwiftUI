//
//  FutureBootcamp.swift
//  AdvanceSwiftUI
//
//  Created by VipalKharva on 2022-10-24.
//

import SwiftUI
import Combine
//Download with Combine
//Download with @escaping Closure
//Convert Escaping closure to combine
class FutureBootcampViewModel : ObservableObject {
    @Published var title:String = ""
    let url  = URL(string: "https://www.google.com")!
    private var cancellable = Set<AnyCancellable>()
    init() {
       download()
    }
    func download(){
        
//        getDatawithclosure {[weak self] value, error in
//            self?.title = value
//
//        }
//        getCombinePublisher()
        getfuturePublisher()
            .sink { _ in

            } receiveValue: { returnValue in
                self.title = returnValue
            }
            .store(in: &cancellable)

    }
    func getCombinePublisher () -> AnyPublisher<String,URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .timeout(1, scheduler: DispatchQueue.main)
            .map({ _ in
                return "new value"
            })
            .eraseToAnyPublisher()
    }
    func getDatawithclosure (compltionHendler :@escaping (_ value :String , _ error:Error?) -> ()){
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            compltionHendler("new value",error)
        }.resume()
    }
    func getfuturePublisher () -> Future<String,Error> {
         Future (){
            promise in
            self.getDatawithclosure {value, error in
               
                if let error = error {
                    promise(.failure(error))
                }else{
                    promise(.success(value))
                }
            }
            }
        }
}
struct FutureBootcamp: View {
    @StateObject private var vm:FutureBootcampViewModel = FutureBootcampViewModel()
    var body: some View {
        Text(vm.title)
    }
}

struct FutureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        FutureBootcamp()
    }
}
