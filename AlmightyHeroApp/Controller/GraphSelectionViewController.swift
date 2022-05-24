//
//  GraphSelectionViewController.swift
//  AlmightyHeroApp
//  
//  Created by YoheiOsako on 2022/05/24.
//

import UIKit

class GraphSelectionViewController: UIViewController {
    @IBOutlet weak var pushUpButton: UIButton!
    @IBOutlet weak var sitUpButton: UIButton!
    @IBOutlet weak var squatButton: UIButton!
    @IBOutlet weak var runningButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTrainingButton()
    }

    // トレーニンググラフ選択ボタンの設定
    func configureTrainingButton() {
        // ボタンを角丸にする
        pushUpButton.layer.cornerRadius = 5
        sitUpButton.layer.cornerRadius = 5
        squatButton.layer.cornerRadius = 5
        runningButton.layer.cornerRadius = 5
        // ボタンを正方形する
        pushUpButton.heightAnchor.constraint(equalTo: pushUpButton.widthAnchor, multiplier: 1.0).isActive = true
        sitUpButton.heightAnchor.constraint(equalTo: sitUpButton.widthAnchor, multiplier: 1.0).isActive = true
        squatButton.heightAnchor.constraint(equalTo: squatButton.widthAnchor, multiplier: 1.0).isActive = true
        runningButton.heightAnchor.constraint(equalTo: runningButton.widthAnchor, multiplier: 1.0).isActive = true
    }
}
