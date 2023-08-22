//
//  RegisterNewGameModel.swift
//  Scoreboard
//
//  Created by 川田隼輔 on 2023/08/11.
//

import Foundation
import UIKit
import RealmSwift

class RegisterNewGameModel{
    let weatherArray:Dictionary<String,String> = ["晴れ":"sunny","くもり":"cloudy","雨":"rainy","雪":"snowy"]
    let realm = try! Realm() //realmデータベースのインスタンスを取得
    
    func registerNewGame(gameTitle:String?, placeName:String?, weatherValue:Int, regulationTimeValue:Int,myTeamName:String,yourTeamName:String)->(flag:Bool,game:Game?){
        let game = Game()
        if let result = realm.objects(Game.self).where({ $0.title == gameTitle!}).first  {
            print(result.title)
            print("there is already same name team")
            return (false , nil)
        }else{
            game.title = gameTitle!
        }
        
        game.place = placeName!
        game.weather = weatherValue
        
        game.regulation_time = regulationTimeValue
        
        if let resultMyteam = realm.objects(Team.self).where({ $0.name == myTeamName}).first  {
            game.my_team_id = resultMyteam.id
        }else{
            return (false,nil)
        }
        
        if let resultYourteam = realm.objects(Team.self).where({ $0.name == yourTeamName}).first  {
            game.your_team_id = resultYourteam.id
        }else{
            return (false,nil)
        }
        //ゲームのレコードをデータベースに追加する
        try! realm.write {
            realm.add(game)
        }
        
        return (true,game)

    }
    
}
