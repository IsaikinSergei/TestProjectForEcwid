//
//  RealmManager.swift
//  TestProjectForEcwid
//
//  Created by Sergei Isaikin on 16.02.2021.
//

import RealmSwift

let realm = try! Realm()

class RealmManager {
    
    static func saveObject(_ item: Clothes) {
        
        try! realm.write {
            realm.add(item)
        }
    }
    
    static func deleteObject(_ item: Clothes) {
        
        try! realm.write {
            realm.delete(item)
        }
    }
}
