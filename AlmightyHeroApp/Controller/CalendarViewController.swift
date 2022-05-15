//
//  CalendarViewController.swift
//  AlmightyHeroApp
//  
//  Created by YoheiOsako on 2022/05/14.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {
    @IBOutlet weak var calendarView: FSCalendar!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCalendar()
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
}
