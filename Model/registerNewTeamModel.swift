//
//  registerNewTeamModel.swift
//  Scoreboard
//
//  Created by 川田　隼輔 on 2023/03/17.
//

import UIKit
import FirebaseFirestore

class registerNewTeamModel{
    
    func registerNewTeam(teamName:String, members:[Dictionary<String,String>]) {
        

        let db = Firestore.firestore()
        let documentRef = db.collection("teams").document()
        
        let teamInfomationToRegister = ["teamName": teamName, "members": members] as [String: Any]

        documentRef.setData(teamInfomationToRegister) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added with ID: \(documentRef.documentID)")
            }
        }
        
    }
}
