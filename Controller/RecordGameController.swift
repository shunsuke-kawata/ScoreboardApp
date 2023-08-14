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
    private var playDataMatrix:[Dictionary<String,Any>] = []
    
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
            
            if let _myTeam = myTeam{
                InitializePlayDataMatrix(team: _myTeam)
            }else{
                print("failed to initialize play data")
            }
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
    
    func InitializePlayDataMatrix(team:Team){
        
        for member in team.members {
            let tmpDict:Dictionary<String,Any> = [
                "id":member.id,
                "number":member.number,
                "name":member.name,
                "score_count":0,
                "shoot_count":0,
                "assist_count":0,
                "miss_count":0,
                "save_count":0,
                "yellow_count":0,
                "red_count":0
            ]
            playDataMatrix.append(tmpDict)
        }
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


