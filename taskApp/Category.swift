//
//  Category.swift
//  taskApp
//
//  Created by HayakawaYusuke on 2018/04/07.
//  Copyright © 2018年 HayakawaYusuke. All rights reserved.
//

import RealmSwift

class Category: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    
    let tasks = LinkingObjects(fromType: Task.self, property: "category")
}
