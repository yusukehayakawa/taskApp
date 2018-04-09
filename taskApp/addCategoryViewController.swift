//
//  addCategoryViewController.swift
//  taskApp
//
//  Created by HayakawaYusuke on 2018/04/07.
//  Copyright © 2018年 HayakawaYusuke. All rights reserved.
//

import UIKit
import RealmSwift

class addCategoryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    let realm = try! Realm()
    var category = Category()
    var categories = try! Realm().objects(Category.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
     // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    //    保存ボタンを押したら新しいカテゴリーが保存される
    @IBAction func saveCategory(_ sender: Any) {
        try! realm.write {
            print(category)
            self.category.name = self.categoryTextField.text!
            self.realm.add(self.category, update: true)
        }
        super.viewDidLoad()
    }
    
}
