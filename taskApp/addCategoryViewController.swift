//
//  addCategoryViewController.swift
//  taskApp
//
//  Created by HayakawaYusuke on 2018/04/07.
//  Copyright © 2018年 HayakawaYusuke. All rights reserved.
//

import UIKit
import RealmSwift

class addCategoryViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    let realm = try! Realm()
    var category: Category!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = category.name
        var categories = realm.objects(Category.self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    保存ボタンを押したら新しいカテゴリーが保存される
    @IBAction func saveCategory(_ sender: Any) {
        try! realm.write {
            self.category.name = self.textField.text!
            self.realm.add(self.category, update: true)
        }
        super.viewDidLoad()
    }
    
}
