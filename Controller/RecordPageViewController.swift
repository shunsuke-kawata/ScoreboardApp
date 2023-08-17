//
//  RecordPageViewController.swift
//  Scoreboard
//
//  Created by 川田隼輔 on 2023/08/18.
//

import Foundation
import UIKit

class RecordPageViewController:UIPageViewController{
    
    // PageViewで表示するViewControllerを格納する配列を定義
    private var controllers: [UIViewController] = []
    var registeredGame: Game? = nil
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
        
//        let recordTeamB = storyboard.instantiateViewController(withIdentifier: "ThirdView") as! ThirdViewController

            // ③ インスタンス化したViewControllerを配列に保存する
            self.controllers = [ recordTeamA,recordTeamB ]

            // ④ 最初に表示するViewControllerを指定する
            setViewControllers([self.controllers[0]], direction: .forward, animated: true, completion: nil)
           
            // ④ PageViewControllerのDataSourceを関連付ける
            self.dataSource = self
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
