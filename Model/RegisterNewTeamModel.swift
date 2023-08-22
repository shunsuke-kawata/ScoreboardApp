//
//  registerNewTeamModel.swift
//  Scoreboard
//
//  Created by 川田　隼輔 on 2023/03/17.
//

import UIKit
import Foundation
import RealmSwift


class RegisterNewTeamModel{
    
    let realm = try! Realm() //realmデータベースのインスタンスを取得
    
    func registerNewTeam(teamName:String, members:[Dictionary<String,String>]) ->Bool{
        
        //チームオブジェクトを作成
        let team = Team()
        if let result = realm.objects(Team.self).where({ $0.name == teamName}).first  {
            print("there is already same name team")
            return false
        }else{
            team.name = teamName
        }
        
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
            try! realm.write {
                realm.add(team)
            }
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        return true
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
