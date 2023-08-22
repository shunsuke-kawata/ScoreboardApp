//
//  RegisterNewGameController.swift
//  Scoreboard
//
//  Created by 川田隼輔 on 2023/07/08.
//

import Foundation
import UIKit
import RealmSwift

let weatherTaple:[(flag:Int,value:String)] = [(1,"晴れ"),(2,"くもり"),(3,"雨"),(4,"雪")]
let regulationTimeArray :[Int] = [15,20,25,30,35,40,45,50]

class RegisterNewGameController:UIViewController{
    
    var teamsArray:[String] = []
    
    let showTeamsInstance = ShowTeamsModel()
    let registerNewGameInstance = RegisterNewGameModel()
    
    var teams: Results<Team>!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var gameNameField: UITextField!
    @IBOutlet weak var placeNameField: UITextField!
    
    @IBOutlet weak var wetherSelectButton: UIButton!
    
    
    @IBOutlet weak var regulationTimeSelectButton: UIButton!
    
    @IBOutlet weak var myTeamSelectButton: UIButton!
    
    @IBOutlet weak var yourTeamSelectButton: UIButton!
    
    @IBOutlet weak var registerSubmitButton: UIButton!
    //天気の初期値
    private var selectedWeather = weatherTaple[0]
    private var selectedRegulationTime = regulationTimeArray[2]
    private var selectedMyteam = "--"
    private var selectedYourteam = "--"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //それぞれのボタンのメニューを設定する
        self.configureWeatherMenu()
        self.configureRegulationTimeMenu()
        
        //データベースからのデータ取得（初回以降）
        teams = showTeamsInstance.fetchAllTeams()
        
        // データの取得後の処理を実行する
        if let _teams = teams {
            teamsArray=[]
            for team in _teams {
                teamsArray.append(team.name)
            }
            
            if (teamsArray.count != 0){
                selectedMyteam = teamsArray[0]
                selectedYourteam = teamsArray[0]
            }
        }
        
        //チームのリストからメニューを設定する
        self.configureMyTeamMenu(teamsArray: teamsArray)
        self.configureYourTeamMenu(teamsArray: teamsArray)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //それぞれのボタンのメニューを設定する
        self.configureWeatherMenu()
        self.configureRegulationTimeMenu()
        
        teams = showTeamsInstance.fetchAllTeams()
        
        //チームのリストからメニューを設定する
        self.configureMyTeamMenu(teamsArray:teamsArray)
        self.configureYourTeamMenu(teamsArray: teamsArray)
        
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerSubmitButtonTapped(_ sender: Any) {
        if (!varidateRegisterData()){
            return
        }else{
            print("No validation errors")
        }
        let result = registerNewGameInstance.registerNewGame(gameTitle: gameNameField.text, placeName: placeNameField.text, weatherValue: selectedWeather.flag, regulationTimeValue: selectedRegulationTime,myTeamName: selectedMyteam, yourTeamName: selectedYourteam)
        if (result.flag){
            let storyboard = UIStoryboard(name: "RecordGame", bundle: nil)
            //navigationControllerクラスがない場合はメソッドそのものが呼び出されない
            
            let recordGameController = storyboard.instantiateViewController(withIdentifier: "RecordPageViewController") as! RecordPageViewController
            registeredGame = result.game
            self.navigationController?.pushViewController(recordGameController, animated: true)
        }else{
            print("failed to register game")
            return
        }
        
    }
    
    private func configureWeatherMenu(){
        let actions = weatherTaple
            .compactMap { i in
                UIAction(
                    title:i.value,
                    state:i == selectedWeather ? .on : .off,
                    handler: { _ in
                        self.selectedWeather = i
                        self.configureWeatherMenu()
                    }
                )
            }
        wetherSelectButton.menu = UIMenu(title: "", options: .displayInline, children: actions)
        wetherSelectButton.showsMenuAsPrimaryAction = true
        wetherSelectButton.setTitle(selectedWeather.value, for: .normal)
    }
    
    private func configureRegulationTimeMenu(){
        let actions = regulationTimeArray
            .compactMap{ i in
                UIAction(
                    title:String(i),
                    state:i == selectedRegulationTime ? .on : .off,
                    handler: {  _ in
                        self.selectedRegulationTime = i
                        self.configureRegulationTimeMenu()
                    }
                )
            }
        regulationTimeSelectButton.menu = UIMenu(title: "", options: .displayInline, children: actions)
        regulationTimeSelectButton.showsMenuAsPrimaryAction = true
        regulationTimeSelectButton.setTitle(String(selectedRegulationTime), for: .normal)
    }
    private func configureMyTeamMenu(teamsArray:[String]){
        let actions = teamsArray.compactMap{ i in
                UIAction(
                    title:i,
                    state:i == selectedMyteam ? .on : .off,
                    handler: { _ in
                        self.selectedMyteam = i
                        self.configureMyTeamMenu(teamsArray:teamsArray)
                    }
                )
        }
        myTeamSelectButton.menu = UIMenu(title: "", options: .displayInline, children: actions)
        myTeamSelectButton.showsMenuAsPrimaryAction = true
        myTeamSelectButton.setTitle(selectedMyteam, for: .normal)
    }
    
    private func configureYourTeamMenu(teamsArray:[String]){
        let actions = teamsArray.compactMap{ i in
                UIAction(
                    title:i,
                    state:i == selectedYourteam ? .on : .off,
                    handler: { _ in
                        self.selectedYourteam = i
                        self.configureYourTeamMenu(teamsArray:teamsArray)
                    }
                )
        }
        yourTeamSelectButton.menu = UIMenu(title: "", options: .displayInline, children: actions)
        yourTeamSelectButton.showsMenuAsPrimaryAction = true
        yourTeamSelectButton.setTitle(selectedYourteam, for: .normal)
    }
    
    func varidateRegisterData()->Bool{
        if (gameNameField.text! == ""){
            print("gamename is blank")
            return false
        }else if (selectedMyteam == "--" || selectedYourteam == "--"){
            print("teamname is blank")
            return false
        }else{
            return true
        }
    }
}
