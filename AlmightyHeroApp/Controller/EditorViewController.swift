//
//  EditorViewController.swift
//  AlmightyHeroApp
//  
//  Created by YoheiOsako on 2022/05/15.
//

import UIKit
import SwiftUI

class EditorViewController: UIViewController {
    @IBOutlet weak var inputDateTextField: UITextField!
    @IBOutlet weak var inputPushUpTextField: UITextField!
    @IBOutlet weak var inputSitUpTextField: UITextField!
    @IBOutlet weak var inputSquatTextField: UITextField!
    @IBOutlet weak var inputRunningTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDateTextField()
        configureTextField()
    }

    @objc func didTapDone() {
        view.endEditing(true)
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

    var toolBar: UIToolbar {
        // キーボードに閉じるボタンを作成
        let toolBarRect = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35)
        let toolBar = UIToolbar(frame: toolBarRect)
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let done = UIBarButtonItem(title: "閉じる", style: .done, target: self, action: #selector(didTapDone))
        toolBar.items = [space, done]
        // 他の場所をタップした時にキーボードが閉じるようにする
        let tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGR.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGR)
        return toolBar
    }

    @objc func didChangeDate(picker: UIDatePicker) {
        inputDateTextField.text = dateFormatter.string(from: picker.date)
    }

    var datePicker: UIDatePicker {
        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.timeZone = .current
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ja-JP")
        datePicker.date = Date()
        datePicker.addTarget(self, action: #selector(didChangeDate), for: .valueChanged)
        return datePicker
    }

    var dateFormatter: DateFormatter {
        let dateFormatt = DateFormatter()
        dateFormatt.dateStyle = .long
        dateFormatt.timeZone = .current
        dateFormatt.locale = Locale(identifier: "ja-JP")
        return dateFormatt
    }

    // 日付テキストフィールドの設定
    func configureDateTextField() {
        inputDateTextField.inputView = datePicker
        inputDateTextField.inputAccessoryView = toolBar
        inputDateTextField.text = dateFormatter.string(from: Date())
    }

    // 腕立て伏せ、上体起こし、スクワット、ランニングのテキストフィールドの設定
    func configureTextField() {
        inputPushUpTextField.inputAccessoryView = toolBar
        inputSitUpTextField.inputAccessoryView = toolBar
        inputSquatTextField.inputAccessoryView = toolBar
        inputRunningTextField.inputAccessoryView = toolBar
    }
}
