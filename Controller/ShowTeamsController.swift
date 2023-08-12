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

class ShowTeamsController:UIViewController, UITableViewDelegate, UITableViewDataSource  {
    //ShowTeamsModelのインスタンスを作成する
    let showInstance = ShowTeamsModel()
    var teams: Results<Team>!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    @IBOutlet weak var showTeamsTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //データベースからのデータ取得（初回以降）
        teams = showInstance.fetchAllTeamsData()
        
        // データの取得後の処理を実行する
        if let teams = teams {
            print(teams.count)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let teams = teams {
            return teams.count
        }else{
            //配列を返せない時は0を返す
            print("default")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "protoShowTeams", for: indexPath)
        
        let indexlabel = cell.contentView.viewWithTag(1) as!UILabel
        indexlabel.text = String(indexPath.row+1)
        
        let teamNameLabel = cell.contentView.viewWithTag(2) as!UILabel
        let teamCountLabel = cell.contentView.viewWithTag(3) as!UILabel
        
        if let team = teams?[indexPath.row] {
            teamNameLabel.text = team.name
            teamCountLabel.text = String(team.members.count)
        }else{
            //取得できなかった場合のデータ出力
            teamNameLabel.text = "error"
            teamCountLabel.text = String(0)
            
        }
       return cell
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
