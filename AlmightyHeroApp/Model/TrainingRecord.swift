//
//  TrainingRecord.swift
//  AlmightyHeroApp
//  
//  Created by YoheiOsako on 2022/05/15.
//

import Foundation
import RealmSwift

class TrainingRecord: Object {
    override static func primaryKey() -> String? {
        return "id"
    }
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var date: Date = Date()
    @objc dynamic var pushUp: Int = 0
    @objc dynamic var sitUp: Int = 0
    @objc dynamic var squat: Int = 0
    @objc dynamic var running: Double = 0
}
