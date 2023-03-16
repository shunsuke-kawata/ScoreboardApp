//
//  RegisterNewTeamController.swift
//  Scoreboard
//
//  Created by 川田　隼輔 on 2023/03/15.
//
import UIKit

class RegisterNewTeamController:UIViewController, UITableViewDelegate, UITableViewDataSource  {

    //最大で26人分の選手データを登録する配列
    var registerTeamData:[[String]] = [
        ["",""],["",""],
        ["",""],["",""],
        ["",""],["",""],
        ["",""],["",""],
        ["",""],["",""],
        ["",""],["",""],
        ["",""],["",""],
        ["",""],["",""],
        ["",""],["",""],
        ["",""],["",""],
        ["",""],["",""],
        ["",""],["",""],
        ["",""],["",""]
    ]

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var registerSubmitButton: UIButton!
    
    @IBOutlet weak var teamNameField: UITextField!
    @IBOutlet weak var registerFormTableView: UITableView!
    
    let registerInstance = registerNewTeamModel()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 26;
        }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "proto", for: indexPath)

        let indexlabel = cell.contentView.viewWithTag(1) as!UILabel
        indexlabel.text = String(indexPath.row+1)
        
        let numberField = cell.contentView.viewWithTag(2) as!UITextField
        numberField.text = registerTeamData[indexPath.row][0]

        let nameField = cell.contentView.viewWithTag(3) as! UITextField
        nameField.text = registerTeamData[indexPath.row][1]
        
         return cell
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        }
    
    //戻るボタンをタップしたとき
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //登録ボタンをタップしたとき
    @IBAction func registerSubmitButtonTapped(_ sender: UIButton) {
        print(teamNameField.text!)
        print(registerTeamData)
        registerInstance.registerNewTeam(teamName:teamNameField.text!,members:registerTeamData)
        print("clicked")
    }
    //TableViewからformで送信して登録する値を取得してくる
    
    //配列の内容を更新する関数
    func updateRegisterTeamData(index:Int,value:String,option:Int){
        registerTeamData[index-1][option] = value
        print(registerTeamData)
        return
    }
    //Playerの背番号を更新する関数
    @IBAction func changePlayerNumber(_ sender: UITextField) {
        let changedNumber = String(sender.text!)
        if let changedSuperview  = sender.superview{
            let index = changedSuperview.viewWithTag(1) as!UILabel
            if let indexInt = Int(index.text!) {
                updateRegisterTeamData(index: indexInt, value: changedNumber, option: 0)
            } else {
                print("数値ではありません。")
                return
            }
        }else{
            return
        }
    }
    
    //playerの名前を更新する関数
    @IBAction func changePlayerName(_ sender: UITextField) {
        let changedName = String(sender.text!)
        if let changedSuperview  = sender.superview{
            let index = changedSuperview.viewWithTag(1) as!UILabel
            if let indexInt = Int(index.text!) {
                updateRegisterTeamData(index: indexInt, value: changedName, option: 1)
            } else {
                print("数値ではありません。")
                return
            }
        }else{
            return
        }
    }
}
