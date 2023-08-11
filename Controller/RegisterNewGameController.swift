//
//  RegisterNewGameController.swift
//  Scoreboard
//
//  Created by 川田隼輔 on 2023/07/08.
//

import Foundation
import UIKit
import RealmSwift

let weather:Dictionary<String,String> = ["晴れ":"sunny","くもり":"cloudy","雨":"rainy"]

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
    
    let showInstance = ShowTeamsModel()
    
    
    
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var gameNameField: UITextField!
    @IBOutlet weak var placeNameField: UITextField!
    
    @IBOutlet weak var wetherSelectButton: UIButton!
    
    @IBOutlet weak var myTeamSelectButton: UIButton!
    
    @IBOutlet weak var yourTeamSelectButton: UIButton!
    
    //天気の初期値
    private var selectedWeather = weatherType.sunny

    override func viewDidLoad() {
        super.viewDidLoad()
        configureWeatherMenu()
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureWeatherMenu(){
        let actions = weatherType.allCases
            .compactMap { type in
                UIAction(
                    title:type.title,
                    state:type == selectedWeather ? .on : .off,
                    handler: { _ in
                        self.selectedWeather = type
                        self.configureWeatherMenu()
                    }
                )
            }
        wetherSelectButton.menu = UIMenu(title: "", options: .displayInline, children: actions)
        wetherSelectButton.showsMenuAsPrimaryAction = true
        wetherSelectButton.setTitle(selectedWeather.title, for: .normal)
    }
}
