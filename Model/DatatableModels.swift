//
//  DatatableModels.swift
//  Scoreboard
//
//  Created by 川田隼輔 on 2023/08/11.
//

import Foundation
import UIKit
import RealmSwift

//メンバーを定義する構造体
class Player: Object ,ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id:String = UUID() .uuidString //uuid
    @Persisted var name:String  //名前
    @Persisted var number:Int  //背番号
    @Persisted var team_id:String //選手が所属するチームのid
    @Persisted var position:String //その選手のポジション
    
    @Persisted var created_at:Date = Date()  //作成日
    @Persisted var updated_at:Date = Date()  //更新日
}

//チームを定義する構造体
class Team:Object,ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id:String = UUID().uuidString  //uuid
    @Persisted var name:String  //チームの名前
    @Persisted  var members:List = RealmSwift.List<Player>() //メンバー全員のリスト
    
    @Persisted var created_at:Date = Date()  //作成日
    @Persisted var updated_at:Date = Date() // 更新日
}

//ゲームを定義する構造体

class Game:Object,ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id:String = UUID().uuidString  //uuid
    @Persisted var title:String  //チームの名前
    @Persisted var place:String   //試合が行われた場所
    @Persisted var weather:Int//その日の天気
    @Persisted var my_team_id:String //自分のチームのid
    @Persisted var your_team_id:String//相手のチームのid
    @Persisted var regulation_time:Int //試合時間
    @Persisted var score_data:List = RealmSwift.List<ScoreData>()
    
    @Persisted var created_at:Date = Date() //作成日
    @Persisted var updated_at:Date = Date() //更新日
}

class ScoreData:Object,ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id:String = UUID().uuidString  //uuid
    @Persisted var member_id:String
    @Persisted var game_id:String
    @Persisted var time:Double
    @Persisted var half_flag:Int
}

class PlayData:Object,ObjectKeyIdentifiable{
    @Persisted var game_id:String //データを記録するゲームのid(複合uuid)
    @Persisted var member_id:String //データを記録するメンバーのid(複合uuid)
    @Persisted var score_count:Int = 0 //得点数
    @Persisted var shoot_count:Int = 0 //シュート数
    @Persisted var assist_count:Int = 0 //アシスト数
    @Persisted var miss_count:Int = 0 //パスミス数
    @Persisted var save_count:Int = 0 //セーブ数
    @Persisted var yellow_count:Int = 0 //イエローカード数
    @Persisted var red_count:Int = 0 //レッドカード数
    
    @Persisted var created_at:Date = Date() //作成日
    @Persisted var updated_at:Date = Date() //更新日
    
}

//得点の時刻と選手を記録するオブジェクト
class ScoreDataObject{
    let id:String
    let time:Double
    let halfFlag:Int
    
    init(id: String, time: Double, halfFlag: Int) {
        self.id = id
        self.time = time
        self.halfFlag = halfFlag
    }
}

//プレイデータを選手ごとに記録するオブジェクト
class PlayDataObject {
    let id: String
    let number: Int
    let name: String
    var score_count: Int
    var shoot_count: Int
    var assist_count: Int
    var miss_count: Int
    var save_count: Int
    var yellow_count: Int
    var red_count: Int
    
    init(id: String, number: Int, name: String) {
        self.id = id
        self.number = number
        self.name = name
        self.score_count = 0
        self.shoot_count = 0
        self.assist_count = 0
        self.miss_count = 0
        self.save_count = 0
        self.yellow_count = 0
        self.red_count = 0
    }
    
    func increaseScore() {
        self.score_count += 1
    }
    
    func decreaseScore() {
        if self.score_count > 0 {
            self.score_count -= 1
        }
    }
    
    func increaseShoot() {
        self.shoot_count += 1
    }
    
    func decreaseShoot() {
        if self.shoot_count > 0 {
            self.shoot_count -= 1
        }
    }
    
    func increaseAssist() {
        self.assist_count += 1
    }
    
    func decreaseAssist() {
        if self.assist_count > 0 {
            self.assist_count -= 1
        }
    }
    
    func increaseMiss() {
        self.miss_count += 1
    }
    
    func decreaseMiss() {
         if self.miss_count > 0 {
             self.miss_count -= 1
         }
     }
    
    func increaseSave() {
        self.save_count += 1
    }
    
    func decreaseSave() {
        if self.save_count > 0 {
            self.save_count -= 1
        }
    }
    
    func increaseYellow() {
        if self.yellow_count < 2{
            self.yellow_count += 1
        }
        
        if self.yellow_count == 2 {
            self.red_count = 1
        }
    }
    
    func decreaseYellow() {
        if self.yellow_count > 0 {
            self.yellow_count -= 1
        }
    }
    
    func increaseRed() {
        if self.red_count == 0{
            self.red_count = 1
        }
        
    }
    
    func decreaseRed() {
        if self.red_count == 1 {
            self.red_count = 0
        }
    }
}

