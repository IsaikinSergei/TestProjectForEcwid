//
//  ClothesModel.swift
//  TestProjectForEcwid
//
//  Created by Sergei Isaikin on 15.02.2021.
//

import Foundation

struct Clothes {
    
    var name: String
    var price: String
    var quantity: String
    var image: String
    
    static let clothesName = ["Худи", "Свитшот", "Джоггеры", "Поло", "Рубашка", "Футболка", "Шорты", "Куртка", "Шапка", "Бейсболка", "Жилетка", "Кроссовки", "Ботинки", "Ветровка", "Брюки"]
    
    static func getClothes() -> [Clothes] {
        
        var clothes = [Clothes]()
        
        for item in clothesName {
            clothes.append(Clothes(name: item, price: "Цена: 5 500 ₽", quantity: "В наличии: 7 шт.", image: item))
        }
        return clothes
    }
        
}
