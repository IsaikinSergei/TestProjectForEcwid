//
//  ClothesModel.swift
//  TestProjectForEcwid
//
//  Created by Sergei Isaikin on 15.02.2021.
//

import UIKit
import RealmSwift

class Clothes: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var price: String?
    @objc dynamic var quantity: String?
    @objc dynamic var imageData: Data?
    
    convenience init(name: String, price: String?, quantity: String?, imageData: Data?) {
        self.init()
        self.name = name
        self.price = price
        self.quantity = quantity
        self.imageData = imageData
        
    }
        
}
