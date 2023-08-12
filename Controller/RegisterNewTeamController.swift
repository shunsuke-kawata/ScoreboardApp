//
//  RegisterNewTeamController.swift
//  Scoreboard
//
//  Created by 川田　隼輔 on 2023/03/15.
//
import UIKit

enum PositionType: CaseIterable {
    case none
    case fw
    case mf
    case df
    case gk
    
    var selected:String{
        switch self {
        case .none:
            return "--"
        case .fw:
            return "FW"
        case .mf:
            return "MF"
        case .df:
            return "DF"
        case .gk:
            return "GK"
        }
    }
}


class RegisterNewTeamController:UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    //ポジションを選択するタイプの定義
    
        //最大で26人分の選手データを登録する配列
    //dict型の配列に変更
    var registerTeamData:[Dictionary<String,String>] = [
        ["number":"","name":"","position":"--"],
        ["number":"","name":"","position":"--"],
        ["number":"","name":"","position":"--"],
        ["number":"","name":"","position":"--"],
        ["number":"","name":"","position":"--"],
        ["number":"","name":"","position":"--"],
        ["number":"","name":"","position":"--"],
        ["number":"","name":"","position":"--"],
        ["number":"","name":"","position":"--"],
        ["number":"","name":"","position":"--"],
        ["number":"","name":"","position":"--"],
        ["number":"","name":"","position":"--"],
        ["number":"","name":"","position":"--"],
        ["number":"","name":"","position":"--"],
        ["number":"","name":"","position":"--"],
        ["number":"","name":"","position":"--"],
        ["number":"","name":"","position":"--"],
        ["number":"","name":"","position":"--"],
        ["number":"","name":"","position":"--"],
        ["number":"","name":"","position":"--"],
        ["number":"","name":"","position":"--"],
        ["number":"","name":"","position":"--"],
        ["number":"","name":"","position":"--"],
        ["number":"","name":"","position":"--"],
        ["number":"","name":"","position":"--"],
        ["number":"","name":"","position":"--"]
    ]

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var registerSubmitButton: UIButton!
    
//    @IBOutlet weak var positionSelectButton: UIButton!
    var selectedMenuType = PositionType.none
    @IBOutlet weak var teamNameField: UITextField!
    @IBOutlet weak var registerFormTableView: UITableView!
    
    let registerNewTeamInstance = RegisterNewTeamModel()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 26;
        }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "protoRegisterNewTeam", for: indexPath)

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
//        self.configureMenu()
        }
    
    //戻るボタンをタップしたとき
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //登録ボタンをタップしたとき
    @IBAction func registerSubmitButtonTapped(_ sender: UIButton) {
        
        //登録するデータのバリデーションを行う
        if(!validateRegisterData()){
            return
        }else{
            print("No validation errors")
        }
        registerNewTeamInstance.registerNewTeam(teamName:teamNameField.text!,members:registerTeamData)
        self.navigationController?.popViewController(animated: true)
    }
    //TableViewからformで送信して登録する値を取得してくる

    //配列の内容を更新する関数
    func updateRegisterTeamData(index:Int,value:String,option:String){
        registerTeamData[index-1][option] = value
        return
    }
    
    
    //チーム登録を行うフィールドに対してバリデーションを行う
    func validateRegisterData()->Bool{
        for datum in registerTeamData{
            //登録しないデータ　正常系としてcontinueで飛ばす
            if(datum["number"]=="" && datum["name"]==""){
                continue
            }else{
                //どちらかの値が入っていないデータは登録しない
                if(datum["number"]==""){
                    print("number is blank")
                    return false
                }else {
                    //numberが数値かどうか判定する
                    let numInt:Int? = Int(datum["number"]!)
                    //アンラップを使用して判定処理を行う
                    if let unwrappedInt = numInt{
                        if(1<=unwrappedInt && unwrappedInt<=99){
                            continue
                        }else{
                            print("Number is invalid")
                            return false
                        }
                    }else{
                        print("number is invalid")
                        return false
                    }
                }
            }
        }
        if(teamNameField.text! == ""){
            print("teamname is blank")
            return false
        }else{
            return true
        }
        
    }
    //Playerの背番号を更新する関数
    @IBAction func changePlayerNumber(_ sender: UITextField) {
        let changedNumber = String(sender.text!)
        if let changedSuperview  = sender.superview{
            let index = changedSuperview.viewWithTag(1) as!UILabel
            if let indexInt = Int(index.text!) {
                updateRegisterTeamData(index: indexInt, value: changedNumber, option: "number")
            } else {
                print("number is invalid")
                return
            }
        }else{
            print("could not find super class")
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
                print("number is invalid")
                return
            }
        }else{
            print("could not find super class")
            return
        }
    }
    
}
