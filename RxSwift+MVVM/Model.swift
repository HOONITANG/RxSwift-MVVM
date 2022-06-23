//
//  Model.swift
//  RxSwift+MVVM
//
//  Created by Taehoon Kim on 2022/06/23.
//

import Foundation

struct PayList {
    var id: Int
    var startDate: String = ""
    var finishDate: String = ""
    var name: String
    var price: String
    
    init(id: Int, startDate: String, finishDate: String, name: String, price: String) {
        self.id = id
        self.startDate = startDate
        self.finishDate = finishDate
        self.name = name
        self.price = price
    }
}
