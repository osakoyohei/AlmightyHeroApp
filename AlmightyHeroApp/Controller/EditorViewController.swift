//
//  EditorViewController.swift
//  AlmightyHeroApp
//  
//  Created by YoheiOsako on 2022/05/15.
//

import UIKit
import RealmSwift

protocol EditorViewControllerDelegate {
    func recordUpdate()
}

class EditorViewController: UIViewController {
    @IBOutlet weak var inputDateTextField: UITextField!
    @IBOutlet weak var inputPushUpTextField: UITextField!
    @IBOutlet weak var inputSitUpTextField: UITextField!
    @IBOutlet weak var inputSquatTextField: UITextField!
    @IBOutlet weak var inputRunningTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBAction func saveButton(_ sender: UIButton) {
        saveRecord()
    }
    @IBOutlet weak var deleteButton: UIButton!
    @IBAction func deleteButton(_ sender: UIButton) {
        deleteRecord()
    }
    
    var record = TrainingRecord()
    var delegate: EditorViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDateTextField()
        configureTrainingTextField()
        configureSaveButton()
        configureDeleteButton()
        closeKeyboard()
        // キーボードの表示の通知を受け取る
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        // キーボードの非表示の通知を受け取る
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)),name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // キーボードが表示された時
    @objc private func keyboardWillShow(sender: NSNotification) {
        guard let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
            }
        let noneMoveHeight = view.frame.origin.y + view.frame.size.height - keyboardSize.height
        if noneMoveHeight <= inputRunningTextField.frame.midY {
            if inputRunningTextField.isFirstResponder {
                guard let userInfo = sender.userInfo else { return }
                let duration: Float = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).floatValue
                UIView.animate(withDuration: TimeInterval(duration), animations: { () -> Void in
                    let transform = CGAffineTransform(translationX: 0, y: -200)
                    self.view.transform = transform
                })
            } else if inputSquatTextField.isFirstResponder {
                guard let userInfo = sender.userInfo else { return }
                let duration: Float = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).floatValue
                UIView.animate(withDuration: TimeInterval(duration), animations: { () -> Void in
                    let transform = CGAffineTransform(translationX: 0, y: -150)
                    self.view.transform = transform
                })
            }
        } else {
            print("キーボードを動かす必要なし")
        }
    }

    // キーボードが閉じられた時
    @objc private func keyboardWillHide(sender: NSNotification) {
        guard let userInfo = sender.userInfo else { return }
        let duration: Float = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).floatValue
        UIView.animate(withDuration: TimeInterval(duration), animations: { () -> Void in
            self.view.transform = CGAffineTransform.identity
        })
    }

    var toolBar: UIToolbar {
        // キーボードに完了ボタンを作成
        let toolBarRect = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 45)
        let toolBar = UIToolbar(frame: toolBarRect)
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let done = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(didTapDone))
        toolBar.items = [space, done]
        return toolBar
    }

    @objc func didTapDone() {
        view.endEditing(true)
    }

    func closeKeyboard() {
        // 他の場所をタップした時にキーボードが閉じるようにする
        let tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGR.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGR)
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

    var datePicker: UIDatePicker {
        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.timeZone = .current
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ja-JP")
        datePicker.date = record.date
        datePicker.addTarget(self, action: #selector(didChangeDate), for: .valueChanged)
        return datePicker
    }

    @objc func didChangeDate(picker: UIDatePicker) {
        inputDateTextField.text = dateFormatter.string(from: picker.date)
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
        inputDateTextField.text = dateFormatter.string(from: record.date)
    }

    // 腕立て伏せ、上体起こし、スクワット、ランニングのテキストフィールドの設定
    func configureTrainingTextField() {
        inputPushUpTextField.inputAccessoryView = toolBar
        inputSitUpTextField.inputAccessoryView = toolBar
        inputSquatTextField.inputAccessoryView = toolBar
        inputRunningTextField.inputAccessoryView = toolBar
        inputPushUpTextField.text = String(record.pushUp)
        inputSitUpTextField.text = String(record.sitUp)
        inputSquatTextField.text = String(record.squat)
        inputRunningTextField.text = String(record.running)
    }

    // トレーニング保存ボタンの設定
    func configureSaveButton() {
        // ボタンを角丸にする
        saveButton.layer.cornerRadius = 5
    }

    // トレーニングデータの保存
    func saveRecord() {
        let realm = try! Realm()
        try! realm.write {
            if let dateText = inputDateTextField.text,
               let date = dateFormatter.date(from: dateText) {
                record.date = date
            }
            if let pushUpText = inputPushUpTextField.text,
               let pushUp = Int(pushUpText) {
                record.pushUp = pushUp
            }
            if let sitUpText = inputSitUpTextField.text,
               let sitUp = Int(sitUpText) {
                record.sitUp = sitUp
            }
            if let squatText = inputSquatTextField.text,
               let squat = Int(squatText) {
                record.squat = squat
            }
            if let runningText = inputRunningTextField.text,
               let running = Double(runningText) {
                record.running = running
            }
            realm.add(record)
        }
        delegate?.recordUpdate()
        dismiss(animated: true)
    }

    // トレーニング削除ボタンの設定
    func configureDeleteButton() {
        // ボタンを角丸にする
        deleteButton.layer.cornerRadius = 5
    }

    // トレーニングデータの削除
    func deleteRecord() {
        let calendar = Calendar(identifier: .gregorian)
        let startOfDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: record.date)!
        let endOfDate = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: record.date)!
        let realm = try! Realm()
        let recordList = Array(realm.objects(TrainingRecord.self).filter("date BETWEEN {%@, %@}", startOfDate, endOfDate))
        recordList.forEach({ record in
            try! realm.write {
                realm.delete(record)
            }
            delegate?.recordUpdate()
            dismiss(animated: true)
        })
    }
}
