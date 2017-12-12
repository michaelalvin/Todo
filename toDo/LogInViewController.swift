//
//  LogInViewController.swift
//  toDo
//
//  Created by Michael Alvin on 6/8/17.
//  Copyright © 2017 Codepath. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class LogInViewController: UIViewController {
    
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func logInAction(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                if user != nil {
                    self.performSegue(withIdentifier: "segue", sender: self)
                } else {
                    
                    if let myError = error?.localizedDescription {
                        print(myError)
                    } else {
                        print("ERROR")
                    }
                }
                
            } )
            
        }
        
    }
    
    override func viewDidLoad() {
        
        
        //        segmentControl.tintColor = UIColor (colorLiteralRed: 0.8, green: 0.2, blue: 0.3, alpha: 0.9)
        
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
