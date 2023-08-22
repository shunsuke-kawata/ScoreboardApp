//
//  ShowResultController.swift
//  Scoreboard
//
//  Created by 川田隼輔 on 2023/08/20.
//

import Foundation
import UIKit

class ShowResultController:UIViewController {
    
    var resultGameId:String = ""
    var scoreDataArray:[ScoreData] = []
    
    let showResultInstance = ShowResultModel()
    
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var myTeamNameLabel: UILabel!
    
    @IBOutlet weak var myTotalDisplayScoreLabel: UILabel!
    @IBOutlet weak var myTotalScoreLabel: UILabel!
    @IBOutlet weak var myTotalShootLabel: UILabel!
    @IBOutlet weak var myTotalAssistLabel: UILabel!
    @IBOutlet weak var myTotalScoreLateLabel: UILabel!
    @IBOutlet weak var myTotalMissLabel: UILabel!
    @IBOutlet weak var myTotalSaveLabel: UILabel!
    @IBOutlet weak var myTotalYellowLabel: UILabel!
    @IBOutlet weak var myTotalRedLabel: UILabel!
    
    @IBOutlet weak var yourTeamNameLabel: UILabel!
    
    @IBOutlet weak var yourTotalDisplayScoreLabel: UILabel!
    @IBOutlet weak var yourTotalScoreLabel: UILabel!
    @IBOutlet weak var yourTotalShootLabel: UILabel!
    @IBOutlet weak var yourTotalAssistLabel: UILabel!
    @IBOutlet weak var yourTotalScoreLateLabel: UILabel!
    @IBOutlet weak var yourTotalMissLabel: UILabel!
    @IBOutlet weak var yourTotalSaveLabel: UILabel!
    @IBOutlet weak var yourTotalYellowLabel: UILabel!
    @IBOutlet weak var yourTotalRedLabel: UILabel!
    
    @IBOutlet weak var topButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let result = showResultInstance.fetchResultData(gameId: resultGameId)
        
        if(result.flag){
            gameNameLabel.text = result.game?.title
            myTeamNameLabel.text = result.myTeamResult?.name
            yourTeamNameLabel.text = result.yourTeamResult?.name

            let compiledMyPlayData =  showResultInstance.compileShowResultData(playData: result.myPlayData)

            myTotalDisplayScoreLabel.text = String(compiledMyPlayData["allScore"]!)
            myTotalScoreLabel.text = String(compiledMyPlayData["allScore"]!)
            myTotalShootLabel.text = String(compiledMyPlayData["allShoot"]!)
            myTotalAssistLabel.text = String(compiledMyPlayData["allAssist"]!)
            if (compiledMyPlayData["allScore"]! == 0){
                myTotalScoreLateLabel.text = String(Double(compiledMyPlayData["allScore"]!)) + "%"
            }
            else if (compiledMyPlayData["allShoot"]! == 0){
                myTotalScoreLateLabel.text  = "error"
            }else{
                let scoreLate = round(Double(compiledMyPlayData["allScore"]!)/Double(compiledMyPlayData["allShoot"]!)*100)
                myTotalScoreLateLabel.text = String(scoreLate) + "%"
            }
            myTotalMissLabel.text = String(compiledMyPlayData["allMiss"]!)
            myTotalSaveLabel.text = String(compiledMyPlayData["allSave"]!)
            myTotalYellowLabel.text = String(compiledMyPlayData["allYellow"]!)
            myTotalRedLabel.text = String(compiledMyPlayData["allRed"]!)

            let compiledYourPlayData = showResultInstance.compileShowResultData(playData: result.yourPlayData)
            print(compiledYourPlayData)


            yourTotalDisplayScoreLabel.text = String(compiledYourPlayData["allScore"]!)
            yourTotalScoreLabel.text = String(compiledYourPlayData["allScore"]!)
            yourTotalShootLabel.text = String(compiledYourPlayData["allShoot"]!)
            yourTotalAssistLabel.text = String(compiledYourPlayData["allAssist"]!)
            if (compiledYourPlayData["allScore"]! == 0) {
                yourTotalScoreLateLabel.text = String(Double(compiledYourPlayData["allScore"]!)) + "%"
            } else if (compiledYourPlayData["allShoot"]! == 0) {
                yourTotalScoreLateLabel.text = "error"
            } else {
                let scoreLate = round(Double(compiledYourPlayData["allScore"]!) / Double(compiledYourPlayData["allShoot"]!) * 100)
                yourTotalScoreLateLabel.text = String(scoreLate) + "%"
            }
            yourTotalMissLabel.text = String(compiledYourPlayData["allMiss"]!)
            yourTotalSaveLabel.text = String(compiledYourPlayData["allSave"]!)
            yourTotalYellowLabel.text = String(compiledYourPlayData["allYellow"]!)
            yourTotalRedLabel.text = String(compiledYourPlayData["allRed"]!)
            
        }else{
            print("failed to get game result")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let result = showResultInstance.fetchResultData(gameId: resultGameId)
        
        if(result.flag){
            gameNameLabel.text = result.game?.title
            myTeamNameLabel.text = result.myTeamResult?.name
            yourTeamNameLabel.text = result.yourTeamResult?.name

            let compiledMyPlayData =  showResultInstance.compileShowResultData(playData: result.myPlayData)
            print(result.myPlayData)
            myTotalDisplayScoreLabel.text = String(compiledMyPlayData["allScore"]!)
            myTotalScoreLabel.text = String(compiledMyPlayData["allScore"]!)
            myTotalShootLabel.text = String(compiledMyPlayData["allShoot"]!)
            myTotalAssistLabel.text = String(compiledMyPlayData["allAssist"]!)
            if (compiledMyPlayData["allScore"]! == 0){
                myTotalScoreLateLabel.text = String(Double(compiledMyPlayData["allScore"]!)) + "%"
            }
            else if (compiledMyPlayData["allShoot"]! == 0){
                myTotalScoreLateLabel.text  = "error"
            }else{
                let scoreLate = round(Double(compiledMyPlayData["allScore"]!)/Double(compiledMyPlayData["allShoot"]!)*100)
                myTotalScoreLateLabel.text = String(scoreLate) + "%"
            }
            myTotalMissLabel.text = String(compiledMyPlayData["allMiss"]!)
            myTotalSaveLabel.text = String(compiledMyPlayData["allSave"]!)
            myTotalYellowLabel.text = String(compiledMyPlayData["allYellow"]!)
            myTotalRedLabel.text = String(compiledMyPlayData["allRed"]!)

            let compiledYourPlayData = showResultInstance.compileShowResultData(playData: result.yourPlayData)
            print(result.yourPlayData)
            
            yourTotalDisplayScoreLabel.text = String(compiledYourPlayData["allScore"]!)
            yourTotalScoreLabel.text = String(compiledYourPlayData["allScore"]!)
            yourTotalShootLabel.text = String(compiledYourPlayData["allShoot"]!)
            yourTotalAssistLabel.text = String(compiledYourPlayData["allAssist"]!)
            if (compiledYourPlayData["allScore"]! == 0) {
                yourTotalScoreLateLabel.text = String(Double(compiledYourPlayData["allScore"]!)) + "%"
            } else if (compiledYourPlayData["allShoot"]! == 0) {
                yourTotalScoreLateLabel.text = "error"
            } else {
                let scoreLate = round(Double(compiledYourPlayData["allScore"]!) / Double(compiledYourPlayData["allShoot"]!) * 100)
                yourTotalScoreLateLabel.text = String(scoreLate) + "%"
            }
            yourTotalMissLabel.text = String(compiledYourPlayData["allMiss"]!)
            yourTotalSaveLabel.text = String(compiledYourPlayData["allSave"]!)
            yourTotalYellowLabel.text = String(compiledYourPlayData["allYellow"]!)
            yourTotalRedLabel.text = String(compiledYourPlayData["allRed"]!)
            
        }else{
            print("failed to get game result")
        }
    }
    
    @IBAction func topButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ViewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
        UIView.transition(with: navigationController!.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.navigationController?.pushViewController(ViewController, animated: false)
                }, completion: nil)
    }
    
    
}
