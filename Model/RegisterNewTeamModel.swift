//
//  registerNewTeamModel.swift
//  Scoreboard
//
//  Created by 川田　隼輔 on 2023/03/17.
//

import UIKit
import FirebaseFirestore

class RegisterNewTeamModel{
    
    //userDefaultsのインスタンス
    var userDefault = UserDefaults.standard

    func registerNewTeam(teamName:String, members:[Dictionary<String,String>]) {
        
        //Any型の配列を作成する
        let registerData:Dictionary<String,[Dictionary<String,String>]> = [teamName:members]
        print("resisterData")
        print(registerData)
        userDefault.set([registerData], forKey: "teams")
        let teams = UserDefaults.standard.object(forKey: "teams")
        print(teams)
        
    }
}

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
