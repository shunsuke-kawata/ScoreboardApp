//
//  RegisterTeamController.swift
//  Scoreboard
//
//  Created by 川田　隼輔 on 2023/03/14.
//

//Mainを操作するcontrollerの役割
import UIKit
import Firebase
import FirebaseFirestore
import RealmSwift

class ShowTeamsController:UIViewController{
    //ShowTeamsModelのインスタンスを作成する
    let showInstance = ShowTeamsModel()
    var teams: Results<Team>?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //データベースからのデータ取得（初回以降）
        teams = showInstance.fetchAllTeamsData()
        // データの取得後の処理を実行する
        if let teams = teams {
            for team in teams {
                print(team.name)
                print(team.members.count)
            }
        }
    }

    override func viewDidLoad(){
        super.viewDidLoad()
        //データベースからのデータ取得（初回）
        teams = showInstance.fetchAllTeamsData()
        
        if let teams = teams {
            for team in teams {
                print(team.name)
                print(team.members.count) 
            }
        }
    }
    @IBOutlet weak var titlelabel:UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var newTeamButton: UIButton!
    
    @IBAction func newTeamButtonTapped(_ sender: Any){
        let storyboard = UIStoryboard(name: "RegisterNewTeam", bundle: nil)
        
                let registerNewTeamController = storyboard.instantiateViewController(withIdentifier: "RegisterNewTeamController")
        
                //navigationControllerクラスがない場合はメソッドそのものが呼び出されない
                self.navigationController?.pushViewController(registerNewTeamController, animated: true)
    }
    @IBAction func backButtonTapped(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)
        }
}
