//
//  RecordPageViewController.swift
//  Scoreboard
//
//  Created by 川田隼輔 on 2023/08/18.
//

import Foundation
import UIKit

let halfFlagTaple:[(flag:Int,value:String)] = [(1,"前半"),(2,"後半")]
//ゲームの登録に使用する変数
var time: Double = 0.0
var timerAIsRunning:Bool = false
var timerBIsRunning:Bool = false
var selectedHalf = halfFlagTaple[0]
var myTeamScoreDataArray:[ScoreDataObject] = []
var yourTeamScoreDataArray:[ScoreDataObject] = []
var myPlayDataObjectArray:Dictionary<String,PlayDataObject> = [:]
var yourPlayDataObjectArray:Dictionary<String,PlayDataObject> = [:]
var registeredGame: Game? = nil
var myTeam:Team? = nil
var yourTeam:Team? = nil
var myIdAndIndexPath:Dictionary<Int,String> = [:]
var yourIdAndIndexPath:Dictionary<Int,String> = [:]


class RecordPageViewController:UIPageViewController{
    
    let recordGameInstance = RecordGameModel()
    
    // PageViewで表示するViewControllerを格納する配列を定義
    private var controllers: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initPageViewController()
    }
    private func initPageViewController() {

        let storyboard = UIStoryboard(name: "RecordGame", bundle: nil)
            // ② PageViewControllerで表示するViewControllerをインスタンス化する
        let recordTeamA = storyboard.instantiateViewController(withIdentifier: "RecordGameAController") as! RecordGameAController
        let recordTeamB = storyboard.instantiateViewController(withIdentifier: "RecordGameBController") as! RecordGameBController
        recordTeamA.thisGame = registeredGame
        recordTeamB.thisGame = registeredGame
        
        //試合時間を初期化
        if let _registeredGame = registeredGame {
            time = Double(_registeredGame.regulation_time)*60
            myTeam = recordGameInstance.searchTeam(teamId: _registeredGame.my_team_id)
            yourTeam = recordGameInstance.searchTeam(teamId: _registeredGame.your_team_id)
            myPlayDataObjectArray = [:]
            yourPlayDataObjectArray = [:]
            
            if let _myTeam = myTeam {
                for (index,member) in _myTeam.members.enumerated(){
                    let tmpPlayData: PlayDataObject = PlayDataObject(id: member.id, number: member.number, name: member.name)
                    myIdAndIndexPath[index] = member.id
                    let _ = addMyPlayDataObjectArray(indexString: member.id, tmpPlayData: tmpPlayData)
                }
            }
            
            if let _yourTeam = yourTeam {
                for (index,member) in _yourTeam.members.enumerated(){
                    let tmpPlayData: PlayDataObject = PlayDataObject(id: member.id, number: member.number, name: member.name)
                    yourIdAndIndexPath[index] = member.id
                    let _ = addYourPlayDataObjectArray(indexString: member.id, tmpPlayData: tmpPlayData)
                }
//                setTeamInfomation(team: _yourTeam)
            }

        }
        // インスタンス化したViewControllerを配列に保存する
        self.controllers = [ recordTeamA,recordTeamB ]

        // 最初に表示するViewControllerを指定する
        setViewControllers([self.controllers[0]], direction: .forward, animated: true, completion: nil)
       
        // PageViewControllerのDataSourceを関連付ける
        self.dataSource = self
    }
    
    func addMyPlayDataObjectArray(indexString:String,tmpPlayData:PlayDataObject)->Int{
        myPlayDataObjectArray[indexString] = tmpPlayData
        return myPlayDataObjectArray.count
    }
    
    func addYourPlayDataObjectArray(indexString:String,tmpPlayData:PlayDataObject)->Int{
        yourPlayDataObjectArray[indexString] = tmpPlayData
        return yourPlayDataObjectArray.count
    }
}

extension RecordPageViewController: UIPageViewControllerDataSource {
    
    /// ページ数
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.controllers.count
    }
    
    /// 左にスワイプ（進む）
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = self.controllers.firstIndex(of: viewController),
           index < self.controllers.count - 1 {
            return self.controllers[index + 1]
        } else {
            return nil
        }
    }
    
    /// 右にスワイプ （戻る）
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = self.controllers.firstIndex(of: viewController),
           index > 0 {
            return self.controllers[index - 1]
        } else {
            return nil
        }
    }
}
