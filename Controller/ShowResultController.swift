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
    
    let showResultInstance = ShowResultModel()
    
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let result = showResultInstance.fetchResultData(gameId: resultGameId)
        
        if(result.flag){
            myTeamNameLabel.text = result.myTeam?.name
            yourTeamNameLabel.text = result.yourTeam?.name
            
            let compiledMyPlayData =  showResultInstance.compileShowResultData(playData: result.myPlayData)
            
            myTotalScoreLabel.text = String(compiledMyPlayData["allScore"]!)
            myTotalShootLabel.text = String(compiledMyPlayData["allShoot"]!)
            myTotalAssistLabel.text = String(compiledMyPlayData["allAssist"]!)
            myTotalScoreLateLabel.text = String(Double(compiledMyPlayData["allScore"]!))
            myTotalMissLabel.text = String(compiledMyPlayData["allMiss"]!)
            myTotalSaveLabel.text = String(compiledMyPlayData["allSave"]!)
            myTotalYellowLabel.text = String(compiledMyPlayData["allYellow"]!)
            myTotalRedLabel.text = String(compiledMyPlayData["allRed"]!)
            
            let compiledYourPlayData = showResultInstance.compileShowResultData(playData: result.yourPlayData)

            yourTotalScoreLabel.text = String(compiledYourPlayData["allScore"]!)
            yourTotalShootLabel.text = String(compiledYourPlayData["allShoot"]!)
            yourTotalAssistLabel.text = String(compiledYourPlayData["allAssist"]!)
            yourTotalScoreLateLabel.text = String(Double(compiledYourPlayData["allScore"]!))
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
            myTeamNameLabel.text = result.myTeam?.name
            yourTeamNameLabel.text = result.yourTeam?.name
            
            let compiledMyPlayData =  showResultInstance.compileShowResultData(playData: result.myPlayData)
            
            myTotalDisplayScoreLabel.text = String(compiledMyPlayData["allScore"]!)
            myTotalScoreLabel.text = String(compiledMyPlayData["allScore"]!)
            myTotalShootLabel.text = String(compiledMyPlayData["allShoot"]!)
            myTotalAssistLabel.text = String(compiledMyPlayData["allAssist"]!)
            myTotalScoreLateLabel.text = String(Double(compiledMyPlayData["allScore"]!))
            myTotalMissLabel.text = String(compiledMyPlayData["allMiss"]!)
            myTotalSaveLabel.text = String(compiledMyPlayData["allSave"]!)
            myTotalYellowLabel.text = String(compiledMyPlayData["allYellow"]!)
            myTotalRedLabel.text = String(compiledMyPlayData["allRed"]!)
            
            let compiledYourPlayData = showResultInstance.compileShowResultData(playData: result.yourPlayData)
            
            
            yourTotalDisplayScoreLabel.text = String(compiledYourPlayData["allScore"]!)
            yourTotalScoreLabel.text = String(compiledYourPlayData["allScore"]!)
            yourTotalShootLabel.text = String(compiledYourPlayData["allShoot"]!)
            yourTotalAssistLabel.text = String(compiledYourPlayData["allAssist"]!)
            yourTotalScoreLateLabel.text = String(Double(compiledYourPlayData["allScore"]!))
            yourTotalMissLabel.text = String(compiledYourPlayData["allMiss"]!)
            yourTotalSaveLabel.text = String(compiledYourPlayData["allSave"]!)
            yourTotalYellowLabel.text = String(compiledYourPlayData["allYellow"]!)
            yourTotalRedLabel.text = String(compiledYourPlayData["allRed"]!)
            
        }else{
            print("failed to get game result")
        }
    }
    
}
