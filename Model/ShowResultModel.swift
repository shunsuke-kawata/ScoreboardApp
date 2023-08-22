//
//  ShowResultModel.swift
//  Scoreboard
//
//  Created by 川田隼輔 on 2023/08/20.
//

import Foundation
import UIKit
import RealmSwift


class ShowResultModel{
    let realm = try! Realm() //realmデータベースのインスタンスを取得
    func fetchResultData(gameId:String)->(flag:Bool,game:Game?,myTeamResult:Team?,yourTeamResult:Team?,myPlayData:[PlayData],yourPlayData:[PlayData]){
        var resultMyTeam:Team? = nil
        var resultYourTeam:Team? = nil
        var resultMyPlayData:[PlayData] = []
        var resultYourPlayData:[PlayData] = []
        
        if let resultGame = realm.objects(Game.self).where({ $0.id == gameId}).first {
            resultMyTeam = realm.objects(Team.self).where({$0.id == resultGame.my_team_id}).first
            resultYourTeam  = realm.objects(Team.self).where({$0.id == resultGame.your_team_id}).first
            print(resultMyTeam,resultYourTeam)
            
            if (resultMyTeam != nil){
                for member in resultMyTeam!.members {
                    if let resultScore = realm.objects(PlayData.self).where({ $0.member_id == member.id && $0.game_id == resultGame.id }).first {
                        resultMyPlayData.append(resultScore)
                    }
                }
            }
            if (resultYourTeam != nil){
                for member in resultYourTeam!.members {
                    if let resultScore = realm.objects(PlayData.self).where({ $0.member_id == member.id && $0.game_id == resultGame.id }).first {
                        resultYourPlayData.append(resultScore)
                    }
                }
            }
            return (true,resultGame,resultMyTeam,resultYourTeam,resultMyPlayData,resultYourPlayData)
        }else{
            return (false,nil,resultMyTeam,resultYourTeam,resultMyPlayData,resultYourPlayData)

        }
    }
    
    func compileShowResultData(playData:[PlayData])->Dictionary<String,Int>{
        var tmp:Dictionary<String,Int>  = ["allScore":0,"allShoot":0,"allAssist":0,"allMiss":0,"allSave":0,"allYellow":0,"allRed":0]
        for datum in playData{
            tmp["allScore"]! += datum.score_count
            tmp["allShoot"]! += datum.shoot_count
            tmp["allAssist"]! += datum.assist_count
            tmp["allMiss"]! += datum.miss_count
            tmp["allSave"]! += datum.save_count
            tmp["allYellow"]! += datum.yellow_count
            tmp["allRed"]! += datum.red_count
        }
        return tmp
    }
    
    func compileDisplsyScoreData(){
        
    }
}
