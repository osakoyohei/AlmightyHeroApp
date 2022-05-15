//
//  EditorViewController.swift
//  AlmightyHeroApp
//  
//  Created by YoheiOsako on 2022/05/15.
//

import UIKit
import SwiftUI

class EditorViewController: UIViewController {
    @IBOutlet weak var inputPushUpTextField: UITextField!
    @IBOutlet weak var inputSitUpTextField: UITextField!
    @IBOutlet weak var inputSquatTextField: UITextField!
    @IBOutlet weak var inputRunningTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
    }

    @objc func didTapDone() {
        view.endEditing(true)
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

    func configureTextField() {
        // キーボードに閉じるボタンを作成
        let toolBarRect = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35)
        let toolBar = UIToolbar(frame: toolBarRect)
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let done = UIBarButtonItem(title: "閉じる", style: .done, target: self, action: #selector(didTapDone))
        toolBar.items = [space, done]
        inputPushUpTextField.inputAccessoryView = toolBar
        inputSitUpTextField.inputAccessoryView = toolBar
        inputSquatTextField.inputAccessoryView = toolBar
        inputRunningTextField.inputAccessoryView = toolBar
        // 他の場所をタップした時にキーボードが閉じるようにする
        let tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGR.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGR)
    }
}
