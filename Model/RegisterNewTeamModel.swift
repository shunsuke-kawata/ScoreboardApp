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
class Member: Object {
    @Persisted(primaryKey: true) var id:UUID = UUID()  //uuid
    @Persisted var name:String  //名前
    @Persisted var number:Int  //背番号
    @Persisted var createdAt = Date()  //作成日
}

//チームを定義する構造体
class Team:Object,ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id:UUID = UUID()  //uuid
    @Persisted var name:String  //チームの名前
    @Persisted  var members = RealmSwift.List<Member>() //メンバー全員のリスト
    @Persisted var createdAt = Date()  //作成日
}


class RegisterNewTeamModel{
    
    let realm = try! Realm() //realmデータベースのインスタンスを取得
    
    func registerNewTeam(teamName:String, members:[Dictionary<String,String>]) {
        
        print("resisterData")
        //チームオブジェクトを作成
        let team = Team()
        team.name = teamName
                
        for member_dict in members{
            let member = Member()

            if let memberName = member_dict["name"]{
                //空欄であれば飛ばす
                if(memberName != ""){
                    member.name=memberName
                }else{
                    print("name is invalid")
                    continue
                }
            }
            if let memberNumber = member_dict["number"]{
                //空欄であれば飛ばす
                if(memberNumber != ""){
                    if let memberNumberInt = Int(memberNumber){
                        member.number = memberNumberInt
                    }else{
                        print("number is invalid")
                        continue
                    }
                }
            }
            
            //条件を満たしたら配列に追加する
            try! realm.write {
                team.members.append(member)
            }
        }
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
