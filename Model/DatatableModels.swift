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
class  Player: Object {
    @Persisted(primaryKey: true) var id:UUID = UUID()  //uuid
    @Persisted var name:String  //名前
    @Persisted var number:Int  //背番号
    @Persisted var team_id:UUID
    @Persisted var position:String
    @Persisted var created_at:Date = Date()  //作成日
    @Persisted var updated_at:Date = Date()  //作成日
}

//チームを定義する構造体
class Team:Object,ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id:UUID = UUID()  //uuid
    @Persisted var name:String  //チームの名前
    @Persisted  var members:List = RealmSwift.List<Player>() //メンバー全員のリスト
    @Persisted var created_at:Date = Date()  //作成日
    @Persisted var updated_at:Date = Date()
}
