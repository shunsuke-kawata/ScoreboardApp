//
//  ViewController.swift
//  Scoreboard
//
//  Created by 川田　隼輔 on 2022/11/17.
//


//Mainを操作するcontrollerの役割
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var toRecordButton: UIButton!
    
    @IBOutlet weak var toRegisterTeamButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func transitionToRegisterTeam(_ sender : Any){
        let storyboard = UIStoryboard(name: "RegisterTeam", bundle: nil)
        
                let registerTeamController = storyboard.instantiateViewController(withIdentifier: "RegisterTeamController")
        
                //navigationControllerクラスがない場合はメソッドそのものが呼び出されない
                self.navigationController?.pushViewController(registerTeamController, animated: true)
        
    }
    @IBAction func transitionToRecord(_ sender : Any){
        print("record")
        let storyboard = UIStoryboard(name: "Records", bundle: nil)
        
                let registerTeamController = storyboard.instantiateViewController(withIdentifier: "ReacordTeamA")
        
                //navigationControllerクラスがない場合はメソッドそのものが呼び出されない
                self.navigationController?.pushViewController(registerTeamController, animated: true)
        
    }
    


}

