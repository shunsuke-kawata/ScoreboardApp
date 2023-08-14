import Foundation
import UIKit

class RecordGameController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate, UIPickerViewDataSource {
    
    var thisGame: Game? = nil
    private var timerIsRunning: Bool = false
    private var time: Double = 0.0
    private var timer: Timer = Timer()
    private var regulationTime:Double = 0.0
    private var myTeam:Team?
    private var yourTeam: Team?
    private var playDataMatrix: Dictionary<String, Dictionary<String, String>> = [:]
    private var pickerNameAndNumberArray:[String] = []
    private var selectedMemberByPicker:String = ""
    
    let recordGameInstance = RecordGameModel()
    
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var resetTimerButton: UIButton!
    
    @IBOutlet weak var dataDisplayTableView: UITableView!
    @IBOutlet weak var teamNameLabel: UILabel!

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
        if let _myTeam = myTeam {
            return _myTeam.members.count
        }else{
            return 0
        }
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "protoDisplayData", for: indexPath)
        if let _members = myTeam?.members {
            let _member:Player = _members[indexPath.row]
            let tmpDict:Dictionary<String,String> = [
                "id":_member.id,
                "number":String(_member.number),
                "name":_member.name,
                "score_count":"0",
                "shoot_count":"0",
                "assist_count":"0",
                "miss_count":"0",
                "save_count":"0",
                "yellow_count":"0",
                "red_count":"0"
            ]
            
            let indexString = tmpDict["number"]!
            //indexPath.rowの番号と追加されたictのindexが同じ番号であると言える
            let _ = addPlayDataMatrix(indexString:indexString,tmpDict: tmpDict)
            let numberLabel = cell.contentView.viewWithTag(1) as!UILabel
            numberLabel.text =  playDataMatrix[indexString]!["number"]
            let nameLabel = cell.contentView.viewWithTag(2) as!UILabel
            nameLabel.text = playDataMatrix[indexString]!["name"]
            let scoreLabel = cell.contentView.viewWithTag(3) as!UILabel
            scoreLabel.text = playDataMatrix[indexString]!["score_count"]
            let shootLabel = cell.contentView.viewWithTag(4) as!UILabel
            shootLabel.text = playDataMatrix[indexString]!["shoot_count"]
            let assistLabel = cell.contentView.viewWithTag(5) as!UILabel
            assistLabel.text = playDataMatrix[indexString]!["assist_count"]
            
            let Label = cell.contentView.viewWithTag(6) as!UILabel
            Label.text = playDataMatrix[indexString]!["score_count"]
            
            let missLabel = cell.contentView.viewWithTag(7) as!UILabel
            missLabel.text = playDataMatrix[indexString]!["miss_count"]
            let saveLabel = cell.contentView.viewWithTag(8) as!UILabel
            saveLabel.text = playDataMatrix[indexString]!["save_count"]
            let yellowLabel = cell.contentView.viewWithTag(9) as!UILabel
            yellowLabel.text = playDataMatrix[indexString]!["yellow_count"]
            let redLabel = cell.contentView.viewWithTag(10) as!UILabel
            redLabel.text = playDataMatrix[indexString]!["red_count"]
        }
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //delegateの設定
        memberSelectPickerView.delegate = self
        memberSelectPickerView.dataSource = self
        
        if let _thisGame = thisGame {
            myTeam = recordGameInstance.searchTeam(teamId: _thisGame.my_team_id)!
            
//            yourTeam = recordGameInstance.searchTeam(teamId: _thisGame.your_team_id)!
            regulationTime = Double(_thisGame.regulation_time)
            initializeTimer(regulationTime: regulationTime)
            setTeamInfomation(team: myTeam)
        }else{
            print("failed to game infomation")
        }
    
        updateTimerDisplay()
        
        
//        if let initialSelectedRow = pickerNameAndNumberArray.firstIndex(of: selectedMemberByPicker) {
//                memberSelectPickerView.selectRow(initialSelectedRow, inComponent: 0, animated: false)
//                updateSelectedMember(selectedRow: initialSelectedRow)
//            }
    }
    
    // 列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //デフォルト値の設定
    func pickerView(_ pickerView: UIPickerView,numberOfRowsInComponent component: Int) -> Int {
        if let _myTeam = myTeam {
            return _myTeam.members.count
        }else{
            return 1
        }
    }
    
    //選択が変更された時の処理
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMemberByPicker = pickerNameAndNumberArray[row]
        updateSelectedMemberInfomation()
        
    }
    
    // 最初に選択状態にする行データ
    func pickerView(_ pickerView: UIPickerView,titleForRow row: Int,forComponent component: Int) -> String? {
        return pickerNameAndNumberArray[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegateの設定
        memberSelectPickerView.delegate = self
        memberSelectPickerView.dataSource = self
        
        if let _thisGame = thisGame {
            myTeam = recordGameInstance.searchTeam(teamId: _thisGame.my_team_id)!
            
//            yourTeam = recordGameInstance.searchTeam(teamId: _thisGame.your_team_id)!
            regulationTime = Double(_thisGame.regulation_time)
            initializeTimer(regulationTime: regulationTime)
            //初回の情報アップデートはまだ値がplayDataMatrixに入っていないため動作していない
            setTeamInfomation(team: myTeam)
        }else{
            print("failed to game infomation")
        }
        updateTimerDisplay()
        print(222)
        
//        if let initialSelectedRow = pickerNameAndNumberArray.firstIndex(of: selectedMemberByPicker) {
//                memberSelectPickerView.selectRow(initialSelectedRow, inComponent: 0, animated: false)
//                updateSelectedMember(selectedRow: initialSelectedRow)
//            }
//        print("executed")
    }
    
    func setTeamInfomation(team:Team?){
        
        if let _team = team{
            teamNameLabel.text = _team.name
            for member in _team.members{
                let numberAndName:String = String(member.number) + " " + String(member.name)
                pickerNameAndNumberArray.append(numberAndName)
            }
        }else{
            print("failed to set team infomation")
        }
//        updateSelectedMemberInfomation()
    }
    
    
    func initializeTimer(regulationTime:Double){
        self.time = regulationTime * 60
        timerButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func updateTimerDisplay() {
        let minutes = Int(self.time / 60)
        let seconds = Int(self.time) % 60
        let timerTitle = String(format: "%02d:%02d", minutes, seconds)
        timerButton.setTitle(timerTitle, for: .normal) // ボタンのタイトルを更新する
    }
    
    func addPlayDataMatrix(indexString:String,tmpDict:Dictionary<String,String>)->Int{
        playDataMatrix[indexString] = tmpDict
        return playDataMatrix.count
    }
    
    func updateSelectedMemberInfomation(){
        let splitComponents = selectedMemberByPicker.components(separatedBy: " ")
        
        //背番号を取得
        if let numberString = splitComponents.first {
            let selectedMemberDatum = playDataMatrix[numberString]!
            selectedMemberScoreLabel.text = selectedMemberDatum["score_count"]
            selectedMemberShootLabel.text = selectedMemberDatum["shoot_count"]
            selectedMemberAssistLabel.text = selectedMemberDatum["assist_count"]
            selectedMemberScoreLateLabel.text = selectedMemberDatum["score_count"]
            selectedMemberMissLabel.text = selectedMemberDatum["miss_count"]
            selectedMemberSaveLabel.text = selectedMemberDatum["save_count"]
            selectedMemberYellowLabel.text = selectedMemberDatum["yellow_count"]
            selectedMemberRedLabel.text = selectedMemberDatum["red_count"]
            
        } else {
            print("failed to update selected member infomation")
            return
        }
    }
    
    func getCell(atRow row: Int) -> UITableViewCell? {
        let indexPath = IndexPath(row: row, section: 0) // 0はセクション番号です
        let cell = dataDisplayTableView.cellForRow(at: indexPath)
        return cell
    }
    
    func updateDisplayDataTableView(){
        if let _myTeam = myTeam {
            let rowsCount = _myTeam.members.count
            for row in 0..<rowsCount{
                let indexPath = IndexPath(row: row, section: 0)
                dataDisplayTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }else{
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
                if (self.time != 0.0){
                    self.time -= 0.01
                }
                self.updateTimerDisplay() // タイマーの値を更新して表示を更新する
            }
            timer.fire() // タイマーを即座に起動
            timerIsRunning = true
        }
    }
    
    
    @IBAction func scorePlusButtonTapped(_ sender: Any) {
        let splitComponents = selectedMemberByPicker.components(separatedBy: " ")
        if let numberString = splitComponents.first,let  selectedMemberDatum = playDataMatrix[numberString]{
            if let scoreString = selectedMemberDatum["score_count"] , let scoreInt = Int(scoreString){
                let tmpScore = scoreInt + 1
                playDataMatrix[numberString]!["score_count"] = String(tmpScore)
            }
        } else {
            print("failed to update selected member infomation")
            return
        }
        
        updateSelectedMemberInfomation()
        print(playDataMatrix)
//        updateDisplayDataTableView()

        
        
    }
    
    @IBAction func scoreMinusButtonTapped(_ sender: Any) {
    }
    
    @IBAction func shootPlusButtonTapped(_ sender: Any) {
    }
    
    @IBAction func shootMinusButtonTapped(_ sender: Any) {
    }
    
    @IBAction func assistPlusButtonTapped(_ sender: Any) {
    }
    
    @IBAction func assistMinusButtonTapped(_ sender: Any) {
    }
    
    @IBAction func missPlusButtonTapped(_ sender: Any) {
    }
    
    @IBAction func missMinusButtonTapped(_ sender: Any) {
    }
    
    @IBAction func savePlusButtonTapped(_ sender: Any) {
    }
    
    @IBAction func saveMinusButtonTapped(_ sender: Any) {
    }
    
    @IBAction func yellowPlusButtonTapped(_ sender: Any) {
    }
    
    @IBAction func yellowMinusButtonTapped(_ sender: Any) {
    }
    
    @IBAction func redPlusButtonTapped(_ sender: Any) {
    }
    
    @IBAction func redMinusButtonTapped(_ sender: Any) {
    }
    
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
