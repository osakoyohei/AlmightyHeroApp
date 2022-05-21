//
//  GraphViewController.swift
//  AlmightyHeroApp
//  
//  Created by YoheiOsako on 2022/05/14.
//

import UIKit

class GraphViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!

    // セルのラベル名
    let titleLabels: [String] = ["腕立て伏せ","上体起こし","スクワット","ランニング"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // レイアウトを調整
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.collectionViewLayout = layout
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4 // セル数
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        // セルのラベル名を設定
        let title = cell.contentView.viewWithTag(1) as! UILabel
        title.text = titleLabels[indexPath.row]
        // セルの色を設定
        cell.backgroundColor = .gray
        // セルを角丸にする
        cell.layer.cornerRadius = 5
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 横方向のスペース調整
        let horizontalSpace : CGFloat = 20
        // セルのサイズを指定
        let cellSize : CGFloat = self.view.bounds.width / 2 - horizontalSpace
        // セルを正方形にする
        return CGSize(width: cellSize, height: cellSize)
    }
}
