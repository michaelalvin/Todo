//
//  SecondViewController.swift
//  toDo
//
//  Created by Michael Alvin on 5/27/17.
//  Copyright © 2017 Codepath. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class SecondViewController: UIViewController {
    
    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var inputText2: UITextField!
    
    @IBOutlet weak var inputText3: UITextField!
    
    let ref = Database.database().reference()
    
    @IBAction func addItem(_ sender: Any) {
        if(inputText.text != ""){
            let userID = Auth.auth().currentUser?.uid
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "MMMM d, h:mm a"
            let stringDate = dayTimePeriodFormatter.string(from: NSDate() as Date)
            print(stringDate)
            let key = ref.child("users").child(userID!).child("Ideas").childByAutoId()
            key.child("note").setValue(inputText.text!)
            
            if(inputText3.text != "") {
                key.child("date").setValue(inputText3.text!)
            } else {
                key.child("date").setValue(stringDate)
            }
        
            if(inputText2.text != "") {
                key.child("note2").setValue(inputText2.text!)
            } else {
                key.child("note2").setValue("")
            }
            
            
            
            inputText.text = ""
            inputText2.text = ""
            inputText3.text = ""
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        
        inputText.underlined()
        inputText2.underlined()
        inputText3.underlined()
        
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

