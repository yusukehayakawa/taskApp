//
//  InputViewController.swift
//  taskApp
//
//  Created by HayakawaYusuke on 2018/04/07.
//  Copyright © 2018年 HayakawaYusuke. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class InputViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dataPicker: UIDatePicker!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var addCategory: UIButton!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    var task: Task!
    let realm = try! Realm()
    var categories = try! Realm().objects(Category.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
//        addGestureRecognizer(_:)メソッドを使ってviewにUITapGestureRecognizerを登録&呼び出し
        self.view.addGestureRecognizer(tapGesture)
        
        titleTextField.text = task.title
        dataPicker.date = task.date
        contentsTextView.text = task.contents
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        try! realm.write {
            self.task.title = self.titleTextField.text!
            self.task.date = self.dataPicker.date
            self.task.contents = self.contentsTextView.text
            self.realm.add(self.task, update: true)
        }
        setNotification(task: task)
        super.viewWillDisappear(animated)
    }
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
//    ＋->追加画面へ
//        performSegue(withIdentifier: "categorySegue", sender: nil)
    @IBAction func addCategory(_ sender: Any) {
    }
    
    
    
    // タスクのローカル通知を登録する
    func setNotification(task: Task) {
        let content = UNMutableNotificationContent()
        // タイトルと内容を設定(中身がない場合メッセージ無しで音だけの通知になるので「(xxなし)」を表示する)
        if task.title == "" {
            content.title = "(タイトルなし)"
        } else {
            content.title = task.title
        }
        if task.contents == "" {
            content.body = "(内容なし)"
        } else {
            content.body = task.contents
        }
        content.sound = UNNotificationSound.default()
        
        // ローカル通知が発動するtrigger（日付マッチ）を作成
        let calender = Calendar.current
        let dateComponents = calender.dateComponents([.year, .month, .day, .hour, .minute], from: task.date)
        let trigger = UNCalendarNotificationTrigger.init(dateMatching: dateComponents, repeats: false)
        
         // identifier, content, triggerからローカル通知を作成（identifierが同じだとローカル通知を上書き保存）
        let request = UNNotificationRequest.init(identifier: String(task.id), content: content, trigger: trigger)
        
        // ローカル通知を登録
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            print(error ?? "ローカル通知登録 OK!!!!!")
        }
        
        // 未通知のローカル通知一覧をログ出力
        center.getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
            for request in requests {
                print("/------------")
                print(request)
                print("------------/")
            }
        }
    }
}
