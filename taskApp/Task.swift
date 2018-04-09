//
//  Task.swift
//  taskApp
//
//  Created by HayakawaYusuke on 2018/04/07.
//  Copyright © 2018年 HayakawaYusuke. All rights reserved.
//

//Realmのモデルクラス

import RealmSwift

//Realmの基本クラスである Object を継承して、Task クラスを作成
class Task: Object {
    @objc dynamic var id = 0
    
    @objc dynamic var title = ""
    @objc dynamic var contents = ""
    @objc dynamic var date = Date()
    @objc dynamic var category: Category?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class Category: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    
    let tasks = LinkingObjects(fromType: Task.self, property: "category")
}
