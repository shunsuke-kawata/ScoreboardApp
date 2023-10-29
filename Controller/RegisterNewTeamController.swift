//
//  RegisterNewTeamController.swift
//  Scoreboard
//
//  Created by 川田　隼輔 on 2023/03/15.
//
import UIKit

enum PositionType: String{
    case none = "--"
    case fw = "FW"
    case mf = "MF"
    case df = "DF"
    case gk = "GK"
    
    static var allCases: [PositionType] = [.none,.fw ,.mf , .df,.gk]
}

class RegisterNewTeamController:UIViewController, UITableViewDelegate, UITableViewDataSource  {

    //最大で26人分の選手データを登録するオブジェクトの配列
    var registerTeamData:[PlayerInputObject] = (1..<27).map { i in
        return PlayerInputObject(number:i, name: "", position: PositionType.none.rawValue)
    }

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var registerSubmitButton: UIButton!
    
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
        
        let positionButton = cell.contentView.viewWithTag(4) as! UIButton
        configurePositionButton(button: positionButton, selected: row)
        positionButton.setTitle(row.position, for: .normal)
        return cell
     }
//    
    private func configurePositionButton(button: UIButton, selected: PlayerInputObject) {
        // 新しいUIActionオブジェクトを保持する変数
        var newActions = [UIAction]()

        // Enumの全ての要素に対してループ
        for positionType in PositionType.allCases {
            let action = UIAction(
                title: positionType.rawValue
//                state: selected.position == positionType.rawValue ? .on : .off
            ) { action in
                // ボタンのタイトルを更新
                button.setTitle(action.title, for: .normal)

                // 新しいUIActionオブジェクトを作成して、古いアクションを置き換える
                for var newAction in newActions {
                    // 同じタイトルを持つUIActionを新しい状態で作成
                    if newAction.title == action.title {
                        newAction = UIAction(
                            title: newAction.title,
                            state: .on
                        ) { _ in
                            // 何かアクションが必要ならここで実行
                        }
                    } else {
                        newAction = UIAction(
                            title: newAction.title,
                            state: .off
                        ) { _ in
                            // 何かアクションが必要ならここで実行
                        }
                    }
                }

                // 新しいUIActionの配列でメニューを再構築
                button.menu = UIMenu(title: "", options: .displayInline, children: newActions)

                // 選択されたポジションを保存
                selected.position = action.title
            }
            newActions.append(action)
        }

        // UIButtonに新しいUIMenuを設定
        button.menu = UIMenu(title: "", options: .displayInline, children: newActions)
        button.showsMenuAsPrimaryAction = true
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
            for i in registerTeamData{
                print(i.position)
            }
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
                    return false
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
