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
    @Persisted var weather:String //その日の天気
    @Persisted var my_team_id:String //自分のチームのid
    @Persisted var your_team_id:String//相手のチームのid
    @Persisted var regulation_time:Int //試合時間
    
    @Persisted var created_at:Date = Date() //作成日
    @Persisted var updated_at:Date = Date() //更新日
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
