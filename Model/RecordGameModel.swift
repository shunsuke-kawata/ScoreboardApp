//
//  RecordGameModel.swift
//  Scoreboard
//
//  Created by 川田隼輔 on 2023/08/13.
//

import Foundation
import UIKit
import RealmSwift

class RecordGameModel{
    let realm = try! Realm() //realmデータベースのインスタンスを取得
    func searchTeam(teamId:String)->Team?{
        if let resultTeam = realm.objects(Team.self).where({ $0.id == teamId}).first  {
            print(resultTeam.name)
            return resultTeam
        }else{
            return nil
        }
    }
    
    func registerNewGame(game:Game,myTeamScoreDataArray:[ScoreDataObject],yourTeamScoreDataArray:[ScoreDataObject],myPlayDataObjectArray:Dictionary<String,PlayDataObject>,yourPlayDataObjectArray:Dictionary<String,PlayDataObject>)->(flag:Bool,game:Game){
        
        for myPlayData in myPlayDataObjectArray{
            let playData = PlayData()
            let value = myPlayData.value
            playData.game_id = game.id
            playData.member_id = myPlayData.key
            playData.score_count = value.score_count
            playData.shoot_count = value.shoot_count
            playData.assist_count = value.assist_count
            playData.miss_count = value.miss_count
            playData.save_count = value.save_count
            playData.yellow_count = value.yellow_count
            playData.red_count = value.red_count
            
            try! realm.write {
                realm.add(playData)
            }
        }
        
        for yourPlayData in yourPlayDataObjectArray{
            let playData = PlayData()
            let value = yourPlayData.value
            playData.game_id = game.id
            playData.member_id = yourPlayData.key
            playData.score_count = value.score_count
            playData.shoot_count = value.shoot_count
            playData.assist_count = value.assist_count
            playData.miss_count = value.miss_count
            playData.save_count = value.save_count
            playData.yellow_count = value.yellow_count
            playData.red_count = value.red_count
            
            try! realm.write {
                realm.add(playData)
            }
        }
        
        for myScoreData in myTeamScoreDataArray{
            let scoreData = ScoreData()
            scoreData.member_id = myScoreData.id
            scoreData.game_id = game.id
            scoreData.time = myScoreData.time
            scoreData.half_flag = myScoreData.halfFlag
            
            //条件を満たしたら配列に追加する
            try! realm.write {
                game.score_data.append(scoreData)
            }
        }
        
        for yourScoreData in yourTeamScoreDataArray{
            let scoreData = ScoreData()
            scoreData.member_id = yourScoreData.id
            scoreData.game_id = game.id
            scoreData.time = yourScoreData.time
            scoreData.half_flag = yourScoreData.halfFlag
            
            //条件を満たしたら配列に追加する
            try! realm.write {
                game.score_data.append(scoreData)
            }
        }
        return (true,game)
        
    }
    
    func deleteGame(gameId:String){
        if let resultGame = realm.objects(Game.self).where({ $0.id == gameId}).first {
            try! realm.write {
                realm.delete(resultGame)
            }
        }else{
            print("failed to delete game")
        }
    }
}
