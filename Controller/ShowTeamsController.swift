//
//  RegisterTeamController.swift
//  Scoreboard
//
//  Created by 川田　隼輔 on 2023/03/14.
//

//Mainを操作するcontrollerの役割
import UIKit
import Firebase
import FirebaseFirestore

class ShowTeamsController:UIViewController{
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    @IBOutlet weak var titlelabel:UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var newTeamButton: UIButton!
    
    @IBAction func newTeamButtonTapped(_ sender: Any){
        let storyboard = UIStoryboard(name: "RegisterNewTeam", bundle: nil)
        
                let registerNewTeamController = storyboard.instantiateViewController(withIdentifier: "RegisterNewTeamController")
        
                //navigationControllerクラスがない場合はメソッドそのものが呼び出されない
                self.navigationController?.pushViewController(registerNewTeamController, animated: true)
    }
    @IBAction func backButtonTapped(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)
        }
}
