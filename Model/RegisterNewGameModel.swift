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
    
    func registerNewGame(gameTitle:String?, placeName:String?, weatherValue:String, regulationTimeValue:Int,myTeamName:String,yourTeamName:String){
        let game = Game()
        let gameTable = realm.objects(Game.self)
        if let result = gameTable.where({ $0.title == gameTitle!}).first  {
            print(result.title)
            print("there is already same name team")
            return
        }else{
            game.title = gameTitle!
        }
        
        game.place = placeName!
        if let japaneseWeather = weatherArray[weatherValue] {
               game.weather = japaneseWeather
        } else {
            // weatherValue に対応する日本語表現が見つからなかった場合の処理
            print("Unknown weather: \(weatherValue)")
            return
        }
        
        game.regulation_time = regulationTimeValue
        
        let teamTable = realm.objects(Team.self)
        if let resultMyteam = teamTable.where({ $0.name == myTeamName}).first  {
            game.my_team_id = resultMyteam.id
        }else{
            return
        }
        
        if let resultYourteam = teamTable.where({ $0.name == yourTeamName}).first  {
            game.your_team_id = resultYourteam.id
        }else{
            game.your_team_id = nil
        }
        
        //ゲームのレコードをデータベースに追加する
        try! realm.write {
            realm.add(game)
        }

    }
    
}
