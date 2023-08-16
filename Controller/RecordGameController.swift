import Foundation
import UIKit

class PlayDataObject {
    let id: String
    let number: Int
    let name: String
    var score_count: Int
    var shoot_count: Int
    var assist_count: Int
    var miss_count: Int
    var save_count: Int
    var yellow_count: Int
    var red_count: Int
    
    init(id: String, number: Int, name: String) {
        self.id = id
        self.number = number
        self.name = name
        self.score_count = 0
        self.shoot_count = 0
        self.assist_count = 0
        self.miss_count = 0
        self.save_count = 0
        self.yellow_count = 0
        self.red_count = 0
    }
    
    func increaseScore() {
        self.score_count += 1
    }
    
    func decreaseScore() {
        if self.score_count > 0 {
            self.score_count -= 1
        }
    }
    
    func increaseShoot() {
        self.shoot_count += 1
    }
    
    func decreaseShoot() {
        if self.shoot_count > 0 {
            self.shoot_count -= 1
        }
    }
    
    func increaseAssist() {
        self.assist_count += 1
    }
    
    func decreaseAssist() {
        if self.assist_count > 0 {
            self.assist_count -= 1
        }
    }
    
    func increaseMiss() {
        self.miss_count += 1
    }
    
    func decreaseMiss() {
         if self.miss_count > 0 {
             self.miss_count -= 1
         }
     }
    
    func increaseSave() {
        self.save_count += 1
    }
    
    func decreaseSave() {
        if self.save_count > 0 {
            self.save_count -= 1
        }
    }
    
    func increaseYellow() {
        if self.yellow_count < 2{
            self.yellow_count += 1
        }
        
        if self.yellow_count == 2 {
            self.red_count = 1
        }
    }
    
    func decreaseYellow() {
        if self.yellow_count > 0 {
            self.yellow_count -= 1
        }
    }
    
    func increaseRed() {
        if self.red_count == 0{
            self.red_count = 1
        }
        
    }
    
    func decreaseRed() {
        if self.red_count == 1 {
            self.red_count = 0
        }
    }
}


class RecordGameController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate, UIPickerViewDataSource {
    
    var thisGame: Game? = nil
    private var timerIsRunning: Bool = false
    private var time: Double = 0.0
    private var timer: Timer = Timer()
    private var regulationTime:Double = 0.0
    private var myTeam:Team?
    private var yourTeam: Team?
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
    
    
    //多分tableViewが毎回走ることでエラーを起こしている
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        
        let Label = cell.contentView.viewWithTag(6) as!UILabel
        Label.text = String(playDataObjectArray[indexString]!.score_count)
        
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
        memberSelectPickerView.delegate = self
        memberSelectPickerView.dataSource = self
        
        if let _thisGame = thisGame {
            myTeam = recordGameInstance.searchTeam(teamId: _thisGame.my_team_id)
            
            if let _myTeam = myTeam {
                for (index,member) in _myTeam.members.enumerated(){
                    let tmpPlayData: PlayDataObject = PlayDataObject(id: member.id, number: member.number, name: member.name)
                    idAndIndexPath[index] = member.id
                    let _ = addPlayDataObjectArray(indexString: member.id, tmpPlayData: tmpPlayData)
                }
                setTeamInfomation(team: _myTeam)
            }
            
//            yourTeam = recordGameInstance.searchTeam(teamId: _thisGame.your_team_id)!
            regulationTime = Double(_thisGame.regulation_time)
            initializeTimer(regulationTime: regulationTime)
            
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
        print(selectedMemberByPicker)
        updateSelectedMemberInfomation()
        
    }
    
    // 最初に選択状態にする行データ
    func pickerView(_ pickerView: UIPickerView,titleForRow row: Int,forComponent component: Int) -> String? {
        let splitComponents = pickerNameAndNumberArray[row].components(separatedBy: ":")
        return splitComponents[1]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegateの設定
        memberSelectPickerView.delegate = self
        memberSelectPickerView.dataSource = self
        
        if let _thisGame = thisGame {
            myTeam = recordGameInstance.searchTeam(teamId: _thisGame.my_team_id)
            
            if let _myTeam = myTeam {
                for (index,member) in _myTeam.members.enumerated(){
                    let tmpPlayData: PlayDataObject = PlayDataObject(id: member.id, number: member.number, name: member.name)
                    idAndIndexPath[index] = member.id
                    let _ = addPlayDataObjectArray(indexString: member.id, tmpPlayData: tmpPlayData)
                }
                setTeamInfomation(team: _myTeam)
            }
            
//            yourTeam = recordGameInstance.searchTeam(teamId: _thisGame.your_team_id)!
            regulationTime = Double(_thisGame.regulation_time)
            initializeTimer(regulationTime: regulationTime)
            
        }else{
            print("failed to game infomation")
        }
    
        updateTimerDisplay()
        
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
                let numberAndName:String = member.id + ":" + String(member.number) + " " + String(member.name)
                pickerNameAndNumberArray.append(numberAndName)
            }
            selectedMemberByPicker = pickerNameAndNumberArray[0]
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
    
    func addPlayDataObjectArray(indexString:String,tmpPlayData:PlayDataObject)->Int{
        playDataObjectArray[indexString] = tmpPlayData
        return playDataObjectArray.count
    }
    
    func updateSelectedMemberInfomation(){
        let splitComponents = selectedMemberByPicker.components(separatedBy: ":")
        
        //背番号を取得
        if let idString = splitComponents.first {
            if let selectedMemberDatum = playDataObjectArray[idString] {
                selectedMemberScoreLabel.text = String(selectedMemberDatum.score_count)
                selectedMemberShootLabel.text = String(selectedMemberDatum.shoot_count)
                selectedMemberAssistLabel.text = String(selectedMemberDatum.assist_count)
                selectedMemberScoreLateLabel.text = String(selectedMemberDatum.score_count)
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
        let cell = dataDisplayTableView.cellForRow(at: indexPath)
        return cell
    }
    
    
    //スクロールした時の処理を記述する
    func updateDisplayDataTableView(){
        
        
        if let _myTeam = myTeam, let data = getPlayDataToChange(){
            let rowsCount = _myTeam.members.count
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

                        let Label = cell.contentView.viewWithTag(6) as!UILabel
                        Label.text = String(data.score_count)

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
    
    //スクロール中の処理
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        updateDisplayDataTableView()
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
        updateSelectedMemberInfomation()
        updateDisplayDataTableView()

    }
    
    @IBAction func scoreMinusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
            playData.decreaseScore()
            
        }
        updateSelectedMemberInfomation()
        updateDisplayDataTableView()
    }
    
    @IBAction func shootPlusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
                playData.increaseShoot()
        }
        updateSelectedMemberInfomation()
        updateDisplayDataTableView()
    }
    
    @IBAction func shootMinusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
            playData.decreaseShoot()
        }
        updateSelectedMemberInfomation()
        updateDisplayDataTableView()
    }
    
    @IBAction func assistPlusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
            playData.increaseAssist()
        }
        updateSelectedMemberInfomation()
        updateDisplayDataTableView()
    }
    
    @IBAction func assistMinusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
            playData.decreaseAssist()
        }
        updateSelectedMemberInfomation()
        updateDisplayDataTableView()
    }
    
    @IBAction func missPlusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
            playData.increaseMiss()
        }
        updateSelectedMemberInfomation()
        updateDisplayDataTableView()
    }
    
    @IBAction func missMinusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
            playData.decreaseMiss()
        }
        updateSelectedMemberInfomation()
        updateDisplayDataTableView()
    }
    
    @IBAction func savePlusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
            playData.increaseSave()
        }
        updateSelectedMemberInfomation()
        updateDisplayDataTableView()
    }
    
    @IBAction func saveMinusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
            playData.decreaseSave()
        }
        updateSelectedMemberInfomation()
        updateDisplayDataTableView()
    }
    
    @IBAction func yellowPlusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
            playData.increaseYellow()
        }
        updateSelectedMemberInfomation()
        updateDisplayDataTableView()
    }
    
    @IBAction func yellowMinusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
            playData.decreaseYellow()
        }
        updateSelectedMemberInfomation()
        updateDisplayDataTableView()
    }
    
    @IBAction func redPlusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
            playData.increaseRed()
        }
        updateSelectedMemberInfomation()
        updateDisplayDataTableView()
    }
    
    @IBAction func redMinusButtonTapped(_ sender: Any) {
        if let playData = getPlayDataToChange() {
            playData.decreaseRed()
        }
        updateSelectedMemberInfomation()
        updateDisplayDataTableView()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
