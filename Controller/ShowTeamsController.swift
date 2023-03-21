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
    
    let dispatchQueue = DispatchQueue(label: "queue")
    
    var showTeamInstance:ShowTeamsModel?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        print("start")
        let fetchedData = showTeamInstance?.fetchAllTeamsData()
        print(fetchedData!)
        showTeamInstance?.createDisplayTeamData(allFetchedData: fetchedData!)
        
//        let db = Firestore.firestore()
//        let documentRef = db.collection("teams")
//        var allFetchedData:[Dictionary<String,Any>] = []
//        //documentRefからsnapshotでデータを取得する
//        documentRef.getDocuments(){ (querySnapshot, error) in
//            if let error = error {
//                print("Error getting documents: \(error)")
//            } else {
//                for document in querySnapshot!.documents {
//                    //ドキュメントから取得してきたデータ
//                    let documentData = document.data()
//                    allFetchedData.append(documentData)
//                }
//            }
//        }
//        print(allFetchedData)
        
    }
    
    @IBOutlet weak var testLabel: UILabel!
    
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
