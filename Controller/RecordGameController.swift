//
//  RecordGameController.swift
//  Scoreboard
//
//  Created by 川田隼輔 on 2023/08/12.
//

import Foundation
import UIKit

//値渡しで送られてくるstring型のuuid


class RecordGameController:UIViewController{
    
    var thisGame:Game? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (thisGame != nil){
            print(thisGame!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
