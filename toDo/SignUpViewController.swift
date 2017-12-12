//
//  SignUpViewController.swift
//  toDo
//
//  Created by Michael Alvin on 6/18/17.
//  Copyright © 2017 Codepath. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    @IBAction func signUp(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: email.text!, password: password.text!, completion: { (user, error) in
            
            if user != nil {
                let databaseRef = Database.database().reference()
                let storageRef = Storage.storage().reference()
                let userInfo = ["email": self.email.text!, "uid": user?.uid, "photoURL": "N/A", "Ideas": [String](), "username": self.username.text!, "firstname": self.firstName.text!, "lastname": self.lastName.text!,] as [String : Any]
                let userRef = databaseRef.child("users").child((user?.uid)!)
                userRef.setValue(userInfo)
                
                self.performSegue(withIdentifier: "segue0", sender: self)
            } else {
                
                if let myError = error?.localizedDescription {
                    print(myError)
                } else {
                    print("ERROR")
                }
            }
            
        } )
    }
    
    
    override func viewDidLoad() {
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
