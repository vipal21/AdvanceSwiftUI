//
//  DIBootCamp.swift
//  AdvanceSwiftUI
//
//  Created by Vipal on 20/10/22.
//

import SwiftUI
import Combine
// Global Access
// Cant customize the init
// Cant swipe out dependency
struct Post : Identifiable,Codable {
        let userId:Int
        let id : Int
        let title : String
        let body : String
    
}
protocol DataService {
    func getData() -> AnyPublisher <[Post],Error>
}
class MockDataService : DataService{
    let testData:[Post]
    init(testData: [Post]?) {
        self.testData = testData ?? []
    }
    func getData() -> AnyPublisher<[Post], Error> {
        Just(testData)
            .tryMap({$0})
            .eraseToAnyPublisher()
    }
}
class ProductiondataService : DataService {
      let url : URL
      init(url:URL){
          self.url = url
      }
    // let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
     func getData() -> AnyPublisher <[Post],Error> {
      
        URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: [Post].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
}
class DIBootCampViewModel : ObservableObject {
    @Published var dataArrry:[Post] = []
    
    let ps : DataService
    
    var cancellable = Set<AnyCancellable>()
    init(dataService:DataService) {
      
        self.ps = dataService
        self.loadPost()
    }
    func loadPost() {
        ps.getData()
            .sink { _ in
                
            } receiveValue: { [weak self] returnPosts in
                guard let self = self else {return}
                self.dataArrry = returnPosts
            }
            .store(in: &cancellable)

    }
}
struct DIBootCamp: View {
    @StateObject private var vm :DIBootCampViewModel
    init(dataService : DataService) {
        _vm = StateObject(wrappedValue: DIBootCampViewModel(dataService: dataService ))
    }
    var body: some View {
        ScrollView {
            VStack {
                    ForEach(vm.dataArrry) { post in
                        Text(post.title)
                    }
               
            }
          
        }
       
    }
}

struct DIBootCamp_Previews: PreviewProvider {
    static let data = [
    Post(userId: 1, id: 1, title: "One", body: "One"),
    Post(userId: 2, id: 2, title: "Two", body: "Two")
    ]
    static let dataService : DataService = MockDataService(testData: data)//ProductiondataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
    static var previews: some View {
        DIBootCamp(dataService: dataService)
    }
}
