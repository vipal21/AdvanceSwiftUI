//
//  AdvanceCombineBootcamp.swift
//  AdvanceSwiftUI
//
//  Created by VipalKharva on 2022-10-24.
//

import SwiftUI
import Combine
class AdvanceCombineDataService {
 //   @Published var basicPublisher :String = "firstpublish"
   // let currentValuePublisher = CurrentValueSubject<Int,Never>("firstpublish")
    let passThroughPublisher = PassthroughSubject<Int,Error>()
    init() {
        publishFackData()
    }
    private func publishFackData () {
        let items = Array(1..<11)
        
        for i in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)){
              //  self.basicPublisher = items[i]
                self.passThroughPublisher.send(items[i])
                if i == items.indices.last {
                    self.passThroughPublisher.send(completion:.finished) // Very Useful with out this we can not do math and other opration
                }
            }
        }
       
    }
}
class AdvanceCombineBootcampViewModel:ObservableObject{
    @Published var data : [String] = []
    @Published var errorString :String = ""
    private var cancellable = Set<AnyCancellable>()
    private var ds : AdvanceCombineDataService = AdvanceCombineDataService()
    init(){
        addsubscriber()
    }
    private func addsubscriber(){
    
        ds.passThroughPublisher
        //sequence Opration
//            .first() // First value
//            .first(where: {$0 > 4})
//            .tryFirst(where: { int in
//                if int == 3 {
//                    throw URLError(.badServerResponse)
//                }
//                return int > 1
//            })
//
//            .last()
//            .last(where: {$0 < 4})
//            .tryLast(where: { int in
//                if(int == 13){
//                    throw URLError(.badServerResponse)
//                }
//                return int > 1
//            })
//            .dropFirst()
//            .dropFirst(5)
//            .drop(while: {$0 < 6})
//            .tryDrop(while: { int in
//                if int == 15 {
//                    throw URLError(.badServerResponse)
//                }
//                return int < 6
//            })
//            .prefix(4)
//            .prefix(while: {$0 < 5})
//
//            .output(at: 2)
//            .output(in: 2..<4)
        //        Math OPration
//            .max()
//            .max(by: {$0 < $1})
//            .min()
//            .min(by: {$0 < $1})
            
            //Filter and Reduce Operation
//            .map({String($0)})
//            .tryMap({String($0)})
//            .compactMap({ int in
//                if int == 5 {
//                    return nil
//                }
//                return String(int)
//            })
//            .tryCompactMap()
        
//            .filter({ $0 > 5})
//            .removeDuplicates()
//            .removeDuplicates(by: { int1, int2 in
//                 return int1 == int2
//            })
      //      .replaceNil(with: 5) // replace the nill value with  given value
            .map({String($0)})
            .sink { completion in
                switch completion {
                case.finished:
                    break
                case.failure(let error):
                    self.errorString = (error.localizedDescription)
                    break
                }
            } receiveValue: { [weak self] returnedString in

                self?.data .append(returnedString)
            }
            .store(in: &cancellable)

    }
}
struct AdvanceCombineBootcamp: View {
    @StateObject private var vm: AdvanceCombineBootcampViewModel =  AdvanceCombineBootcampViewModel()
    var body: some View {
        ScrollView {
            VStack {
           
                ForEach(vm.data, id: \.self) { item in
                    Text("\(item)")
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                if !vm.errorString.isEmpty{
                    Text(vm.errorString)
                }
            }
        }
      
    }
}

struct AdvanceCombineBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AdvanceCombineBootcamp()
    }
}
