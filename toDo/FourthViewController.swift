//
//  FourthViewController.swift
//  toDo
//
//  Created by Michael Alvin on 6/6/17.
//  Copyright © 2017 Codepath. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class FourthViewController: UIViewController {
    
    
    @IBOutlet weak var settingsLabel: UILabel!
    
    @IBOutlet weak var changeBackground: UIButton!
    
    @IBOutlet weak var seeActivation: UIButton!
    
    @IBOutlet weak var organizeList: UIButton!
    
    @IBOutlet weak var changePassword: UIButton!
    
    @IBOutlet weak var eraseList: UIButton!

    @IBAction func changeBackgroundButton(_ sender: Any) {
    }
    
    @IBAction func seeActivationButton(_ sender: Any) {
        if let uid = Auth.auth().currentUser?.uid {
            let alert = UIAlertController(title: "User Identification", message: "Your uid is:" + uid,
                                          preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Okay!",style: .default) {
                (action: UIAlertAction!) -> Void in
            }
            
            alert.addAction(cancelAction)
            
            
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func organizeListButton(_ sender: Any) {
        
    }
    
    @IBAction func changePasswordButton(_ sender: Any) {
    }
    
    @IBAction func eraseListButton(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
