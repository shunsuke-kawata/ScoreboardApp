//
//  registerNewTeamModel.swift
//  Scoreboard
//
//  Created by 川田　隼輔 on 2023/03/17.
//

import UIKit
import Foundation
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


class RegisterNewTeamModel{
    
    let realm = try! Realm() //realmデータベースのインスタンスを取得
    
    func registerNewTeam(teamName:String, members:[Dictionary<String,String>]) {
        
        print("resisterData")
        //チームオブジェクトを作成
        let team = Team()
        team.name = teamName
                
        for member_dict in members{
            let player = Player()
            player.team_id = team.id

            if let memberName = member_dict["name"]{
                //空欄であれば飛ばす
                if(memberName != ""){
                    player.name=memberName
                }else{
                    player.name=""
                    print("name is blank")
                }
            }
            if let memberNumber = member_dict["number"]{
                
                print(type(of: memberNumber))
                //空欄であれば飛ばす
                if(memberNumber == ""){
                    print(memberNumber)
                    print("number is invalid")
                    continue
                    
                }else{
                    if let memberNumberInt = Int(memberNumber){
                        player.number = memberNumberInt
                    }
                }
            }
            
            //条件を満たしたら配列に追加する
            try! realm.write {
                team.members.append(player)
            }
        }
        
        //チームのレコードをデータベースに追加する
        try! realm.write {
            realm.add(team)
        }
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
    }
}

//firebaseへのデータpush
//let db = Firestore.firestore()
//let documentRef = db.collection("teams").document()
//
//let teamInfomationToRegister = ["teamName": teamName, "members": members] as [String: Any]
//
//documentRef.setData(teamInfomationToRegister) { error in
//    if let error = error {
//        print("Error adding document: \(error)")
//    } else {
//        print("Document added with ID: \(documentRef.documentID)")
//    }
//}
