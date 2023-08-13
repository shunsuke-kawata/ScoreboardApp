import Foundation
import UIKit

class RecordGameController: UIViewController {
    
    var thisGame: Game? = nil
    private var timerIsRunning: Bool = false
    private var time: Double = 0.0
    private var timer: Timer = Timer()
    
    let recordGameInstance = RecordGameModel()
    
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let _thisGame = thisGame {
            let myTeam: Team = recordGameInstance.searchTeam(teamId: _thisGame.my_team_id)!
            let yourTeam: Team = recordGameInstance.searchTeam(teamId: _thisGame.your_team_id)!
            let regulationTime:Double = Double(_thisGame.regulation_time)
            setTimerSetting(regulationTime: regulationTime)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _thisGame = thisGame {
            let myTeam: Team = recordGameInstance.searchTeam(teamId: _thisGame.my_team_id)!
            let yourTeam: Team = recordGameInstance.searchTeam(teamId: _thisGame.your_team_id)!
            let regulationTime:Double = Double(_thisGame.regulation_time)
            setTimerSetting(regulationTime: regulationTime)
        }
        updateTimerDisplay()
    }
    
    func setTimerSetting(regulationTime:Double){
        self.time = regulationTime * 60
        let fontSize: CGFloat = 50.0
        timerButton.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        
    }
    func updateTimerDisplay() {
        let minutes = Int(self.time / 60)
        let seconds = Int(self.time) % 60
        
        let timerTitle = String(format: "%02d:%02d", minutes, seconds)
        timerButton.setTitle(timerTitle, for: .normal) // ボタンのタイトルを更新する
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
