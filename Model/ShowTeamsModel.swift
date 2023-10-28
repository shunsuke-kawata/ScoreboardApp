//
//  ShowTeamsModel.swift
//  Scoreboard
//
//  Created by 川田　隼輔 on 2023/03/17.
//

import UIKit
import Foundation
import RealmSwift

class ShowTeamsModel{
    
    let realm = try! Realm() //realmデータベースのインスタンスを取得
    
     func fetchAllTeams()-> Results<Team>{
        // RegisterNewTeamModelのクラスを使用
        let teams = realm.objects(Team.self)
        return teams
    }
    
//    struct fetchedData {
//        var name:String
//        var members: NSArray
//    }
//
//    func fetchAllTeamsData()->[Dictionary<String,Any>]{
//        let db = Firestore.firestore()
//        //teamsコレクションを取得する
//        let documentRef = db.collection("teams")
//        var allFetchedData:[Dictionary<String,Any>] = []
//        //documentRefからsnapshotでデータを取得する
//        documentRef.getDocuments(){ (querySnapshot, error) in
//            if let error = error {
//                print("Error getting documents: \(error)")
//            } else {
//                for document in querySnapshot!.documents {
//                    //ドキュメントから取得してきたデータ
//                    let documentData = document.data()
//                    print(documentData)
//                    allFetchedData.append(documentData)
//                }
//            }
//        }
//        return allFetchedData
//    }
    
//    func createDisplayTeamData(allFetchedData:[Dictionary<String,Any>]){
//        for data in allFetchedData{
//            print(data)
//        }
//    }
//
    
}
