//
//  ViewController.swift
//  Scoreboard
//
//  Created by 川田　隼輔 on 2022/11/17.
//


//Mainを操作するcontrollerの役割
import UIKit
import RealmSwift
import Foundation

class ViewController: UIViewController {
    
    let fileManager = FileManager.default

    @IBOutlet weak var toRecordButton: UIButton!
    
    @IBOutlet weak var toShowTeamsButton: UIButton!
    
    @IBOutlet weak var dataResetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.isHidden = true
        guard let fileURL = Realm.Configuration.defaultConfiguration.fileURL else {
            print("failed to get realm url")
            return
        }
        print(fileURL)
    }
    
    @IBAction func transitionToShowTeams(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ShowTeams", bundle: nil)
        
        let registerTeamController = storyboard.instantiateViewController(withIdentifier: "ShowTeamsController")
        
        //navigationControllerクラスがない場合はメソッドそのものが呼び出されない
        self.navigationController?.pushViewController(registerTeamController, animated: true)
        
    }
    
    @IBAction func transitionToRegisterNewGame(_ sender: Any) {
        let storyboard = UIStoryboard(name: "RegisterNewGame", bundle: nil)
        
                let registerTeamController = storyboard.instantiateViewController(withIdentifier: "RegisterNewGameController")
        
                //navigationControllerクラスがない場合はメソッドそのものが呼び出されない
                self.navigationController?.pushViewController(registerTeamController, animated: true)
    }
    
    @IBAction func deleteDatabase(_ sender: Any) {
        if let fileURL = Realm.Configuration.defaultConfiguration.fileURL {
            do {
                try fileManager.removeItem(at: fileURL)
                print("データベースファイルの削除に成功しました")
            } catch {
                print("データベースファイルの削除に失敗しました: \(error)")
            }
        }
    }
    
}

