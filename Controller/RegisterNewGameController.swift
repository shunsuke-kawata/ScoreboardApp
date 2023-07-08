//
//  RegisterNewGameController.swift
//  Scoreboard
//
//  Created by 川田隼輔 on 2023/07/08.
//

import Foundation
import UIKit

class RegisterNewGameController:UIViewController{
    
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
