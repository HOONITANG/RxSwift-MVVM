//
//  MainViewModel.swift
//  RxSwift+MVVM
//
//  Created by Taehoon Kim on 2022/06/23.
//

import Foundation
import RxSwift
import RxCocoa

protocol MainViewModelOutputs {
    var payList: BehaviorRelay<[PayList]> { get }
}

protocol MainViewModelInputs {
    func fetchList(context viewController: UIViewController)
    func selectDateInput(selectedPayList: PayList)
}


class MainViewModel: MainViewModelInputs, MainViewModelOutputs {
    private let disposeBag = DisposeBag()
    var inputs: MainViewModelInputs { return self }
    var outputs: MainViewModelOutputs { return self }
    
    var payList: BehaviorRelay<[PayList]> = BehaviorRelay<[PayList]>(value: [])
    
    init() { }
    
    func fetchList(context viewController: UIViewController) {
        let payList1 = PayList(id: 1, startDate: "", finishDate: "", name: "dummy1", price: "0")
        let payList2 = PayList(id: 2, startDate: "", finishDate: "", name: "dummy2", price: "0")
        let payList3 = PayList(id: 3, startDate: "", finishDate: "", name: "dummy3", price: "0")
        // dummy data
        
        payList.accept([payList1,payList2,payList3])
    }
    
    func selectDateInput(selectedPayList: PayList) {
        
        var tempPayList:[PayList] = []
        payList.value.map { paylist in
            if selectedPayList.id == paylist.id {
                print("id 는 \(selectedPayList.id) 이다")
                print("date 는 \(selectedPayList.startDate)")
                let newPay = PayList(id: paylist.id, startDate: selectedPayList.startDate, finishDate: selectedPayList.finishDate, name: paylist.name, price: paylist.price)
                tempPayList.append(newPay)
            }
        }
        
        payList.accept(tempPayList)
    }
}
