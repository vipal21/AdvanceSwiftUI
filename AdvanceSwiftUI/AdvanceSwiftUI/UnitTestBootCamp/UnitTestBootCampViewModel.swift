//
//  UnitTestBootCampViewModel.swift
//  AdvanceSwiftUI
//
//  Created by Vipal on 20/10/22.
//

import Foundation
import SwiftUI
import Combine
protocol NewDataServiceProtocol {
    func downloadItemWithEscaping(complition: @escaping (_ items : [String]) -> ())
    func downloadItemsWithCombine () -> AnyPublisher<[String],Error>
}
class NewMoeckDataService : NewDataServiceProtocol {
    let items : [String]
    init(items : [String]? ) {
        
        self.items = items ?? ["one","two","three"]
       
    }
  
    func downloadItemWithEscaping(complition: @escaping (_ items : [String]) -> ()){
        DispatchQueue.main.asyncAfter(deadline: .now()+3){
            complition(self.items)
        }
    }
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error> {
            Just(items)
                .tryMap({ publishedItems in
                    guard !publishedItems.isEmpty else {
                        throw URLError(.badServerResponse)
                    }
                    return publishedItems
                })
                .eraseToAnyPublisher()
        }
}
class UnitTestBootCampViewModel : ObservableObject {
    @Published var isPremium :Bool
    @Published var data :[String] = []
    @Published var selectedItem :String? = nil
    var cancellable = Set<AnyCancellable>()
    let dataService :NewDataServiceProtocol
    init(isPremium: Bool ,dataService : NewDataServiceProtocol = NewMoeckDataService(items: nil)) {
        self.isPremium = isPremium
        self.dataService = dataService
    }
    enum DataError : LocalizedError
    {
        case nodata
        case itemNotFound
    }
    func addItem(item :String) {
        guard !item.isEmpty else{return}
        data.append(item)
    }
    func selectedItem (item:String){
        if let x = data.first(where: {$0 == item})
        {
            selectedItem = x
        }else{
            selectedItem = nil
        }
    }
    func save (item : String) throws {
        guard !item.isEmpty else {
            throw DataError.nodata
        }
        
        if let x = data.first(where: {$0 == item})
        {
           print("Save Data")
        }else{
            throw DataError.itemNotFound
        }
        
    }
    func downlodWithEscaping() {
        dataService.downloadItemWithEscaping {[weak self] items in
            self?.data = items
        }
    }
    func downlodWithCombine() {
        dataService.downloadItemsWithCombine()
            .sink { _ in
                
            } receiveValue: {[weak self] returnedData in
                self?.data = returnedData
            }
            .store(in: &cancellable)

    }
}
