//
//  RegisterNewTeamController.swift
//  Scoreboard
//
//  Created by 川田　隼輔 on 2023/03/15.
//
import UIKit

class RegisterNewTeamController:UIViewController, UITableViewDelegate, UITableViewDataSource  {

    //最大で26人分の選手データを登録する配列
    //dict型の配列に変更
    var registerTeamData:[Dictionary<String,String>] = [
        ["number":"","name":""],
        ["number":"","name":""],
        ["number":"","name":""],
        ["number":"","name":""],
        ["number":"","name":""],
        ["number":"","name":""],
        ["number":"","name":""],
        ["number":"","name":""],
        ["number":"","name":""],
        ["number":"","name":""],
        ["number":"","name":""],
        ["number":"","name":""],
        ["number":"","name":""],
        ["number":"","name":""],
        ["number":"","name":""],
        ["number":"","name":""],
        ["number":"","name":""],
        ["number":"","name":""],
        ["number":"","name":""],
        ["number":"","name":""],
        ["number":"","name":""],
        ["number":"","name":""],
        ["number":"","name":""],
        ["number":"","name":""],
        ["number":"","name":""],
        ["number":"","name":""]
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
        //登録するデータのバリデーションを行う
        if(!validateRegisterData()){
            print("登録できない選手情報が発見されました。")
            return
        }else{
            print("バリーデーションエラーなし")
        }
        registerInstance.registerNewTeam(teamName:teamNameField.text!,members:registerTeamData)
        print("clicked")
    }
    //TableViewからformで送信して登録する値を取得してくる
    
    //配列の内容を更新する関数
    func updateRegisterTeamData(index:Int,value:String,option:String){
        registerTeamData[index-1][option] = value
        return
    }
    
    func validateRegisterData()->Bool{
        for datum in registerTeamData{
            //登録しないデータ　正常系としてcontinueで飛ばす
            if(datum["number"]=="" && datum["name"]==""){
                continue
            }else{
                //どちらかの値が入っていないデータは登録しない
                if(datum["number"]=="" || datum["name"]==""){
                    print("登録できない選手情報があります。")
                    return false
                }else {
                    //numberが数値かどうか判定する
                    let numInt:Int? = Int(datum["number"]!)
                    //アンラップを使用して判定処理を行う
                    if let unwrappedInt = numInt{
                        if(1<=unwrappedInt && unwrappedInt<=99){
                            continue
                        }else{
                            print("背番号が正しい値ではありません。")
                            return false
                        }
                    }else{
                        print("背番号が認識できない選手情報があります。")
                        return false
                    }
                }
            }

        }
        if(teamNameField.text! == ""){
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
