//
//  RecordGameBController.swift
//  Scoreboard
//
//  Created by 川田隼輔 on 2023/08/18.
//

import Foundation
import UIKit

var allScoreCountYourTeam:Int = 0

class RecordGameBController:UIViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate, UIPickerViewDataSource{
    
    var thisGame: Game? = nil
    private var regulationTime:Double = 0.0
    private var yourTeam:Team? = nil
    private var playDataObjectArray:Dictionary<String,PlayDataObject> = [:]
    private var idAndIndexPath:Dictionary<Int,String> = [:]
    private var pickerNameAndNumberArray:[String] = []
    private var selectedMemberByPicker:String = ""
    
    let recordGameInstance = RecordGameModel()
    
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var resetTimerButton: UIButton!
    
    @IBOutlet weak var dataDisplayTableView: UITableView!
    @IBOutlet weak var teamNameLabel: UILabel!
    
    @IBOutlet weak var allScoreCountLabel: UILabel!
    
    @IBOutlet weak var memberSelectPickerView: UIPickerView!
    
    @IBOutlet weak var selectedMemberScoreLabel: UILabel!
    @IBOutlet weak var selectedMemberShootLabel: UILabel!
    @IBOutlet weak var selectedMemberAssistLabel: UILabel!
    @IBOutlet weak var selectedMemberScoreLateLabel: UILabel!
    @IBOutlet weak var selectedMemberMissLabel: UILabel!
    @IBOutlet weak var selectedMemberSaveLabel: UILabel!
    @IBOutlet weak var selectedMemberYellowLabel: UILabel!
    @IBOutlet weak var selectedMemberRedLabel: UILabel!
    
    
    @IBOutlet weak var scorePlusButton: UIButton!
    @IBOutlet weak var scoreMinusButton: UIButton!
    
    @IBOutlet weak var shootPlusButton: UIButton!
    @IBOutlet weak var shootMinusButton: UIButton!
    
    @IBOutlet weak var assistPlusButton: UIButton!
    @IBOutlet weak var assistMinusButton: UIButton!
    
    @IBOutlet weak var missPlusButton: UIButton!
    @IBOutlet weak var missMinusButton: UIButton!
    
    @IBOutlet weak var savePlusButton: UIButton!
    @IBOutlet weak var saveMinusButton: UIButton!
    
    @IBOutlet weak var yellowPlusButton: UIButton!
    @IBOutlet weak var yellowMinusButton: UIButton!
    
    @IBOutlet weak var redPlusButton: UIButton!
    @IBOutlet weak var redMinusButton: UIButton!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _yourTeam = yourTeam {
            print("executed")
            return _yourTeam.members.count
        }else{
            
            return 0
        }
    }
    
    //多分tableViewが毎回走ることでエラーを起こしている
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("exe")
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "protoDisplayData", for: indexPath)
       
        let indexString = idAndIndexPath[indexPath.row]!
        //indexPath.rowの番号と追加されたictのindexが同じ番号であると言える
        let numberLabel = cell.contentView.viewWithTag(1) as!UILabel
        numberLabel.text =  String(playDataObjectArray[indexString]!.number)
        let nameLabel = cell.contentView.viewWithTag(2) as!UILabel
        nameLabel.text = playDataObjectArray[indexString]!.name
        let scoreLabel = cell.contentView.viewWithTag(3) as!UILabel
        scoreLabel.text = String(playDataObjectArray[indexString]!.score_count)
        let shootLabel = cell.contentView.viewWithTag(4) as!UILabel
        shootLabel.text = String(playDataObjectArray[indexString]!.shoot_count)
        let assistLabel = cell.contentView.viewWithTag(5) as!UILabel
        assistLabel.text = String(playDataObjectArray[indexString]!.assist_count)
        
        let scoreLateLabel = cell.contentView.viewWithTag(6) as!UILabel
        if (playDataObjectArray[indexString]!.score_count == 0){
            scoreLateLabel.text = String(Double(playDataObjectArray[indexString]!.score_count)) + "%"
        }
        else if (playDataObjectArray[indexString]!.shoot_count == 0){
            selectedMemberScoreLateLabel.text  = "error"
        }else{
            let scoreLate = round(Double(playDataObjectArray[indexString]!.score_count)/Double(playDataObjectArray[indexString]!.shoot_count)*100)
            selectedMemberScoreLateLabel.text = String(scoreLate) + "%"
        }

        let missLabel = cell.contentView.viewWithTag(7) as!UILabel
        missLabel.text = String(playDataObjectArray[indexString]!.miss_count)
        let saveLabel = cell.contentView.viewWithTag(8) as!UILabel
        saveLabel.text = String(playDataObjectArray[indexString]!.save_count)
        let yellowLabel = cell.contentView.viewWithTag(9) as!UILabel
        yellowLabel.text = String(playDataObjectArray[indexString]!.yellow_count)
        let redLabel = cell.contentView.viewWithTag(10) as!UILabel
        redLabel.text = String(playDataObjectArray[indexString]!.red_count)
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //delegateの設定
        self.memberSelectPickerView.delegate = self
        self.memberSelectPickerView.dataSource = self
        self.memberSelectPickerView.frame  = CGRect(x: 190, y: 210, width: 274, height: 121)
        
        if let _thisGame = thisGame {
            yourTeam = recordGameInstance.searchTeam(teamId: _thisGame.your_team_id)
            
            if let _yourTeam = yourTeam {
                for (index,member) in _yourTeam.members.enumerated(){
                    let tmpPlayData: PlayDataObject = PlayDataObject(id: member.id, number: member.number, name: member.name)
                    idAndIndexPath[index] = member.id
                    let _ = addPlayDataObjectArray(indexString: member.id, tmpPlayData: tmpPlayData)
                }
                setTeamInfomation(team: _yourTeam)
            }
            
//            yourTeam = recordGameInstance.searchTeam(teamId: _thisGame.your_team_id)!
            regulationTime = Double(_thisGame.regulation_time)
            initializeTimer(regulationTime: regulationTime)
            
        }else{
            print("failed to game infomation")
        }
    
        self.updateTimerDisplay()
        self.updateAllScoreLabel()
    }
    
    // 列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //デフォルト値の設定
    func pickerView(_ pickerView: UIPickerView,numberOfRowsInComponent component: Int) -> Int {
        if let _yourTeam = yourTeam {
            return _yourTeam.members.count
        }else{
            return 1
        }
    }
    
    //選択が変更された時の処理
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMemberByPicker = pickerNameAndNumberArray[row]
        print(selectedMemberByPicker)
        updateSelectedMemberInfomation()
        
    }
    
    // 最初に選択状態にする行データ
    func pickerView(_ pickerView: UIPickerView,titleForRow row: Int,forComponent component: Int) -> String? {
        let splitComponents = pickerNameAndNumberArray[row].components(separatedBy: ":")
        return splitComponents[1]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //delegateの設定
        self.memberSelectPickerView.delegate = self
        self.memberSelectPickerView.dataSource = self
        self.memberSelectPickerView.frame  = CGRect(x: 190, y: 210, width: 274, height: 121)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegateの設定
        self.memberSelectPickerView.delegate = self
        self.memberSelectPickerView.dataSource = self
        self.memberSelectPickerView.frame  = CGRect(x: 190, y: 210, width: 274, height: 121)
        
        if let _thisGame = thisGame {
            yourTeam = recordGameInstance.searchTeam(teamId: _thisGame.your_team_id)
            
            if let _yourTeam = yourTeam {
                for (index,member) in _yourTeam.members.enumerated(){
                    let tmpPlayData: PlayDataObject = PlayDataObject(id: member.id, number: member.number, name: member.name)
                    idAndIndexPath[index] = member.id
                    let _ = addPlayDataObjectArray(indexString: member.id, tmpPlayData: tmpPlayData)
                }
                setTeamInfomation(team: _yourTeam)
            }
            
//            yourTeam = recordGameInstance.searchTeam(teamId: _thisGame.your_team_id)!
            regulationTime = Double(_thisGame.regulation_time)
            initializeTimer(regulationTime: regulationTime)
            
        }else{
            print("failed to game infomation")
        }
    
        self.updateTimerDisplay()
        self.updateAllScoreLabel()
    }
    
    func setTeamInfomation(team:Team?){
        
        if let _team = team{
            teamNameLabel.text = _team.name
            for member in _team.members{
                let numberAndName:String = member.id + ":" + String(member.number) + " " + String(member.name)
                pickerNameAndNumberArray.append(numberAndName)
            }
            selectedMemberByPicker = pickerNameAndNumberArray[0]
        }else{
            print("failed to set team infomation")
        }
        updateSelectedMemberInfomation()
    }
    
    func initializeTimer(regulationTime:Double){
        time = regulationTime * 60
        timerButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func updateTimerDisplay() {
        let minutes = Int(time / 60)
        let seconds = Int(time) % 60
        let timerTitle = String(format: "%02d:%02d", minutes, seconds)
        timerButton.setTitle(timerTitle, for: .normal) // ボタンのタイトルを更新する
    }
    
    func addPlayDataObjectArray(indexString:String,tmpPlayData:PlayDataObject)->Int{
        playDataObjectArray[indexString] = tmpPlayData
        return playDataObjectArray.count
    }
    
    func updateAllScoreLabel(){
        allScoreCountYourTeam = 0
        for element in self.playDataObjectArray{
            let value = element.value
            allScoreCountYourTeam  += value.score_count
        }
        self.allScoreCountLabel.text = String(allScoreCountMyTeam) + "-" + String(allScoreCountYourTeam)
    }
    
    
    func updateSelectedMemberInfomation(){
        let splitComponents = selectedMemberByPicker.components(separatedBy: ":")
        
        //背番号を取得
        if let idString = splitComponents.first {
            if let selectedMemberDatum = playDataObjectArray[idString] {
                selectedMemberScoreLabel.text = String(selectedMemberDatum.score_count)
                selectedMemberShootLabel.text = String(selectedMemberDatum.shoot_count)
                selectedMemberAssistLabel.text = String(selectedMemberDatum.assist_count)
                if (selectedMemberDatum.score_count == 0){
                    selectedMemberScoreLateLabel.text = String(Double(selectedMemberDatum.score_count)) + "%"
                }
                else if (selectedMemberDatum.shoot_count == 0){
                    selectedMemberScoreLateLabel.text  = "error"
                }else{
                    let scoreLate = round(Double(selectedMemberDatum.score_count)/Double(selectedMemberDatum.shoot_count)*100)
                    selectedMemberScoreLateLabel.text = String(scoreLate) + "%"
                }
                selectedMemberMissLabel.text = String(selectedMemberDatum.miss_count)
                selectedMemberSaveLabel.text = String(selectedMemberDatum.save_count)
                selectedMemberYellowLabel.text = String(selectedMemberDatum.yellow_count)
                selectedMemberRedLabel.text = String(selectedMemberDatum.red_count)
            }
            
           
            
        } else {
            print("failed to update selected member infomation")
            return
        }
    }
    
    func getCell(atRow row: Int) -> UITableViewCell? {
        let indexPath = IndexPath(row: row, section: 0) // 0はセクション番号です
        let cell = self.dataDisplayTableView.cellForRow(at: indexPath)
        return cell
    }
    
    
    //スクロールした時の処理を記述する
    func updateDisplayDataTableView(){
        
        
        if let _yourTeam = yourTeam, let data = getPlayDataToChange(){
            let rowsCount = _yourTeam.members.count
            for row in 0..<rowsCount{
                if let cell:UITableViewCell = getCell(atRow: row){
                    let numberLabel = cell.contentView.viewWithTag(1) as!UILabel
                    if String(data.number) == numberLabel.text {
                        let scoreLabel = cell.contentView.viewWithTag(3) as!UILabel
                        scoreLabel.text = String(data.score_count)
                        let shootLabel = cell.contentView.viewWithTag(4) as!UILabel
                        shootLabel.text = String(data.shoot_count)
                        let assistLabel = cell.contentView.viewWithTag(5) as!UILabel
                        assistLabel.text = String(data.assist_count)

                        let scoreLateLabel = cell.contentView.viewWithTag(6) as!UILabel
                        if (data.score_count == 0){
                            print(1)
                            scoreLateLabel.text = String(Double(data.score_count)) + "%"
                        }
                        else if (data.shoot_count == 0){
                            print(2)
                            scoreLateLabel.text  = "error"
                        }else{
                            print(3)
                            let scoreLate = round(Double(data.score_count)/Double(data.shoot_count)*100)
                            scoreLateLabel.text = String(scoreLate) + "%"
                        }
                        

                        let missLabel = cell.contentView.viewWithTag(7) as!UILabel
                        missLabel.text = String(data.miss_count)
                        let saveLabel = cell.contentView.viewWithTag(8) as!UILabel
                        saveLabel.text = String(data.save_count)
                        let yellowLabel = cell.contentView.viewWithTag(9) as!UILabel
                        yellowLabel.text = String(data.yellow_count)
                        let redLabel = cell.contentView.viewWithTag(10) as!UILabel
                        redLabel.text = String(data.red_count)
                    }
                }
            }
        }else{
            print("failed to get cell")
            return
        }
        
    }
    
    @IBAction func resetTimerButtonTapped(_ sender: Any) {
        timerIsRunning = false
        initializeTimer(regulationTime: regulationTime)
        updateTimerDisplay()
    }
    
    @IBAction func timerButtonTapped(_ sender: Any) {
        if timerIsRunning {
            timerIsRunning = false
            timer.invalidate()
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                if (time != 0.0){
                    time -= 0.01
                }
                self.updateTimerDisplay() // タイマーの値を更新して表示を更新する
            }
            timer.fire() // タイマーを即座に起動
            timerIsRunning = true
        }
    }
    
    func getPlayDataToChange()->PlayDataObject?{
        if let idString = selectedMemberByPicker.components(separatedBy: ":").first, let returnValue = playDataObjectArray[idString]{
            return returnValue
        }else{
            print("break")
            return nil
        }
    }
    
    @IBAction func scorePlusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange(){
            playData.increaseScore()
        }
        self.updateSelectedMemberInfomation()
        self.updateDisplayDataTableView()
        self.updateAllScoreLabel()

    }
    
    @IBAction func scoreMinusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
            playData.decreaseScore()
            
        }
        self.updateSelectedMemberInfomation()
        self.updateDisplayDataTableView()
        self.updateAllScoreLabel()
    }
    
    @IBAction func shootPlusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
                playData.increaseShoot()
        }
        self.updateSelectedMemberInfomation()
        self.updateDisplayDataTableView()
    }
    
    @IBAction func shootMinusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
            playData.decreaseShoot()
        }
        self.updateSelectedMemberInfomation()
        self.updateDisplayDataTableView()
    }
    
    @IBAction func assistPlusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
            playData.increaseAssist()
        }
        self.updateSelectedMemberInfomation()
        self.updateDisplayDataTableView()
    }
    
    @IBAction func assistMinusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
            playData.decreaseAssist()
        }
        self.updateSelectedMemberInfomation()
        self.updateDisplayDataTableView()
    }
    
    @IBAction func missPlusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
            playData.increaseMiss()
        }
        self.updateSelectedMemberInfomation()
        self.updateDisplayDataTableView()
    }
    
    @IBAction func missMinusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
            playData.decreaseMiss()
        }
        self.updateSelectedMemberInfomation()
        self.updateDisplayDataTableView()
    }
    
    @IBAction func savePlusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
            playData.increaseSave()
        }
        self.updateSelectedMemberInfomation()
        self.updateDisplayDataTableView()
    }
    
    @IBAction func saveMinusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
            playData.decreaseSave()
        }
        self.updateSelectedMemberInfomation()
        self.updateDisplayDataTableView()
    }
    
    @IBAction func yellowPlusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
            playData.increaseYellow()
        }
        self.updateSelectedMemberInfomation()
        self.updateDisplayDataTableView()
    }
    
    @IBAction func yellowMinusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
            playData.decreaseYellow()
        }
        self.updateSelectedMemberInfomation()
        self.updateDisplayDataTableView()
    }
    
    @IBAction func redPlusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
            playData.increaseRed()
        }
        self.updateSelectedMemberInfomation()
        self.updateDisplayDataTableView()
    }
    
    @IBAction func redMinusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
            playData.decreaseRed()
        }
        self.updateSelectedMemberInfomation()
        self.updateDisplayDataTableView()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
