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
class  Player: Object ,ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id:UUID = UUID()  //uuid
    @Persisted var name:String  //名前
    @Persisted var number:Int  //背番号
    @Persisted var team_id:UUID //選手が所属するチームのid
    @Persisted var position:String //その選手のポジション
    @Persisted var created_at:Date = Date()  //作成日
    @Persisted var updated_at:Date = Date()  //更新日
}

//チームを定義する構造体
class Team:Object,ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id:UUID = UUID()  //uuid
    @Persisted var name:String  //チームの名前
    @Persisted  var members:List = RealmSwift.List<Player>() //メンバー全員のリスト
    @Persisted var created_at:Date = Date()  //作成日
    @Persisted var updated_at:Date = Date() // 更新日
}

//ゲームを定義する構造体

class Game:Object,ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id:UUID = UUID()  //uuid
    @Persisted var title:String  //チームの名前
    @Persisted var place:String   //試合が行われた場所
    @Persisted var weather:String //その日の天気
    @Persisted var my_team_id:UUID //自分のチームのid
    @Persisted var your_team_id:UUID? //相手のチームのid
    @Persisted var regulation_time:Int //試合時間
    @Persisted var created_at:Date = Date() //作成日
    @Persisted var updated_at:Date = Date() //更新日
}
