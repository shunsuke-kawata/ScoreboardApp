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
    
    func registerNewTeam(teamName:String, members:[PlayerInputObject]) ->Bool{
        
        //チームオブジェクトを作成
        let team = Team()
        if realm.objects(Team.self).where({ $0.name == teamName}).first != nil  {
            print("there is already same name team")
            return false
        }else{
            team.name = teamName
        }
        
        for member_dict in members{
            let player = Player()
            player.team_id = team.id

            
            //空欄であれば飛ばす
            if(member_dict.name != ""){
                player.name=member_dict.name
            }else{
                player.name=""
                print("name is blank")
            }
            
            
                //空欄であれば飛ばす
            if(String(member_dict.number) == ""){
                    print("number is invalid")
                    continue
                    
            }else{
                player.number = member_dict.number
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
