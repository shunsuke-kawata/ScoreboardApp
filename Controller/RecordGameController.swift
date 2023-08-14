import Foundation
import UIKit

class RecordGameController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var thisGame: Game? = nil
    private var timerIsRunning: Bool = false
    private var time: Double = 0.0
    private var timer: Timer = Timer()
    private var regulationTime:Double = 0.0
    private var myTeam:Team?
    private var yourTeam: Team?
    private var playDataMatrix:[Dictionary<String,String>] = []
    
    let recordGameInstance = RecordGameModel()
    
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var resetTimerButton: UIButton!
    
    @IBOutlet weak var dataDisplayTableView: UITableView!
    
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
            let _ = addPlayDataMatrix(tmpDict: tmpDict)
            let numberLabel = cell.contentView.viewWithTag(1) as!UILabel
            numberLabel.text = tmpDict["number"]
            let nameLabel = cell.contentView.viewWithTag(2) as!UILabel
            nameLabel.text = tmpDict["name"]
            let scoreLabel = cell.contentView.viewWithTag(3) as!UILabel
            scoreLabel.text = tmpDict["score_count"]
            let shootLabel = cell.contentView.viewWithTag(4) as!UILabel
            shootLabel.text = tmpDict["shoot_count"]
            let assistLabel = cell.contentView.viewWithTag(5) as!UILabel
            assistLabel.text = tmpDict["assist_count"]
            
            
            let Label = cell.contentView.viewWithTag(6) as!UILabel
            Label.text = tmpDict["id"]
            
            let missLabel = cell.contentView.viewWithTag(7) as!UILabel
            missLabel.text = tmpDict["miss_count"]
            let saveLabel = cell.contentView.viewWithTag(8) as!UILabel
            saveLabel.text = tmpDict["save_count"]
            let yellowLabel = cell.contentView.viewWithTag(9) as!UILabel
            yellowLabel.text = tmpDict["yellow_count"]
            let redLabel = cell.contentView.viewWithTag(10) as!UILabel
            redLabel.text = tmpDict["red_count"]
            
            
        }
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let _thisGame = thisGame {
            myTeam = recordGameInstance.searchTeam(teamId: _thisGame.my_team_id)!
//            yourTeam = recordGameInstance.searchTeam(teamId: _thisGame.your_team_id)!
            regulationTime = Double(_thisGame.regulation_time)
            InitializeTimer(regulationTime: regulationTime)
        }else{
            print("failed to get game infomation")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _thisGame = thisGame {
            myTeam = recordGameInstance.searchTeam(teamId: _thisGame.my_team_id)!
            
//            yourTeam = recordGameInstance.searchTeam(teamId: _thisGame.your_team_id)!
            regulationTime = Double(_thisGame.regulation_time)
            InitializeTimer(regulationTime: regulationTime)
        }
        updateTimerDisplay()
    }
    
    func InitializeTimer(regulationTime:Double){
        self.time = regulationTime * 60
        timerButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func updateTimerDisplay() {
        let minutes = Int(self.time / 60)
        let seconds = Int(self.time) % 60
        let timerTitle = String(format: "%02d:%02d", minutes, seconds)
        timerButton.setTitle(timerTitle, for: .normal) // ボタンのタイトルを更新する
    }
    
    func addPlayDataMatrix(tmpDict:Dictionary<String,String>)->Int{
        playDataMatrix.append(tmpDict)
        return playDataMatrix.count
    }

    
    @IBAction func resetTimerButtonTapped(_ sender: Any) {
        InitializeTimer(regulationTime: regulationTime)
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
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


class DisplayDataTableViewCell:UITableViewCell{
}

