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
    
    //作成に関して背番号・名前ともに空文字を許容しない
    
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
                print("name is blank")
                continue
            }
                //空欄であれば飛ばす
            if(member_dict.number == -1){
                    print("number is invalid")
                    continue
                    
            }else if let unwrappedMemberDictNumber = member_dict.number{
                player.number = unwrappedMemberDictNumber
            }else{
                print("cannnot unwrap member dict number")
            }
            player.position = member_dict.position
            //条件を満たしたら配列に追加する
            try! realm.write {
                team.members.append(player)
            }
        }
        
        if(team.members.count>0){
            try! realm.write {
                realm.add(team)
            }
        }else{
            print("team has no members")
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
