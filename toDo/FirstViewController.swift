//
//  FirstViewController.swift
//  toDo
//
//  Created by Michael Alvin on 5/27/17.
//  Copyright © 2017 Codepath. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableViewController: UITableView!
    
    var list = [String]()
    var list2 = [String]()
    var list3 = [String]()
    
    func getListFromFirebase() {
        let ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
        ref.child("users").child(userID!).child("Ideas").queryOrderedByKey().observe(.childAdded, with: {
            snapshot in
            
            let snapshotValue = snapshot.value as? NSDictionary
            let date = snapshotValue?["date"] as? String
            let idea = snapshotValue?["note"] as? String
            let note = snapshotValue?["note2"] as? String
            print(idea!)
            print(date!)
            print(note!)
            
            if idea != nil {
                self.list.append(idea!)
            }
            
            if date != nil {
                self.list2.append(date!)
            }
            
            if note != nil {
                if(note != ""){
                self.list3.append("*Note: " + note!)
                } else {
                
                self.list3.append(note!)
                }
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (list.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("d")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        cell.taskLabel.text = list[indexPath.row]
        
        cell.dateLabel.text = list2[indexPath.row]
        
        cell.noteLabel.text = list3[indexPath.row]
        
        return(cell)
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle:
        UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        print("c")
        if editingStyle == UITableViewCellEditingStyle.delete{
            list.remove(at: indexPath.row)
            myTableViewController.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        myTableViewController.reloadData()
    }
    
    
    override func viewDidLoad() {
        getListFromFirebase()
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        self.title = nil;
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
}

