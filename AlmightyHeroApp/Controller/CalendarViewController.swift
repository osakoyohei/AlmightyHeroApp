//
//  CalendarViewController.swift
//  AlmightyHeroApp
//  
//  Created by YoheiOsako on 2022/05/14.
//

import UIKit
import FSCalendar
import RealmSwift

class CalendarViewController: UIViewController {
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var addButton: UIButton!
    @IBAction func addButton(_ sender: UIButton) {
        transitionToEditorView()
    }

    var recordList: [TrainingRecord] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCalendar()
        configureButton()
        calendarView.dataSource = self
        calendarView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRecord()
        calendarView.reloadData()
    }

    func configureCalendar() {
        // スクロールを上下に変更
        calendarView.scrollDirection = .vertical
        // ヘッダーの日付フォーマットを変更
        calendarView.appearance.headerDateFormat = "yyyy年MM月"
        // 曜日と今日の色を指定
        calendarView.appearance.todayColor = .red
        calendarView.appearance.headerTitleColor = .red
        calendarView.appearance.weekdayTextColor = .black
        // 曜日の表示内容を変更
        calendarView.calendarWeekdayView.weekdayLabels[0].text = "日"
        calendarView.calendarWeekdayView.weekdayLabels[1].text = "月"
        calendarView.calendarWeekdayView.weekdayLabels[2].text = "火"
        calendarView.calendarWeekdayView.weekdayLabels[3].text = "水"
        calendarView.calendarWeekdayView.weekdayLabels[4].text = "木"
        calendarView.calendarWeekdayView.weekdayLabels[5].text = "金"
        calendarView.calendarWeekdayView.weekdayLabels[6].text = "土"
        // 土日の色を変更
        calendarView.calendarWeekdayView.weekdayLabels[0].textColor = .red
        calendarView.calendarWeekdayView.weekdayLabels[6].textColor = .blue
    }

    func configureButton() {
        // ボタンを角丸にする
        addButton.layer.cornerRadius = addButton.bounds.width / 2
    }

    // トレーニング入力画面に遷移
    func transitionToEditorView(with record: TrainingRecord? = nil) {
        let storyboard = UIStoryboard(name: "EditorViewController", bundle: nil)
        guard let editorViewController =
                storyboard.instantiateInitialViewController() as?
                EditorViewController else { return }
        if let record = record {
            editorViewController.record = record
        }
        editorViewController.delegate = self
        present(editorViewController, animated: true)
    }

    func getRecord() {
        let realm = try! Realm()
        recordList = Array(realm.objects(TrainingRecord.self))
    }
}

extension CalendarViewController: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateList = recordList.map({ $0.date.zeroclock })
        let isEqualDate = dateList.contains(date.zeroclock)
        return isEqualDate ? 1 : 0
    }
}

extension CalendarViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        calendar.deselect(date)
        guard let record = recordList.first(where: { $0.date.zeroclock == date.zeroclock }) else { return }
        transitionToEditorView(with: record)
    }
}

extension CalendarViewController: EditorViewControllerDelegate {
    func recordUpdate() {
        getRecord()
        calendarView.reloadData()
    }
}
