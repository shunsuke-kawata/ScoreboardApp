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
    var registerTeamData:[PlayerInputObject] = (1..<27).map { i in
        return PlayerInputObject(number:i, name: "", position: "")
    }

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

        let indexLabel = cell.contentView.viewWithTag(1) as!UILabel
        indexLabel.text = String(indexPath.row+1)
        
        let row = registerTeamData[indexPath.row]
        let numberField = cell.contentView.viewWithTag(2) as!UITextField
        if row.number != nil{
            numberField.text = String(row.number!)
        }else{
            numberField.text = ""
        }
        

        let nameField = cell.contentView.viewWithTag(3) as! UITextField
        nameField.text = row.name

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
        if(registerNewTeamInstance.registerNewTeam(teamName:teamNameField.text!,members:registerTeamData)){
            self.navigationController?.popViewController(animated: true)
        }else{
            return
        }
        
    }
    //チーム登録を行うフィールドに対してバリデーションを行う
    func validateRegisterData()->Bool{
        for datum in registerTeamData{
            //登録しないデータ　正常系としてcontinueで飛ばす
            if(datum.number==nil && datum.name==""){
                continue
            }else{
                //どちらかの値が入っていないデータは登録しない
                if(datum.number==nil){
                    print("number is blank")
                    return false
                }else if let unwrappedDatumNumber = datum.number {
                    //アンラップを使用して判定処理を行う
                    if(1<=unwrappedDatumNumber && unwrappedDatumNumber<=99){
                            continue
                    }else{
                            print("uniform number must be between 1 and 99")
                            return false
                        }
                }else{
                    print("cannot unwrap datum number")
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
        print("update playernumber")
        if let changedSuperview  = sender.superview{
            let index = changedSuperview.viewWithTag(1) as!UILabel
            if let indexInt = Int(index.text!) {
                if let numberInt = Int(sender.text!){
                    registerTeamData[indexInt-1].number = numberInt
                }
                else {
                    registerTeamData[indexInt-1].number = nil
                    print("number is not type int")
                    return
                }
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
                registerTeamData[indexInt-1].name = changedName
            } else {
                print("test")
                print("number is invalid")
                return
            }
        }else{
            print("could not find super class")
            return
        }
    }
    
}
