//
//  RecordGameModel.swift
//  Scoreboard
//
//  Created by 川田隼輔 on 2023/08/13.
//

import Foundation
import UIKit
import RealmSwift

class RecordGameModel{
    let realm = try! Realm() //realmデータベースのインスタンスを取得
    func searchTeam(teamId:String)->Team?{
        let teamTable = realm.objects(Team.self)
        if let resultTeam = teamTable.where({ $0.id == teamId}).first  {
            return resultTeam
        }else{
            return nil
        }
    }
}
