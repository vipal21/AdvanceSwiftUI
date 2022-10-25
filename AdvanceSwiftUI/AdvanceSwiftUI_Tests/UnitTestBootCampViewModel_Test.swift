//
//  UnitTestBootCampViewModel_Test.swift
//  AdvanceSwiftUI_Tests
//
//  Created by Vipal on 20/10/22.
//

import XCTest
@testable import AdvanceSwiftUI
import Combine
//Naming Strcture : test_UnitOfWork_StateUnderTest_ExpectedBehveior
//NAming : test_(Class or struct name)_variableORfunc_[expected result]
//Testing Structure :  given,when ,then
final class UnitTestBootCampViewModel_Test: XCTestCase {

    var viewModel : UnitTestBootCampViewModel?
    var cancellable  = Set<AnyCancellable>()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = UnitTestBootCampViewModel(isPremium: Bool.random())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func test_UnitTestBootCampViewModel_isPremium_shouldBeTrue(){
        //Given
        let userisPremium : Bool = true
        //When
      let vm =   UnitTestBootCampViewModel(isPremium: userisPremium)
        //Then
        XCTAssertTrue(vm.isPremium)
    }
    func test_UnitTestBootCampViewModel_isPremium_shouldBeFalse(){
        //Given
        let userisPremium : Bool = false
        //When
      let vm =   UnitTestBootCampViewModel(isPremium: userisPremium)
        //Then
        XCTAssertFalse(vm.isPremium)
     
    }
    func test_UnitTestBootCampViewModel_isPremium_shouldBeInjectedValue(){
        //Given
        let userisPremium  = Bool.random()
        //When
      let vm =   UnitTestBootCampViewModel(isPremium: userisPremium)
        //Then
        XCTAssertEqual(vm.isPremium, userisPremium)
     
    }
    func test_UnitTestBootCampViewModel_isPremium_shouldBeInjectedValue_stress(){
        
        for _ in 0..<10 {
            //Given
            let userisPremium  = Bool.random()
            //When
          let vm =   UnitTestBootCampViewModel(isPremium: userisPremium)
            //Then
            XCTAssertEqual(vm.isPremium, userisPremium)
        }

     
    }
    func test_UnitTestBootCampViewModel_isPremium_Data_shouldbeEmpty(){
        //Given
     
        //When
        guard let vm =   viewModel else {return}
        
        //Then
        XCTAssertTrue(vm.data.isEmpty)
        XCTAssertEqual(vm.data.count, 0)
    }
 
    func test_UnitTestBootCampViewModel_isPremium_Data_shouldaddItem(){
        //Given
        guard let vm =   viewModel else {return}
        //When
        let loopCount = Int.random(in: 1..<100)
        
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
   
       
        
        
        //Then
        XCTAssertTrue(!vm.data.isEmpty)
        XCTAssertFalse(vm.data.isEmpty)
        XCTAssertEqual(vm.data.count, loopCount) //IMP
        XCTAssertNotEqual(vm.data.count, 0)
        XCTAssertGreaterThan(vm.data.count, 0)
      //  XCTAssertGreaterThanOrEqual()
      //  XCTAssertLessThan()
      //  XCTAssertLessThanOrEqual()
    }
    func test_UnitTestBootCampViewModel_isPremium_Data_shouldNotEmptyString(){
        //Given
      
        guard let vm =   viewModel else {return}
        //When
        vm.addItem(item: "")
        
        //Then
        XCTAssertTrue(vm.data.isEmpty)
   

    }
    
    func test_UnitTestBootCampViewModel_isPremium_SelectedItem_shouldbeStartAsNil(){
        //Given
        
        //When
        let vm =   UnitTestBootCampViewModel(isPremium: Bool.random())
      
        
        //Then
        XCTAssertTrue(vm.selectedItem == nil)
        XCTAssertNil(vm.selectedItem)

    }
    func test_UnitTestBootCampViewModel_isPremium_SelectedItem_shouldbeNillwhenSelectedInvalideItem(){
        //Given
        let vm =   UnitTestBootCampViewModel(isPremium: Bool.random())
        //When
        //Select Valid Item
        
        let newItem = UUID().uuidString
        vm.addItem(item:newItem )
        vm.selectedItem(item: newItem)
        
      //Select inValid Item
        vm.selectedItem(item: UUID().uuidString)
        
        //Then

        XCTAssertNil(vm.selectedItem)

    }

    func test_UnitTestBootCampViewModel_isPremium_SelectedItem_shouldbeSelectedm(){
        //Given
        let vm =   UnitTestBootCampViewModel(isPremium: Bool.random())
        //When
        let newItem = UUID().uuidString
        vm.addItem(item:newItem )
        vm.selectedItem(item: newItem)
        
        //Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual( vm.selectedItem, newItem)

    }
    func test_UnitTestBootCampViewModel_isPremium_SelectedItem_shouldbeSelectedm_stress(){
        //Given
        let vm =   UnitTestBootCampViewModel(isPremium: Bool.random())
        //When
        let loopCount : Int = Int.random(in: 1..<100)
        var  itemArray :[String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item:newItem )
            itemArray.append(newItem)
        }
      
        let randomItem = itemArray.randomElement()

        vm.selectedItem(item: randomItem ?? "")
        
        //Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual( vm.selectedItem, randomItem)

    }
    
    func test_UnitTestBootCampViewModel_SaveItem_shouldbeThrowError_noData(){
        //Given
        let vm =   UnitTestBootCampViewModel(isPremium: Bool.random())
        //When
        let loopCount : Int = Int.random(in: 1..<100)
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item:newItem )
        }
        
        //Then
        XCTAssertThrowsError(try vm.save(item: UUID().uuidString ))
        XCTAssertThrowsError(try vm.save(item: UUID().uuidString ), "Should throw Item Not found ") { error in
            let returnError = error as? UnitTestBootCampViewModel.DataError
            XCTAssertEqual(returnError, UnitTestBootCampViewModel.DataError.itemNotFound)
            
        }
        XCTAssertThrowsError(try vm.save(item: "" ))
        XCTAssertThrowsError(try vm.save(item: "" ), "Should throw No Data ") { error in
            let returnError = error as? UnitTestBootCampViewModel.DataError
            XCTAssertEqual(returnError, UnitTestBootCampViewModel.DataError.nodata)
            
        }
    
       

    }
    func test_UnitTestBootCampViewModel_SaveItem_shouldSaveItem(){
        //Given
        let vm =   UnitTestBootCampViewModel(isPremium: Bool.random())
        //When
        let loopCount : Int = Int.random(in: 1..<100)
        var  itemArray :[String] = []
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item:newItem )
            itemArray.append(newItem)
        }
        let randomItem = itemArray.randomElement() ?? ""
        XCTAssertFalse(randomItem.isEmpty)
        //Then
      
        XCTAssertNoThrow(try vm.save(item: randomItem))

    }
    func test_UnitTestBootCampViewModel_downlodWithEscaping_shouldSaveItem(){
        //Given
        let vm =   UnitTestBootCampViewModel(isPremium: Bool.random())
        //When
        let expectation: XCTestExpectation = XCTestExpectation(description: "Should return items after 3 seconds")
        vm.$data
            .dropFirst()
            .sink { data in
                expectation.fulfill()
            }
            .store(in: &cancellable)
        vm.downlodWithEscaping()
        //Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.data.count, 0)
 

    }
    func test_UnitTestBootCampViewModel_downlodWithCombine_shouldSaveItem(){
        //Given
        let vm =   UnitTestBootCampViewModel(isPremium: Bool.random())
        //When
        let expectation: XCTestExpectation = XCTestExpectation(description: "Should return items after 3 seconds")
        vm.$data
            .dropFirst()
            .sink { data in
                expectation.fulfill()
            }
            .store(in: &cancellable)
        vm.downlodWithCombine()
        //Then
        wait(for: [expectation], timeout: 0)
        XCTAssertGreaterThan(vm.data.count, 0)
 

    }
    

}
