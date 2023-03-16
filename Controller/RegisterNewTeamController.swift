//
//  RegisterNewTeamController.swift
//  Scoreboard
//
//  Created by 川田　隼輔 on 2023/03/15.
//
import UIKit
import Eureka

class RegisterNewTeamController:UIViewController, UITableViewDelegate, UITableViewDataSource  {

    //最大で26人分の選手データを登録する配列
    var regiserTeamData = [
        ["1",""],["2",""],["3",""],["4",""],["5",""],["6",""],["7",""],["8",""],
        ["9",""],["10",""],["11",""],["12",""],["13",""],["14",""],["15",""],["16",""],
        ["17",""],["18",""],["19",""],["20",""],["21",""],["22",""],["23",""],["24",""],
        ["25",""],["26",""]
    ]
    let selectNumber: [Int] = Array(1...99)
    
    @IBOutlet weak var backButton: UIButton!
    //tableViewの作成
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 26;
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         // セルを取得する
         let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "proto", for: indexPath)

         // TableViewCellの中に配置したLabelを取得する
         let numberField = cell.contentView.viewWithTag(1) as!UITextField
         let nameField = cell.contentView.viewWithTag(2) as! UITextField

         // Labelにテキストを設定する
         numberField.text = regiserTeamData[indexPath.row][0]
         nameField.text = regiserTeamData[indexPath.row][1]

         return cell
     }
    override func viewDidLoad() {
        super.viewDidLoad()
        }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


