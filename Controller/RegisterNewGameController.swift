//
//  RegisterNewGameController.swift
//  Scoreboard
//
//  Created by 川田隼輔 on 2023/07/08.
//

import Foundation
import UIKit
import RealmSwift

enum weatherType: CaseIterable {
    case sunny
    case cloudy
    case rainy

    var title: String {
        switch self {
        case .sunny:
            return "晴れ"
        case .cloudy:
            return "くもり"
        case .rainy:
            return "雨"
        }
    }
}

class RegisterNewGameController:UIViewController{
    let weather:Dictionary<String,String> = ["晴れ":"sunny","くもり":"cloudy","雨":"rainy"]
    var teamsArray:[String] = []
    
    let showInstance = ShowTeamsModel()
    var teams: Results<Team>!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var gameNameField: UITextField!
    @IBOutlet weak var placeNameField: UITextField!
    
    @IBOutlet weak var wetherSelectButton: UIButton!
    
    @IBOutlet weak var myTeamSelectButton: UIButton!
    
    @IBOutlet weak var yourTeamSelectButton: UIButton!
    
    //天気の初期値
    private var selectedWeather = weatherType.sunny
    private var selectedMyteam:String?
    private var selectedYourteam:String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //データベースからのデータ取得（初回以降）
        teams = showInstance.fetchAllTeamsData()
        
        // データの取得後の処理を実行する
        if let teams = teams {
            teamsArray=[]
            for team in teams {
                teamsArray.append(team.name)
            }
            
            if (teamsArray.count != 0){
                selectedMyteam = teamsArray[0]
                selectedYourteam = teamsArray[0]
            }else{
                selectedMyteam = "--"
                selectedYourteam = "--"
            }
        }
        
        //それぞれのボタンのメニューを設定する
        configureWeatherMenu()
        configureMyTeamMenu(teamsArray: teamsArray)
        configureYourTeamMenu(teamsArray: teamsArray)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        teams = showInstance.fetchAllTeamsData()
        
        //それぞれのボタンのメニューを設定する
        configureWeatherMenu()
        configureMyTeamMenu(teamsArray:teamsArray)
        configureYourTeamMenu(teamsArray: teamsArray)
        
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureWeatherMenu(){
        let actions = weatherType.allCases
            .compactMap { i in
                UIAction(
                    title:i.title,
                    state:i == selectedWeather ? .on : .off,
                    handler: { _ in
                        self.selectedWeather = i
                        self.configureWeatherMenu()
                    }
                )
            }
        wetherSelectButton.menu = UIMenu(title: "", options: .displayInline, children: actions)
        wetherSelectButton.showsMenuAsPrimaryAction = true
        wetherSelectButton.setTitle(selectedWeather.title, for: .normal)
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
}
