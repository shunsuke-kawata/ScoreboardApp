//
//  RegisterNewTeamController.swift
//  Scoreboard
//
//  Created by 川田　隼輔 on 2023/03/15.
//
import UIKit

class RegisterNewTeamController:UIViewController, UITableViewDelegate, UITableViewDataSource  {

    //最大で26人分の選手データを登録する配列
    //dict型の配列に変更予定
    var registerTeamData:[Dictionary<String,String>] = [
        ["number":"1","name":""],
        ["number":"2","name":""],
        ["number":"3","name":""],
        ["number":"4","name":""],
        ["number":"5","name":""],
        ["number":"6","name":""],
        ["number":"7","name":""],
        ["number":"8","name":""],
        ["number":"9","name":""],
        ["number":"10","name":""],
        ["number":"11","name":""],
        ["number":"12","name":""],
        ["number":"13","name":""],
        ["number":"14","name":""],
        ["number":"15","name":""],
        ["number":"16","name":""],
        ["number":"17","name":""],
        ["number":"18","name":""],
        ["number":"19","name":""],
        ["number":"20","name":""],
        ["number":"21","name":""],
        ["number":"22","name":""],
        ["number":"23","name":""],
        ["number":"24","name":""],
        ["number":"25","name":""],
        ["number":"26","name":""]
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
        
        let row = registerTeamData[indexPath.row]
        let numberField = cell.contentView.viewWithTag(2) as!UITextField
        numberField.text = row["number"]!

        let nameField = cell.contentView.viewWithTag(3) as! UITextField
        nameField.text = row["name"]!
        
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
    func updateRegisterTeamData(index:Int,value:String,option:String){
        registerTeamData[index-1][option] = value
        let _ = validateRegisterData()
        print(registerTeamData)
        return
    }
    
    func validateRegisterData()->Bool{
//        for datum in registerTeamData{
//            //登録しないデータ　正常系としてcontinueで飛ばす
//            if(datum["number"]=="" && datum["name"]==""){
//                continue
//            }
//            
//            if(datum["num"])
//            
//        }
        return true
    }
    //Playerの背番号を更新する関数
    @IBAction func changePlayerNumber(_ sender: UITextField) {
        let changedNumber = String(sender.text!)
        if let changedSuperview  = sender.superview{
            let index = changedSuperview.viewWithTag(1) as!UILabel
            if let indexInt = Int(index.text!) {
                updateRegisterTeamData(index: indexInt, value: changedNumber, option: "number")
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
                updateRegisterTeamData(index: indexInt, value: changedName, option: "name")
            } else {
                print("数値ではありません。")
                return
            }
        }else{
            return
        }
    }
}
