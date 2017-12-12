//
//  ThirdViewController.swift
//  toDo
//
//  Created by Michael Alvin on 6/6/17.
//  Copyright © 2017 Codepath. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

var emailOfSee = String()
var OtherID = String()

class ThirdViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var ProfileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var button1Label: UIButton!
    
    @IBOutlet weak var button2Label: UIButton!
    
    @IBOutlet weak var button3Label: UIButton!
    
    @IBOutlet weak var logOutButtone: UIButton!
    
    let storageRef = Storage.storage().reference()
    
    let databaseRef = Database.database().reference()
    
    @IBAction func logOutAction(_ sender: Any) {
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "segue2", sender: self)
    }
    
    @IBAction func changeIconButton(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print("Camera not available")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageUrl          = info[UIImagePickerControllerReferenceURL] as? NSURL
        let imageName         = imageUrl?.lastPathComponent
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let photoURL          = NSURL(fileURLWithPath: documentDirectory)
        let localPath         = photoURL.appendingPathComponent(imageName!)
        
        ProfileImage.image = image
        ProfileImage.contentMode = .scaleAspectFill
        
        //        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        //
        //        changeRequest?.photoURL = photoURL as URL
        //
        //        changeRequest?.commitChanges { (error) in
        //            let curUser = Auth.auth().currentUser
        //            let databaseRef = Database.database().reference()
        //            let photoInfo = String(describing: curUser?.photoURL)
        //            let userRef = databaseRef.child("users").child((curUser?.uid)!).child("photoURL")
        //            userRef.setValue(photoInfo)
        //        }
        
        saveChanges()
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func saveChanges(){
        
        let imageName = NSUUID().uuidString
        
        let storedImage = storageRef.child("profile_images").child(imageName)
        
        if let uploadData = UIImagePNGRepresentation(self.ProfileImage.image!)
        {
            storedImage.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil{
                    print(error!)
                    return
                }
                
                storedImage.downloadURL(completion: { (url, error) in
                    if error != nil{
                        print(error!)
                        return
                    }
                    if let urlText = url?.absoluteString{
                        self.databaseRef.child("users").child((Auth.auth().currentUser?.uid)!).updateChildValues(["pic" : urlText], withCompletionBlock: { (error, ref) in
                            if error != nil{
                                print(error!)
                                return
                            }
                        })
                    }
                })
                
            })
 
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        setupProfile()
        
        super.viewDidLoad()
    }
    
    func setupProfile(){
        circularImage()
        if let uid = Auth.auth().currentUser?.uid{
            databaseRef.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dict = snapshot.value as? [String: AnyObject]
                {
                    let username = dict["username"] as? String
                    self.nameLabel.text = username
                    
                    let email = dict["email"] as? String
                    self.emailLabel.text = email
                    
                    if let profileImageURL = dict["pic"] as? String
                    {
                        let url = URL(string: profileImageURL)
                        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                            if error != nil{
                                print(error!)
                                return
                            }
                            DispatchQueue.main.async {
                                
                                self.ProfileImage?.image = UIImage(data: data!)
                                self.ProfileImage.contentMode = .scaleAspectFill
                                
                                
                            }
                        }).resume()
                    }
                }
            })
        }
    }
    
    func circularImage(){
        ProfileImage.layer.borderWidth = 1
        ProfileImage.layer.masksToBounds = false
        ProfileImage.layer.borderColor = UIColor.black.cgColor
        ProfileImage.layer.cornerRadius = ProfileImage.frame.height/2
        ProfileImage.clipsToBounds = true
    }
    
    @IBAction func ShareList(_ sender: Any) {
        let alert = UIAlertController(title: "Share", message: "Write the user ID of the person you want to share your list with:",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Allow", style: .default){
            (action: UIAlertAction!) -> Void in
            
            let textField = alert.textFields![0]
            
            //append to share child
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",style: .default) {
            (action: UIAlertAction!) -> Void in
        }
        
        alert.addTextField {
            (textField: UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func SeeOthersList(_ sender: Any){ //After you click request go to the new page with the list with back (same format)?
        //use key instead of email
        let alert = UIAlertController(title: "See", message: "Write the user ID of the person whose list you want to see:",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Request", style: .default){
            (action: UIAlertAction!) -> Void in
            
            if let alertTextField = alert.textFields?.first, alertTextField.text != nil {
                
                emailOfSee = (alertTextField.text!)
//                self.getListFromFirebase()
                self.performSegue(withIdentifier: "segue02", sender: self)
                
            } else {
                
                print("Not a valid email")
            }
            
//            let post = Post(note: textField.text!, time: NSDate())
//            
//            self.items.append(post)
//            
//            let postItemRef = self.ref.child((textField.text)!)
//            
//            postItemRef.setValue(post.toAnyObject())
            
            //self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",style: .default) {
            (action: UIAlertAction!) -> Void in
        }
        
        alert.addTextField {
            (textField: UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
//    func getListFromFirebase() {
//        print("a")
//        let ref = Database.database().reference()
//        
//        ref.child("users").queryOrderedByKey().observe(.childAdded, with: {
//            snapshot in
//            
//            print("b")
//            let snapshotValue = snapshot.value as? NSDictionary
//            let email = snapshotValue?["email"] as? String
//            
//            if (email == emailOfSee) {
//                OtherID = (snapshotValue?["uid"] as? String)!
//            }
//            
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//        
//    }
    
    
    
}
